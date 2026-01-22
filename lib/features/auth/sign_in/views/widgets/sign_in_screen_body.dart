// ignore_for_file: prefer_interpolation_to_compose_strings


import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_body.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_header.dart';
import 'package:disan/features/auth/sign_in/views/widgets/sign_in_fields.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/gradiant_header.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/have_account_or_not.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/or_with_divider.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/social_sign.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class SignInScreenBody extends StatelessWidget {
  const SignInScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradiantHeader(),
        Column(
          children: [
            AuthHeader(
              title:LocaleKeys.welcome_back.tr(),// "Welcome Back! ",
              subtitle:LocaleKeys.welcome_back_details.tr(),// "Welcome back! please enter your details",
            ),
            Expanded(
              child: AuthBody(
                child: SingleChildScrollView(
                  child: BlocProvider(
                    create: (context) => SignInCubit(),
                    child: BlocListener<SignInCubit, SignInState>(
                      listener: (context, state) {
                        if (state is SignInFailure) {
                          quickAlert(
                            type: QuickAlertType.error,
                            text: state.message,
                            title: "Error",
                          );
                        }
                        if (state is SignInSuccess) {
                          context
                              .pushAndRemoveUntilScreen(RouteNames.homeScreen);
                          quickAlert(
                            type: QuickAlertType.success,
                            text:LocaleKeys.sign_in_successfully.tr(),// "Sign In Successfully",
                            title:LocaleKeys.success.tr(),// "Success",
                          );
                        }
                      },
                      child: Column(
                        children: [
                          SignInFields(),
                          const OrWithDivider(),
                          const SocialSign(),
                          SizedBox(height: SizeConfig.height * 0.01),
                          HaveAccountOrNot(
                              title:LocaleKeys.dont_have_account.tr(),// "Don't have an account",
                              btnText:LocaleKeys.sign_up.tr(),// "Sign Up",
                              onPressed: () {
                                getIt<CacheHelper>().getData(key: "role") ==
                                        "shop"
                                    ? context
                                        .pushScreen(RouteNames.shopSignUpScreen)
                                    : context.pushScreen(
                                        RouteNames.customerSignUpScreen);
                              }),
                          SizedBox(height: SizeConfig.height * 0.01),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
