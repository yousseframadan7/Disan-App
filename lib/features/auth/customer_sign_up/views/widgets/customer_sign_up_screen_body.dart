import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/customer_sign_up/view_models/cubit/customer_sign_up_cubit.dart';
import 'package:disan/features/auth/customer_sign_up/views/widgets/customer_sign_up_fields.dart';
import 'package:disan/features/auth/customer_sign_up/views/widgets/sign_up_header.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_body.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/gradiant_header.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/have_account_or_not.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/or_with_divider.dart';
import 'package:disan/features/auth/shop_sign_up/views/widgets/social_sign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CustomerSignUpScreenBody extends StatelessWidget {
  const CustomerSignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradiantHeader(),
        BlocProvider(
          create: (context) => CustomerSignUpCubit(),
          child: BlocListener<CustomerSignUpCubit, CustomerSignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                context.popScreen();
                quickAlert(
                  type: QuickAlertType.success,
                  text: "Sign Up Successfully",
                  title: "Success",
                );
              }
              if (state is SignUpFailure) {
                quickAlert(
                  type: QuickAlertType.error,
                  text: state.message,
                  title: "Error",
                );
              }
              if (state is PickImageFailure) {
                quickAlert(
                  type: QuickAlertType.error,
                  text: state.message,
                  title: "Error",
                );
              }
            },
            child: SizedBox(
              child: Column(
                children: [
                  CustomerSignUpHeader(),
                  Expanded(
                    child: AuthBody(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomerSignUpFields(),
                            const OrWithDivider(),
                            const SocialSign(),
                            SizedBox(height: SizeConfig.height * 0.01),
                            HaveAccountOrNot(
                              title: "have an account",
                              btnText: "Sign In",
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

