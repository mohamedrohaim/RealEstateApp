import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/Features/Explore/presentation/widgets/expand_text_widget.dart';
import 'package:realestate/Features/Explore/presentation/widgets/model_bottom_sheet_widget.dart';
import 'package:realestate/core/helper/date_converter.dart';
import 'package:realestate/core/helper/map_unit_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildingDetailsWidget extends StatefulWidget {
  final String type;
  final String yearBuilt, description;
  final int area;
  final int badrooms, bathrooms, unitId;
  final bool garage, graden;
  const BuildingDetailsWidget(
      {super.key,
      required this.type,
      required this.description,
      required this.yearBuilt,
      required this.area,
      required this.badrooms,
      required this.bathrooms,
      required this.garage,
      required this.graden,
      required this.unitId});

  @override
  State<BuildingDetailsWidget> createState() => _BuildingDetailsWidgetState();
}

class _BuildingDetailsWidgetState extends State<BuildingDetailsWidget> {
  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(Uri.parse(uri.toString()))) {
      await launchUrl(Uri.parse(uri.toString()));
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Details",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            verticalSpace(5),
            Text(
              "      Building",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
            verticalSpace(10),
            Container(
                width: 343.h,
                height: 110.h,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColor.grey2Color),
                child: Column(
                  children: [
                    BuildingDataWidget(
                      details: widget.type,
                      type: "Type",
                    ),
                    Divider(),
                    BuildingDataWidget(
                      details: widget.yearBuilt,
                      type: "Year Built",
                    ),
                    Divider(),
                    BuildingDataWidget(
                      details: widget.area.toString(),
                      type: "Living Area",
                    )
                  ],
                )),
            verticalSpace(7),
            Text(
              "      Features",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
            verticalSpace(7),
            Container(
              width: 343.h,
              height: 110.h,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: AppColor.grey2Color),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: C,
                children: [
                  Row(
                    children: [
                      FeaturesBuildingWidget(
                        image: 'assets/bed_FILL0_wght400_GRAD0_opsz48.png',
                        featuredata: "${widget.badrooms} Beds",
                      ),
                      horizontalSpace(widget.garage ? 25 : 120),
                      FeaturesBuildingWidget(
                        image: 'assets/bathrooms.png',
                        featuredata: "${widget.bathrooms} Baths",
                      ),
                      widget.garage ? horizontalSpace(25) : SizedBox(),
                      widget.garage
                          ? const FeaturesBuildingWidget(
                              image:
                                  'assets/garage_FILL0_wght400_GRAD0_opsz48.png',
                              featuredata: "Grage",
                            )
                          : SizedBox(),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      FeaturesBuildingWidget(
                        image: 'assets/kitchen.png',
                        featuredata: "Kitchen",
                      ),
                      horizontalSpace(25),
                      FeaturesBuildingWidget(
                        image: 'assets/balcony.png',
                        featuredata: "Blacony",
                      ),
                      widget.graden ? horizontalSpace(25) : SizedBox(),
                      widget.graden
                          ? const FeaturesBuildingWidget(
                              image:
                                  'assets/yard_FILL0_wght400_GRAD0_opsz48.png',
                              featuredata: "Garden",
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(7),
            Text(
              "Descriptons",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            verticalSpace(7),
            Container(
              width: 343.h,
              height: 110.h,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: AppColor.grey2Color),
              child: SingleChildScrollView(
                  child: ExpandableText(
                widget.description,
                trimLines: 2,
              )),
            ),
            verticalSpace(10),
            Text(
              "Location",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            verticalSpace(5),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    // navigateTo(30.033333,31.233334);
                    MapUtils.openMapsSheet(context, Coords(30.033333,31.233334), 'Cairo');
                  },
                  child: Container(
                      height: 150.h,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration:
                          const BoxDecoration(color: AppColor.grey2Color),
                      child: Center(
                          child: Image.asset(
                              'assets/Animation - 1715071169846.gif'))),
                )),
            //Lottie.asset("assets/Animation - 1715071169846.json"),
            verticalSpace(5),
            CustomButton(
              onPressed: () {
                ModalBottomSheet.addAppointment(context, widget.unitId);
              },
              text: "Check Appointment",
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesBuildingWidget extends StatelessWidget {
  final String image;
  final featuredata;
  const FeaturesBuildingWidget({
    super.key,
    required this.image,
    required this.featuredata,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image),
        horizontalSpace(2),
        Text(
          featuredata,
          style: TextStyle(
              color: AppColor.detailstextColor,
              fontSize: 14.h,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class BuildingDataWidget extends StatelessWidget {
  const BuildingDataWidget(
      {super.key, required this.type, required this.details});
  final String type;
  final String details;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 14.h,
              fontWeight: FontWeight.w400),
        ),
        Text(
          details,
          style: TextStyle(
              color: AppColor.detailstextColor,
              fontSize: 14.h,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
