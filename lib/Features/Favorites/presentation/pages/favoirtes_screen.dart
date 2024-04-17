import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/Features/Favorites/presentation/cubit/get_favorits_cubit.dart';
import 'package:realestate/Features/Favorites/presentation/widgets/favoirt_item.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart' as di;

class FavoirtScreen extends StatefulWidget {
  const FavoirtScreen({super.key});

  @override
  State<FavoirtScreen> createState() => _FavoirtScreenState();
}

class _FavoirtScreenState extends State<FavoirtScreen> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var userId = CacheHelper.getData(key: 'UserID');
    return BlocProvider(
      create: (cotet) => di.sl<GetFavoritsCubit>()..getFavoirts(userId),
      child: BlocConsumer<GetFavoritsCubit, GetFavoritsState>(
        listener: (context, state) {
          if (state is GetFavoirtSuccess) {
            log('succes');
          } else if (state is GetFavoirtError) {
            log(state.favorts.toString());
          }
        },
        builder: (context, state) {
          return state is GetFavoirtSuccess
              ? state.favorts.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'There\'s no Favoirts Unit Right now ',
                          style: TextStyle(
                              color: AppColor.primaryColor, fontSize: 18.sp),
                        )),
                      ],
                    )
                  : ListView.separated(
                      controller: _controller,
                      padding:
                          EdgeInsets.only(top: 20, right: 10, left: 10),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          FavoritUnitItemWidget(
                            id: state.favorts[index].id,
                            image: state.favorts[index].image.toString(),
                            unitCategoryName:
                                state.favorts[index].unitCategoryName,
                            location:
                                state.favorts[index].location.toString(),
                            title: state.favorts[index].title.toString(),
                            price: state.favorts[index].price,
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.favorts.length)
              : CireProgressIndecatorWidget();

          // return BlocBuilder<GetFavoritsCubit, GetFavoritsState>(
          //     builder: (context, state) {
          //   if (state is GetFavoirtSuccess) {
          //     if (state.favorts.isEmpty) {
          //      return Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Center(child: Text('There\'s no Favoirts Unit Right now ',style: TextStyle(color: AppColor.primaryColor,fontSize: 18.sp),)),
          //         ],
          //       );
          //     }else{
          //              return Expanded(
          //         child: ListView.separated(
          //             controller: _controller,
          //             padding: EdgeInsets.only(top: 20, right: 10, left: 10),
          //             scrollDirection: Axis.vertical,
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) => FavoritUnitItemWidget(
          //                   id: state.favorts[index].id,
          //                   image: state.favorts[index].image.toString(),
          //                   unitCategoryName:
          //                       state.favorts[index].unitCategoryName,
          //                   location: state.favorts[index].location.toString(),
          //                   title: state.favorts[index].title.toString(),
          //                   price: state.favorts[index].price,
          //                 ),
          //             separatorBuilder: (context, index) => Divider(),
          //             itemCount: state.favorts.length));

          //     }
          //   }
          //   return CireProgressIndecatorWidget();
          // }
          // );
        },
      ),
    );
  }
}
