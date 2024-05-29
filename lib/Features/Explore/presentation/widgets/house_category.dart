import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/Features/Explore/presentation/widgets/card_widget.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart'as di;

class HouseListView extends StatelessWidget {
  // final List<String> cardTitles =
  //     List.generate(10, (index) => 'Card ${index + 1}');

  HouseListView({super.key});
  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: 'UserID');
    return BlocProvider(
      create: (context) => di.sl<GetUnitCubit>()..getAndGroupUnits('Town House'),
      child: BlocConsumer<GetUnitCubit, GetUnitState>(
        listener: (context, state) {
          if (state is GetUnitSuccessState) {
            log(state.units.length.toString());
          } else if (state is GetUnitErrorState) {
            // log(state.error.toString());
          }
        },
        builder: (context, state) {
          return BlocBuilder<GetUnitCubit, GetUnitState>(
            builder: (context, state) {
              if (state is GetUnitIsloadingState) {
                return CireProgressIndecatorWidget();
              }
              if (state is GetUnitsByCategoryGrouped) {
                if (state.unitCategory.isEmpty) {
                  return Center(
                    child: Text("There is no House uploaded right now"      , style: TextStyle(
                                color: AppColor.primaryColor, fontSize: 18.sp),),
                  );
                } else {
                  return GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1 / 1.88,
                      children: state.unitCategory
              .expand((category) => category.units) // Flatten the list of units in all categories
              .map((unit) => InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetialsScreen(
                            id: unit.id,
                          ),
                        ),
                      );
                    },
                    child: CardWidget(
                      image: unit.image.toString(),
                      title: unit.title,
                      location: unit.location.toString(),
                      price: unit.price.toString(),
                      unitCategoryName: unit.unitCategoryName.toString(),
                    ),
                  ))
              .toList(),
                      );
                }
              } else if (state is GetUnitErrorState) {
                return CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              return const CireProgressIndecatorWidget();
            },
          );
        },
      ),
    );
  }
}
