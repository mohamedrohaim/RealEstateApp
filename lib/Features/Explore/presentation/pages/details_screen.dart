import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/widgets/house_details_card.dart';
import 'package:realestate/Features/Explore/presentation/widgets/stacke_image_slider.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/injection_container.dart' as di;

class DetialsScreen extends StatefulWidget {
  final int id;
  const DetialsScreen({
    super.key,
    required this.id,
  });
  @override
  State<DetialsScreen> createState() => _DetialsScreenState();
}

class _DetialsScreenState extends State<DetialsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // di.sl<GetUnitCubit>()..getUnitById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: 'UserID');
    return BlocProvider(
      create: (context) =>
          di.sl<GetUnitCubit>()..getUnitById(widget.id, userId)..createDatabase(),
      child:
          BlocConsumer<GetUnitCubit, GetUnitState>(listener: (context, state) {
        if (state is GetUnitByIdIsLoading) {
          log('loadding');
        } else if (state is GetUnitByIdSuccess) {
          log("success");
        } else if (state is GetUnitByIdErrorState) {
          log(state.error.toString());
        }
      }, builder: (context, state) {
        if (state is GetUnitByIdSuccess) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: 671,
                      height: 469,
                      child: StackedImageSlider(
                        image: state.unitByIDEntity.unit!.image.toString(),
                      )),
                  HouseDetails(
                    description: state.unitByIDEntity.unit!.description.toString(),
                     garden:state.unitByIDEntity.unit!.garden!,
                    garage: state.unitByIDEntity.unit!.garage!,
                    badrooms: state.unitByIDEntity.unit!.bedrooms!.toInt(),
                    usrId: userId,
                  id: state.unitByIDEntity.unit!.id!.toInt(),
                    area: state.unitByIDEntity.unit!.area!.toInt(),
                    yearBuilt: state.unitByIDEntity.unit!.dateBuilt.toString(),
                    price: state.unitByIDEntity.unit!.price!.toInt(),
                    location: state.unitByIDEntity.unit!.location.toString(),
                    title: state.unitByIDEntity.unit!.title.toString(),
                    unitCategoryName:
                        state.unitByIDEntity.unit!.unitCategoryName.toString(),
                    isFavoirt: state.unitByIDEntity.isFaorite ?? false, bathrooms: state.unitByIDEntity.unit!.bathrooms!.toInt(),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
            body: Column(
          children: [
            Center(child: CircularProgressIndicator())
            //HouseDetails(),
          ],
        ));
      }),
    );
  }
}
