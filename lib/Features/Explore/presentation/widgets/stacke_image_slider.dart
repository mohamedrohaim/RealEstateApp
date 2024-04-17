import 'package:flutter/material.dart';
import 'package:realestate/core/utils/app_color.dart';

class StackedImageSlider extends StatefulWidget {
  final String image;

  const StackedImageSlider({super.key,required this.image});
  @override
  _StackedImageSliderState createState() => _StackedImageSliderState();
}

class _StackedImageSliderState extends State<StackedImageSlider> {
  int _currentPage = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: _pageController,
          children: [
            Image.network(widget.image.toString(), fit: BoxFit.fill),
            Image.network(widget.image.toString(), fit: BoxFit.fill),
            Image.network(widget.image.toString(), fit: BoxFit.fill),
            Image.network(widget.image.toString(), fit: BoxFit.fill),
            // Add more images here
          ],
        ),
        Positioned(
          top: 22,
          right: 2,
          left: 2,
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.grey2Color),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back))),
            actions: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.grey2Color),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded))),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColor.grey2Color,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              '${_currentPage + 1}/${3 + 1}', // Change 3 to the total number of images
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
