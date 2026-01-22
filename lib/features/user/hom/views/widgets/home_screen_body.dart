import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/views/widgets/admin_home_screen_header.dart';
import 'package:disan/features/user/hom/views/widgets/home_screen_tab_bar.dart';
import 'package:disan/features/user/hom/views/widgets/user_home_screen_header.dart';
import 'package:disan/features/user/hom/views/widgets/user_home_screen_tab_bar_view.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(
          children: [
            getIt<CacheHelper>().getUserModel()!.role == "shop"
                ? AdminHomeScreenHeader(onMenuPressed: () {})
                : UserHomeScreenHeader(onMenuPressed: () {}),
            SizedBox(height: SizeConfig.height * 0.01),
            HomeScreenTabBar(),
            UserHomeScreenTabBarView(),
          ],
        ),
      ),
    );
  }
}
