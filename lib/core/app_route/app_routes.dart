// import 'package:disan/features/admin/add_product_and_category/views/screens/add_product_and_category_screen.dart';
// import 'package:disan/features/admin/time_lines/add_story/views/screens/add_story_screen.dart';
// import 'package:disan/features/auth/select_role/views/screens/select_role_screen.dart';
// import 'package:disan/features/splash/views/screens/splash_screen.dart';
// import 'package:disan/core/app_route/route_names.dart';
// import 'package:disan/features/auth/forget_password/views/screens/forget_password_screen.dart';
// import 'package:disan/features/auth/sign_in/views/screens/sign_in_screen.dart';
// import 'package:disan/features/auth/sign_up/views/screens/sign_up_screen.dart';
// import 'package:disan/features/on_boarding/views/screens/on_boarding_screen.dart';
// import 'package:disan/features/user/categories/views/screens/categories_screen.dart';
// import 'package:disan/features/user/hom/views/screens/home_screen.dart';
// import 'package:disan/features/user/product_details/views/screens/product_details_screen.dart';
// import 'package:disan/features/user/shop_details/views/screens/shop_detaiils_screen.dart';
// import 'package:disan/features/user/shop_products/views/screens/shop_products_screen.dart';
// import 'package:flutter/material.dart';

// ignore_for_file: equal_keys_in_map

// class AppRoutes {
//   static Map<String, Widget Function(BuildContext)>
//   routes = <String, WidgetBuilder>{
//     RouteNames.splashScreen: (context) => const SplashScreen(),
//     RouteNames.onBoardingScreen: (context) => const OnBoardingScreen(),
//     RouteNames.signUpScreen: (context) => const SignUpScreen(),
//     RouteNames.signInScreen: (context) => const SignInScreen(),
//     RouteNames.forgetPasswordScreen: (context) => const ForgetPasswordScreen(),
//     RouteNames.selectRoleScreen: (context) => const SelectRoleScreen(),
//     // RouteNames.storyScreen: (context) => const StoryScreen(),
//     RouteNames.homeScreen: (context) => const UserHomeScreen(),
//     RouteNames.categoryScreen: (context) => const CategoryScreen(),
//     RouteNames.shopDetailsScreen: (context) => const ShopDetailsScreen(),
//     RouteNames.shopProductsScreen: (context) => const ShopProductsScreen(),
//     RouteNames.productDetailsScreen: (context) => const ProductDetailsScreen(),
//     RouteNames.addProductAndCategoryScreen: (context) => const AddProductAndCategoryScreen(),
//   };
// }
import 'package:disan/features/about_us/about_us_page.dart';
import 'package:disan/features/admin/add_offers/views/screens/add_offers_screen.dart';
import 'package:disan/features/admin/add_product_and_category/views/screens/add_product_and_category_screen.dart';
import 'package:disan/features/admin/customer_chats/views/screens/chats_screen.dart';
import 'package:disan/features/admin/customer_details/views/screens/customer_details_screen.dart';
import 'package:disan/features/admin/customer_requests_details/views/screens/customer_requests_details_screen.dart';
import 'package:disan/features/admin/customers/views/screens/customers_screen.dart';
import 'package:disan/features/admin/edit_product/views/screens/edit_product_screen.dart';
import 'package:disan/features/admin/offers/views/screens/offers_screen.dart';
import 'package:disan/features/admin/select_offer_type_screen/views/screens/seelct_offer_type_screen.dart';
import 'package:disan/features/admin/time_lines/add_story/views/screens/add_story_screen.dart';
import 'package:disan/features/admin/time_lines/post/views/screens/add_post_screen.dart';
import 'package:disan/features/auth/customer_sign_up/views/screens/customer_sign_up_screen.dart';
import 'package:disan/features/auth/select_role/views/screens/select_role_screen.dart';
import 'package:disan/features/auth/shop_sign_up/views/screens/sign_up_screen.dart';
import 'package:disan/features/chat/views/screens/chat_screen.dart';
import 'package:disan/features/get_all_products/ui/all_products.dart';
import 'package:disan/features/help_center/help_center.dart';
import 'package:disan/features/privacy_page/privacy_page.dart';
import 'package:disan/features/splash/views/screens/splash_screen.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/features/auth/forget_password/views/screens/forget_password_screen.dart';
import 'package:disan/features/auth/sign_in/views/screens/sign_in_screen.dart';
import 'package:disan/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:disan/features/user/about/views/screens/about_screen.dart';
import 'package:disan/features/user/cart/views/screens/cart_screen.dart';
import 'package:disan/features/user/categories/views/screens/categories_screen.dart';
import 'package:disan/features/user/contact_us/views/screens/contact_us_screen.dart';
import 'package:disan/features/user/hom/views/screens/home_screen.dart';
import 'package:disan/features/user/home/views/screens/home_screen_body.dart';
import 'package:disan/features/user/my_order_details/views/screens/my_orders_details_screen.dart';
import 'package:disan/features/user/my_orders/views/screens/my_orders_screen.dart';
import 'package:disan/features/user/product_details/views/screens/product_details_screen.dart';
import 'package:disan/features/user/profile/views/screens/profile_screen.dart';
import 'package:disan/features/user/profile_details/views/screens/profile_details_screen.dart';
import 'package:disan/features/user/settings/views/screens/settings_screen.dart';
import 'package:disan/features/user/shop_products/views/screens/shop_products_screen.dart';
import 'package:disan/features/user/shop_details/views/screens/shop_products_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        RouteNames.splashScreen: (context) => const SplashScreen(),
        RouteNames.onBoardingScreen: (context) => const OnBoardingScreen(),
        RouteNames.customerSignUpScreen: (context) =>
            const CustomerSignUpScreen(),
        RouteNames.shopSignUpScreen: (context) => const ShopSignUpScreen(),
        RouteNames.signInScreen: (context) => const SignInScreen(),
        RouteNames.selectRoleScreen: (context) => const SelectRoleScreen(),
        RouteNames.forgetPasswordScreen: (context) =>
            const ForgetPasswordScreen(),
        RouteNames.homeScreen: (context) => const UserHomeScreen(),
        RouteNames.categoryScreen: (context) => const CategoryScreen(),
        RouteNames.productDetailsScreen: (context) =>
            const ProductDetailsScreen(),
        RouteNames.addProductAndCategoryScreen: (context) =>
            const AddProductAndCategoryScreen(),
        RouteNames.customerRequestsDetailsScreen: (context) =>
            const CustomerRequestsDetailsScreen(),
        RouteNames.chatScreen: (context) => const ChatScreen(),
        RouteNames.profileDetailsScreen: (context) =>
            const ProfileDetailsScreen(),
        RouteNames.myOrdersScreen: (context) => const MyOrdersScreen(),
        RouteNames.myOrdersDetailsScreen: (context) =>
            const MyOrdersDetailsScreen(),
        RouteNames.customerDetailsScreen: (context) =>
            const CustomerDetailsScreen(),
        RouteNames.aboutScreen: (context) => const AboutScreen(),
        RouteNames.contactSupportScreen: (context) =>
            const ContactSupportScreen(),
        RouteNames.settingsScreen: (context) => const SettingsScreen(),
        RouteNames.customersScreen: (context) => const CustomersScreen(),
        RouteNames.chatsScreen: (context) => const ChatsScreen(),
        RouteNames.offersScreen: (context) => const OffersScreen(),
        RouteNames.addOfferScreen: (context) => const AddOfferScreen(),
        RouteNames.editProductScreen: (context) => const EditProductScreen(),
        RouteNames.profileScreen: (context) => const ProfileScreen(),
        RouteNames.cartScreen: (context) => const CartScreen(),
        RouteNames.shopDetailsScreen: (context) => const ShopDetailsScreen(),
        RouteNames.shopProductsScreen: (context) => const ShopProductsScreen(),
        RouteNames.addStoryAndReelsScreen: (context) =>
            const AddStoryAndReels(),
        RouteNames.discountTypeSelectionPage: (context) =>
            const SelectOfferTypeScreen(),
        RouteNames.addPostScreen: (context) => const AddPostScreen(),
        RouteNames.allProducts: (context) => const AllProductsPage(),
        RouteNames.privacy: (context) => const PrivacyPolicyPage(),
        RouteNames.helpCenter: (context) => const HelpCenterPage(),
        RouteNames.aboutUs: (context) => const AboutUsPage(),
      };
}
