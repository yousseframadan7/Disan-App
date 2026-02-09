import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/notifications/local_notifications_services.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_products_cubit.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_trending_shops_cubit.dart';
import 'package:disan/features/user/hom/view_models/cubit/home_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/admin_bottom_nav_bar.dart';
import 'package:disan/features/user/hom/views/widgets/admin_speed_dial.dart';
import 'package:disan/features/user/hom/views/widgets/user_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = getIt<CacheHelper>().getUserModel();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => GetProductsCubit()),
        BlocProvider(create: (_) => GetTrendingShopsCubit()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            body: userModel!.role == 'shop'
                ? cubit.adminScreens[state.currentIndex]
                : cubit.userScreens[state.currentIndex],
            bottomNavigationBar: userModel.role == 'shop'
                ? AdminBottomNavBar(
                    currentIndex: state.currentIndex,
                    onTap: cubit.changeIndex,
                  )
                : UserBottomNavBar(
                    currentIndex: state.currentIndex,
                    onTap: cubit.changeIndex,
                  ),
            floatingActionButtonLocation: context.locale.languageCode == 'en'
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.startFloat,
            floatingActionButton:
                userModel.role == 'shop' ? const AdminSpeedDial() : null,
          );
        },
      ),
    );
  }
}
