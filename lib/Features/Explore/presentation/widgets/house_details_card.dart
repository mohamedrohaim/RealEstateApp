import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/domain/use_cases/add_to_favoirt_usecase.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/widgets/building_details.dart';
import 'package:realestate/Features/Favorites/presentation/cubit/get_favorits_cubit.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/injection_container.dart' as di;

class HouseDetails extends StatefulWidget {
  final int price;
  final String title;
  final String location;
  final String unitCategoryName;
  final String yearBuilt, description;
  final int area;
  bool? isFavoirt;
  final int badrooms, bathrooms;
  final bool garage, garden;

  final int id;
  final String usrId;
  HouseDetails(
      {super.key,
      required this.price,
      required this.garden,
      required this.description,
      required this.title,
      required this.location,
      required this.unitCategoryName,
      this.isFavoirt,
      required this.yearBuilt,
      required this.area,
      required this.id,
      required this.usrId,
      required this.badrooms,
      required this.bathrooms,
      required this.garage});

  @override
  State<HouseDetails> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/Featured.png"),
                  Text(
                    "🏚 ${widget.unitCategoryName}",
                    style: const TextStyle(color: AppColor.greyColor),
                  ),
                  Text(
                    '\$ ${widget.price}',
                    style: const TextStyle(
                        color: AppColor.primaryColor, fontSize: 16),
                  ),
                  Text(
                    widget.title.split(' ').take(7).join(' '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              // BlocConsumer<GetUnitCubit, GetUnitState>(
              //   listener: (context, state) {
              //     // TODO: implement listener
              //   },
              //   builder: (context, state) {
              //     state is AddToFavortiIsloading?CireProgressIndecatorWidget():
              //   },
              // ),
              BlocProvider(
                  create: (context) => di.sl<GetUnitCubit>(),
                  child: BlocConsumer<GetUnitCubit, GetUnitState>(
                      builder: (context, state) {
                    return state is AddToFavortiIsloading
                        ? CireProgressIndecatorWidget()
                        : IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: widget.isFavoirt!
                                  ? Colors.red
                                  : AppColor.greyColor,
                            ),
                            onPressed: () {
                              if (widget.isFavoirt == false) {
                                BlocProvider.of<GetUnitCubit>(context)
                                    .addToFavoirt(widget.id, widget.usrId)
                                    .then((value) {
                                  setState(() {
                                    widget.isFavoirt = true;
                                  });
                                });
                              } else {
                                BlocProvider.of<GetFavoritsCubit>(context).removefromFavoirts(widget.usrId, widget.id);
                                setState(() {
                                  widget.isFavoirt = false;
                                });
                              }
                              // di
                              //     .sl<GetUnitCubit>()
                              //     .addToFavoirt(widget.id, widget.usrId);
                            });
                  }, listener: (context, state) {
                    if (state is AddtoFavoriteSuccesState) {
                      BlocProvider.of<GetUnitCubit>(context).showCustomDialog(
                          context, "Added to favorites successfully.", () {
                        Navigator.pop(context);
                      });
                      log('success');
                    } else if (state is AddtoFavoriteErrorState) {
                      log(state.error.toString());
                    }
                  }))
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_pin),
              Text(widget.location),
            ],
          ),
          Divider(
            thickness: 6,
          ),
          BuildingDetailsWidget(
            unitId: widget.id,
            description: widget.description,
            graden: widget.garden,
            type: widget.unitCategoryName,
            yearBuilt: widget.yearBuilt,
            area: widget.area,
            badrooms: widget.badrooms,
            bathrooms: widget.bathrooms,
            garage: widget.garage,
          )
        ],
      ),
    );
  }
}
