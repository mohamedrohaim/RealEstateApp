import 'dart:developer';

import 'package:build_runner/build_script_generate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';
import 'package:realestate/core/widgets/titles_text_widget.dart';
import 'package:realestate/injection_container.dart' as di;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    // var location = CacheHelper.getData(key: 'location');
    // var start_price = CacheHelper.getData(key: 'start_price');
    // var end_price = CacheHelper.getData(key: 'end_price');
    // var city = CacheHelper.getData(key: 'city');
    Size size = MediaQuery.of(context).size;
    // return Scaffold(
    //     body:
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<GetUnitCubit>(),
        child: BlocConsumer<GetUnitCubit, GetUnitState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * .7,
                          child: SearchBar(
                            onChanged: (value) {
                               context
                                    .read<GetUnitCubit>()
                                    .searchFiter(value, '', null, null);
                              
                            },
                            controller: controller,
                            hintText: "Search real estata",
                            leading: const Icon(Icons.search),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showCustomDialog(context, "filter", () {
                              Navigator.pop(context);
                            }
                            );
                          },
                          icon: const Icon(Icons.filter_alt_outlined),
                        )
                      ],
                    ),
                 
                  ),
                  BlocBuilder<GetUnitCubit, GetUnitState>(
                      builder: (context, state) {
                    if (state is FiterSearchIsLoadingState) {
                      return const Center(child: CireProgressIndecatorWidget());
                    }
                    if (state is FiterSearchIsSuccessState) {
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetialsScreen(
                                                id: state.units[index].id,
                                              )));
                                },
                                child: TitlesTextWidget(
                                  label: state.units[index].title.toString(),
                                ),
                              ),
                          separatorBuilder: (cotext, index) => const Divider(),
                          itemCount: state.units.length);
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
        ))
  ,
    );
  }
}
