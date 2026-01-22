import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_body.dart';
import 'package:disan/features/auth/shop_sign_up/view_models/cubit/shop_sign_up_cubit.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/gradiant_header.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/have_account_or_not.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/or_with_divider.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/shop_sign_up_fields.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/sign_up_header.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/social_sign.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ShopSignUpScreenBody extends StatelessWidget {
  const ShopSignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradiantHeader(),
        BlocProvider(
          create: (context) => ShopSignUpCubit(),
          child: BlocListener<ShopSignUpCubit, ShopSignUpState>(
            listener: (context, state) {
              if (state is ShopSignUpSuccess) {
                context.popScreen();
                quickAlert(
                  type: QuickAlertType.success,
                  text: LocaleKeys.sign_up_successfully.tr(),
                  title:LocaleKeys.success.tr(),
                );
              }
              if (state is ShopSignUpFailure) {
                quickAlert(
                  type: QuickAlertType.error,
                  text: state.message,
                  title: LocaleKeys.error.tr(),
                );
              }
              if (state is PickImageFailure) {
                quickAlert(
                  type: QuickAlertType.error,
                  text: state.message,
                  title: LocaleKeys.error.tr(),
                );
              }
            },
            child: SizedBox(
              child: Column(
                children: [
                  ShopSignUpHeader(),
                  Expanded(
                    child: AuthBody(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ShopSignUpFields(),
                            const OrWithDivider(),
                            const SocialSign(),
                            SizedBox(height: SizeConfig.height * 0.01),
                            HaveAccountOrNot(
                              title: LocaleKeys.have_an_account.tr(),
                              btnText: LocaleKeys.sign_in.tr(),
                              onPressed: () =>
                                  context.pushScreen(RouteNames.signInScreen),
                            ),
                            SizedBox(height: SizeConfig.height * 0.01),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

