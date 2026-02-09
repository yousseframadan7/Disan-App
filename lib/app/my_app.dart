// ignore_for_file: deprecated_member_use
import 'package:device_preview/device_preview.dart';
import 'package:disan/app/cubit/localization_cubit.dart';
import 'package:disan/core/app_route/app_routes.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool isTest;

  const MyApp({super.key, this.isTest = false});

  @override
  Widget build(BuildContext context) {
    if (isTest) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('Test Mode'),
          ),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TranslationCubit()),
        BlocProvider(create: (_) => getIt<WishListCubit>()),
      ],
      child: BlocBuilder<TranslationCubit, Locale>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              SizeConfig.init(context);
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                builder: DevicePreview.appBuilder,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                useInheritedMediaQuery: true,
                routes: AppRoutes.routes,
                initialRoute:
                    getIt<SupabaseClient>().auth.currentUser?.id != null
                        ? RouteNames.homeScreen
                        : RouteNames.splashScreen,
              );
            },
          );
        },
      ),
    );
  }
}
