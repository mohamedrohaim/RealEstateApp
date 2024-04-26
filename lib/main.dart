import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:realestate/Features/Auth/presentation/cubit/login_user_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_otp_forget_password_cubit.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Favorites/presentation/cubit/get_favorits_cubit.dart';
import 'package:realestate/core/app_routes/app_routes.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/helper/objectbox_interface.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'injection_container.dart' as di;
late ObjectBox objectBox;
void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  await CacheHelper.init();
   objectBox = await ObjectBox.create();
  //  APIHelper.addInterceptors();
  //DioHelper.initDio();
  var userId = CacheHelper.getData(key: 'UserID');
  bool? onBoarding = CacheHelper.getData(key: "OnBoarding");
  String startWidget;
  if (onBoarding != null) {
    if (userId != null) {
      startWidget = RouteName.layoutScreen;
    } else {
      startWidget = RouteName.loginScreen;
    }
  } else {
    startWidget = RouteName.onBoardingScreen;
  }
  await di.init();
  runApp(MyApp(
    startWidget: startWidget,
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String startWidget;
  const MyApp({super.key, required this.appRouter, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 706),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => LoginUserCubit()),
              BlocProvider(
                create: (_) => SendOtpForgetPasswordCubit(),
              ),
              BlocProvider(
                create: (context) => di.sl<GetUnitCubit>(),
              ),
              BlocProvider(create: (_) => di.sl<GetFavoritsCubit>()),
              //BlocProvider(create: (_)=>)
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              //  home: Onbording(),
              initialRoute: startWidget,
              onGenerateRoute: appRouter.generateRoute,
            ));
      },
    );
  }
}
