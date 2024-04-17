import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Favorites/presentation/cubit/get_favorits_cubit.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart' as di;

class FavoritUnitItemWidget extends StatefulWidget {
  const FavoritUnitItemWidget(
      {super.key,
      required this.image,
      required this.unitCategoryName,
      required this.location,
      required this.title,
      required this.price,
      required this.id});
  final String image, unitCategoryName, location, title;
  final int price, id;
  @override
  State<FavoritUnitItemWidget> createState() => _FavoritUnitItemWidgetState();
}

class _FavoritUnitItemWidgetState extends State<FavoritUnitItemWidget> {
  bool isFavoirt = true;
  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: "UserID");
    return Container(
      height: 134.h,
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColor.grey2Color),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(widget.image),
                  width: 118.w,
                  height: 118.h,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('🏠${widget.unitCategoryName}'),
                      SizedBox(
                        width: 60,
                      ),
                      BlocProvider(
                        create: (context) => di.sl<GetFavoritsCubit>(),
                        child: BlocConsumer<GetFavoritsCubit, GetFavoritsState>(
                            builder: (context, state) {
                          return state is RemoveFavoritIsLoading
                              ? CireProgressIndecatorWidget()
                              : IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFavoirt ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () async {
                                    log(widget.id.toString());
                                    log(userId.toString());
                                    BlocProvider.of<GetFavoritsCubit>(context)
                                        .removefromFavoirts(userId, widget.id);
                                    // BlocProvider.of<GetFavoritsCubit>(context)
                                    //     .removefromFavoirts(userId, widget.id);
                                  },
                                );
                        }, listener: (context, state) {
                          if (state is RemoveFavoritIsLoading) {
                          } else if (state is RemovefavoirtSucces) {
                            BlocProvider.of<GetFavoritsCubit>(context)
                                .showCustomDialog(context,
                                    "Removed from favorites successfully.", () {
                              Navigator.pop(context);
                            });
                          } else if (state is RemoveFavoirtError) {
                            log(state.error.toString());
                          }
                        }),
                      )
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.favorite,
                      //     color: isFavoirt ? Colors.red : Colors.grey,
                      //   ),
                      //   onPressed: () async {
                      //     // BlocProvider.of<GetFavoritsCubit>(context)
                      //     //     .removefromFavoirts(userId, widget.id);
                      //   },
                      // )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("\$${widget.price}"),
                      Text(widget.title.split(' ').take(3).join(' ')),
                      verticalSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.location),
                          SizedBox(
                            width: 50,
                          ),
                          Image.asset("assets/Featured.png"),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
