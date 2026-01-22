import 'package:bloc/bloc.dart';
import 'package:disan/features/user/hom/views/widgets/home_screen_body.dart';
import 'package:disan/features/user/wishlist/views/widgets/whishlist_screen_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:disan/features/admin/customer_chats/views/widgets/chats_screen_body.dart';
import 'package:disan/features/admin/customer_requests/views/widgets/customer_requests_screen_body.dart';
import 'package:disan/features/admin/customers/views/widgets/customer_screen_body.dart';
import 'package:disan/features/admin/my_products/views/screens/my_products_screen.dart';
import 'package:disan/features/user/profile/views/widgets/profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:disan/generated/locale_keys.g.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(currentIndex: 0, isDrawerOpen: false));

  final List<Widget> userScreens = [
    const HomeScreenBody(),
    const WishlistScreenBody(),
    Center(
      child: Text(
        LocaleKeys.Notifications.tr(),
      ),
    ),
    const ProfileScreenBody(),
  ];

  final List<Widget> adminScreens = [
    const HomeScreenBody(),
    const MyProductsScreen(),
    const CustommerRequestsScreenBody(),
    const ChatsScreenBody(),
    const CustomersScreenBody(),
  ];

  void changeIndex(int index) {
    emit(HomeState(currentIndex: index, isDrawerOpen: state.isDrawerOpen));
  }

  void toggleDrawer() {
    emit(HomeState(
        currentIndex: state.currentIndex, isDrawerOpen: !state.isDrawerOpen));
  }
}
