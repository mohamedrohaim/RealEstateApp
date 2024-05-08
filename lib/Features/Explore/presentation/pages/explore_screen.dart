import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/Features/Explore/presentation/widgets/card_widget.dart';
import 'package:realestate/Features/Explore/presentation/widgets/house_category.dart';
import 'package:realestate/Features/Explore/presentation/widgets/swipper_card.dart';
import 'package:realestate/Features/Explore/presentation/widgets/viall_category.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';
import 'package:realestate/core/widgets/titles_text_widget.dart';
import 'package:realestate/injection_container.dart' as di;

class ExplorScreen extends StatefulWidget {
  const ExplorScreen({super.key});

  @override
  State<ExplorScreen> createState() => _ExplorScreenState();
}

class _ExplorScreenState extends State<ExplorScreen> {
  var searchController = TextEditingController();
//var tabController=TabController(length: 4,vsync: (){});
  int _selectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var controller = TextEditingController();
  void showCustomDialog(
    BuildContext context,
    String title,
    VoidCallback onpresed,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomFilterDialog(
            alretTitle: title,
            onPresed: onpresed,
            // sliderWidget: sliderWidget,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
                create: (context) => di.sl<GetUnitCubit>(),
                child: BlocConsumer<GetUnitCubit, GetUnitState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: size.width * .7,
                                  child: SearchBar(
                                    onChanged: (value) {
                                      if (CacheHelper.getData(
                                              key: 'location') ==
                                          true) {
                                        //search with location
                                        log('search with selected location');
                                        context
                                            .read<GetUnitCubit>()
                                            .searchFiter(
                                                value,
                                                CacheHelper.getData(
                                                    key: 'city'),
                                                null,
                                                null);
                                      } else if (CacheHelper.getData(
                                              key: 'range_selected') ==
                                          true) {
                                        //search with price only
                                        log('search with price range only');
                                        log(CacheHelper.getData(
                                                key: 'end_price')
                                            .toString());
                                        log(CacheHelper.getData(
                                                key: 'start_price')
                                            .toString());
                                        log(value.toString());
                                        context
                                            .read<GetUnitCubit>()
                                            .searchFiter(value, '', int.parse(CacheHelper.getData(key: 'start_price')), int.parse(CacheHelper.getData(key: 'end_price')));
                                      } else if (CacheHelper.getData(
                                                  key: 'location') ==
                                              true &&
                                          CacheHelper.getData(
                                                  key: 'range_selected') ==
                                              true) {
                                        //search with location and price range
                                        log('search with location and price range');
                                        context
                                            .read<GetUnitCubit>()
                                            .searchFiter(
                                                value,
                                                CacheHelper.getData(
                                                    key: 'city'),
                                                int.parse(CacheHelper.getData(
                                                    key: 'start_price')),
                                                CacheHelper.getData(
                                                    key: 'end_price'));
                                      } else {
                                        log('search with title');
                                        context
                                            .read<GetUnitCubit>()
                                            .searchFiter(value, '', null, null);
                                      }
                                    },
                                    controller: controller,
                                    hintText: "Search real estata",
                                    leading: const Icon(Icons.search),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showCustomDialog(context, "filter", () {
                                      if(CacheHelper.getData(key: 'range_selected')==true){
                                       // CacheHelper.removeData(key: 'range_selected');
                                        Navigator.pop(context);
                                      }
                                     else if (CacheHelper.getData(
                                          key: 'location')) {
                                        if (CacheHelper.getData(
                                                key: 'range_selected') ==
                                            false) {
                                          Navigator.pop(context);
                                        } else {
                                          CacheHelper.removeData(
                                              key: 'range_selected');
                                          Navigator.pop(context);
                                        }
                                      } else if (CacheHelper.getData(
                                                  key: 'location') ==
                                              true &&
                                          CacheHelper.getData(
                                                  key: 'range_selected') ==
                                              true) {
                                        log(CacheHelper.getData(
                                            key: 'range_selected').toString());
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.filter_alt_outlined),
                                )
                              ],
                            ),
                          ),
                          BlocBuilder<GetUnitCubit, GetUnitState>(
                              builder: (context, state) {
                            if (state is FiterSearchIsLoadingState) {
                              return const Center(
                                  child: CireProgressIndecatorWidget());
                            }
                            if (state is FiterSearchIsSuccessState) {
                              if (state.units.isNotEmpty) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetialsScreen(
                                                          id: state
                                                              .units[index].id,
                                                        )));
                                          },
                                          child: TitlesTextWidget(
                                            color: Colors.black.withOpacity(.5),
                                            label: state.units[index].title
                                                .toString(),
                                          ),
                                        ),
                                    separatorBuilder: (cotext, index) =>
                                        const Divider(),
                                    itemCount: state.units.length);
                              } else {
                                return TitlesTextWidget(
                                    label: 'No Units Found',
                                    color: Colors.black.withOpacity(.5));
                              }
                            } else if (state is FiterSearchIsErrorState) {
                              return Text(state.error.toString());
                            }
                            return Container();
                          })
                        ],
                      ),
                    );
                  },
                  listener: (context, state) {},
                )),
            verticalSpace(5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwipperCard(
                size: size,
              ),
            ),
            verticalSpace(10),
            DefaultTabController(
              length: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: TabBar(
                      labelColor: AppColor.whiteColor,
                      unselectedLabelColor: AppColor.secondColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(30), // Creates border
                          color: AppColor.primaryColor),
                      onTap: (index) {},
                      tabs: const [
                        Tab(
                          text: 'All',
                        ),
                        Tab(text: 'House'),
                        Tab(text: 'Villa'),
                        Tab(
                          text: 'Apartment',
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 370,
                    child: TabBarView(children: [
                      CardListView(),
                      HouseListView(),
                      VillaListView(),
                      // VillaWidget()
                      CardListView(),
                      //CardListView(),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
