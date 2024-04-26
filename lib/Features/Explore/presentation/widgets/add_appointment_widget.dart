import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';
import 'package:realestate/injection_container.dart' as di;
import 'package:intl/intl.dart';

class AddAppointmentWidget extends StatefulWidget {
  final int unitId;
  const AddAppointmentWidget({super.key, required this.unitId});

  @override
  State<AddAppointmentWidget> createState() => _AddAppointmentWidgetState();
}

class _AddAppointmentWidgetState extends State<AddAppointmentWidget> {
  DateTime dateSelected = DateTime.now();
   String selectedDateAndTime = '';
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    if (selectedTime == null) return null;
    DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
        .format(combinedDateTime.toUtc());
    setState(() {
      selectedDateAndTime = formattedDate;
    });
    return null;
  }


  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: 'UserID');
    return BlocProvider(
      create: (context) => di.sl<GetUnitCubit>(),
      child: BlocConsumer<GetUnitCubit, GetUnitState>(
        listener: (context, state) {
          if (state is AddAppointmentIsLoading) {
            log('loading');
          } else if (state is AddAppointmnetIsSuccess) {
            Get.offNamed(RouteName.layoutScreen);
          } else if (state is AddAppointmentIsError) {
            log('error');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              AppTextFormField(
                  hintText: 'whatsappNumber',
                  controller: phoneController,
                  type: TextInputType.phone,
                  validator: (String? value) {}),
              verticalSpace(10),
              AppTextFormField(
                  hintText: 'email',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validator: (String? value) {}),
              verticalSpace(10),
              Row(
                children: [
                  Text("${dateSelected.toLocal()}".split(' ')[0]),
                  SizedBox(
                    height: 20.0,
                  ),
                  IconButton(
                    onPressed: () => showDateTimePicker(
                        context: context,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                        initialDate: DateTime.now()),
                    icon: const Icon(Icons.date_range),
                  ),
                ],
              ),
              verticalSpace(10),
              state is AddAppointmentIsLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {
                        log(widget.unitId.toString());
                        log(selectedDateAndTime.toString());
                        BlocProvider.of<GetUnitCubit>(context).addAppointment(
                            selectedDateAndTime,
                            widget.unitId,
                            userId,
                            phoneController.text,
                            emailController.text,
                            true);
                      },
                      text: "Check Appointment",
                    ),
            ],
          );
        },
      ),
    );
  }
}
