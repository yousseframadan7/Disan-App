import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:disan/features/on_boarding/views/widgets/custom_on_boarding_app_bar.dart';
import 'package:disan/features/on_boarding/views/widgets/next_page_and_smooth_page_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreenBody extends StatelessWidget {
  const OnBoardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, int>(
        listener: (context, state) {
          if (state == 5) {
            context.pushReplacementScreen(RouteNames.selectRoleScreen);
          }
        },
        builder: (context, state) {
          var cubit = context.read<OnBoardingCubit>();
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.01,
              ),
              child: Column(
                children: [
                  CustomOnBoardingAppBar(),
                  Expanded(
                    flex: 6,
                    child: PageView.builder(
                      itemCount: cubit.steps.length,
                      onPageChanged: cubit.changePage,
                      controller: cubit.pageController,
                      itemBuilder: (context, index) {
                        return cubit.steps[index];
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.height * 0.03),
                  NextPageAndSmoothPageIndecator(cubit: cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
