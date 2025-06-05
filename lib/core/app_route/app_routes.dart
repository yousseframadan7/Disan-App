import 'package:disan/features/auth/select_role/views/screens/select_role_screen.dart';
import 'package:disan/features/splash/views/screens/splash_screen.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/features/auth/forget_password/views/screens/forget_password_screen.dart';
import 'package:disan/features/auth/sign_in/views/screens/sign_in_screen.dart';
import 'package:disan/features/auth/sign_up/views/screens/sign_up_screen.dart';
import 'package:disan/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)>
  routes = <String, WidgetBuilder>{
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen: (context) => const OnBoardingScreen(),
    RouteNames.signUpScreen: (context) => const SignUpScreen(),
    RouteNames.signInScreen: (context) => const SignInScreen(),
    RouteNames.forgetPasswordScreen: (context) => const ForgetPasswordScreen(),
    RouteNames.selectRoleScreen: (context) => const SelectRoleScreen(),
  };
}
