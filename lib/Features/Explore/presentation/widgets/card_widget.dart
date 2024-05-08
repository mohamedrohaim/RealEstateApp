import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Explore/domain/entities/recent_entity.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart' as di;
import 'package:realestate/main.dart';
import 'package:realestate/objectbox.g.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.location,
      required this.price,
      required this.unitCategoryName});
  final String image;
  final String title;
  final String location;
  final String price;
  final String unitCategoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162.w,
      height: 330.h,
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        children: [
          //Image Container
          Container(
            width: 146.w,
            height: 146.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 18,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE57B00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Featured',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                          height: 0.14,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.house,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        unitCategoryName,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 10,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                          height: 0.14,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Color(0xFF006AE5),
                        fontSize: 12.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                        height: 0.12,
                        letterSpacing: 0.30,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      title.split(' ').take(4).join(' '),
                      style: TextStyle(
                        color: Color(0xFF121826),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        //height: 0.12,
                        // letterSpacing: 0.30,
                      ),
                    )
                  ],
                ),
                verticalSpace(15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 10,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 0.14,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardListView extends StatelessWidget {
  // final List<String> cardTitles =
  //     List.generate(10, (index) => 'Card ${index + 1}');

  CardListView({super.key});
  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: 'UserID');
    Box<RecentEntity> recentBox = objectBox.store.box<RecentEntity>();
    bool itemExists(int unitId) {
      final query = recentBox.query(RecentEntity_.uitId.equals(unitId)).build();
      final count = query.count();
      log('numeber of item,$count');
      return count > 0;
    }

    return BlocProvider(
      create: (context) => di.sl<GetUnitCubit>()
        ..getUnit(),
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
              if (state is GetUnitSuccessState) {
                if (state.units.isEmpty) {
                  return CireProgressIndecatorWidget();
                } else {
                  return GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1 / 1.88,
                      children: List.generate(
                        state.units.length,
                        (index) => InkWell(
                            onTap: () async {
                              RecentEntity recentEntity = RecentEntity(
                                  image: state.units[index].image.toString(),
                                  price: state.units[index].price.toString(),
                                  tite: state.units[index].title.toString(),
                                  uitId: state.units[index].id);
                              if (!itemExists(state.units[index].id)) {
                                recentBox.put(recentEntity);
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetialsScreen(
                                            id: state.units[index].id,
                                          )));
                            },
                            child: CardWidget(
                              image: state.units[index].image.toString(),
                              title: state.units[index].title,
                              location: state.units[index].location.toString(),
                              price: state.units[index].price.toString(),
                              unitCategoryName: state
                                  .units[index].unitCategoryName
                                  .toString(),
                            )),
                      ));
                }
              } else if (state is GetUnitErrorState) {
                return CircularProgressIndicator(
                  color: const Color.fromARGB(255, 27, 25, 25),
                );
              }
              return Center(child: const CireProgressIndecatorWidget());
            },
          );
        },
      ),
    );
  }
}
