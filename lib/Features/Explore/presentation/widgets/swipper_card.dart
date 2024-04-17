import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:realestate/core/utils/app_assets.dart';
import 'package:realestate/core/utils/app_color.dart';


class SwipperCard extends StatelessWidget {
   SwipperCard({super.key,this.size});
  Size? size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!.height * .24,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Swiper(
          itemCount: 3,
          duration: 2000,
          autoplay: true,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 10,
              child: Image.asset(
                AppAssets.bannerImages[index],
                fit: BoxFit.fill,
              ),
            );
          },
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(20),
              builder: DotSwiperPaginationBuilder(
                  color: AppColor.secondColor,
                  activeColor: AppColor.primaryColor)),
        ),
      ),
    );
  }
}
