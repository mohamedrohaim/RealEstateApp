import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Auth/presentation/pages/login_screen.dart';
import 'package:realestate/Features/onBoarding/data/models/content_model.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';

class Onbording extends StatefulWidget {
  const Onbording({key});
  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); // don't forget to call super.dispose()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(45),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        contents[i].images,
                        height: 350.h,
                      ),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black54),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 52.h,
            margin: const EdgeInsets.all(40),
            width: 343.w,
            color: Colors.white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  CacheHelper.saveData(key: 'OnBoarding', value: true)
                      .then((value) {
                    if (value) {
                      Get.offNamed(RouteName.loginScreen);
                    }
                  });
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  //use get
                  //Get.to(MaterialPageRoute(builder:(context)=>LoginScreen() ));
                  //Get.toNamed(RouteName.loginScreen);
                  //    N
                }
                _controller.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              child: Text(
                  currentIndex == contents.length - 1 ? "Get Started" : "Next",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
