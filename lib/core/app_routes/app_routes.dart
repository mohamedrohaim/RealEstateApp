import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/AI/presentation/cubit/predict_price_cubit.dart';
import 'package:realestate/Features/AI/presentation/pages/AI_form_screen.dart';
import 'package:realestate/Features/Auth/presentation/cubit/login_user_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/register_user_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_confirem_email_otp_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_ot_forge_t_password_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_otp_forget_password_cubit.dart';
import 'package:realestate/Features/Auth/presentation/pages/confirm_email_screen.dart';
import 'package:realestate/Features/Auth/presentation/pages/confrim_otp_forget_password.dart';
import 'package:realestate/Features/Auth/presentation/pages/login_screen.dart';
import 'package:realestate/Features/Auth/presentation/pages/register_screen.dart';
import 'package:realestate/Features/Auth/presentation/pages/reset_password_screen.dart';
import 'package:realestate/Features/Auth/presentation/pages/send_OTp_forget_Password.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/details_screen.dart';
import 'package:realestate/Features/layout/presentation/cubit/layout_cubit.dart';
import 'package:realestate/Features/layout/presentation/pages/layout_screen.dart';
import 'package:realestate/Features/onBoarding/presentation/pages/on_borading_screen.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/injection_container.dart' as di;

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case RouteName.onBoardingScreen:
        return MaterialPageRoute(builder: (context) => const Onbording());
      case RouteName.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginUserCubit(),
                  child: LoginScreen(),
                ));
      case RouteName.sendOtpRestPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SendOtpForgetPasswordCubit(),
                  child: const SendOtpRestPassword(),
                ));
      case RouteName.registerScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => RegisterUserCubit(),
                  child: RegisterScreen(),
                ));
      case RouteName.confrimEmailScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SendConfiremEmailOtpCubit(),
                  child: ConfrimEmailScreen(
                    email: args['email'] as String,
                    token: args['token'] as String,
                  ),
                ));
      case RouteName.confirmOTPForgetPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SendOtForgeTPasswordCubit(),
                  child: ConfirmOTPForgetPassword(
                    emial: arguments as String,
                  ),
                ));
      case RouteName.layoutScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LayoutCubit(),
                  child:  LayoutScreen(),
                ));
      case RouteName.detialsScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        var userId = CacheHelper.getData(key: "UserID");
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => di.sl<GetUnitCubit>(),
                  child: DetialsScreen(
                    id: args['id'],
                  ),
                ));
      case RouteName.aIFormScreem:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => PredictPriceCubit(),
                  child: const AIFormScreem(),
                ));
      case RouteName.restPasswordScreen:
        var args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>SendOtForgeTPasswordCubit(),
                  child: RestPasswordScreen(
                    email: args['email'],
                    token: args['token'],
                    otp: args['otp'],
                  ),
                ));
    }
    return null;
  }
}
