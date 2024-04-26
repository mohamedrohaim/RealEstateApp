import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/Features/Explore/presentation/widgets/add_appointment_widget.dart';

class ModalBottomSheet {
  static void addAppointment(BuildContext context, int unitId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: 428.w,
                height: 441.h,
                padding: const EdgeInsets.all(20),
                child: AddAppointmentWidget(unitId:unitId ,)
              ),
            ),
          );
        });
  }
}
