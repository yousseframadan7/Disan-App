import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/features/on_boarding/views/widgets/custom_on_boarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0) {
    percentage = calculatePercentage(0);
  }

  final PageController pageController = PageController(initialPage: 0);
  double percentage = 0.2;

  List<Widget> steps = [
    CustomOnBoardingStep(
      image: AppLotties.welcomeLottie,
      title: "Welcome to Disan!",
      description:
          "Your one-stop marketplace for seamless buying and powerful selling.",
    ),
    CustomOnBoardingStep(
      image: AppLotties.buyLottie,
      title: "Buy Anything You Need",
      description:
          "Browse a wide range of products and shop with just a few taps. Fast, easy, and secure.",
    ),
    CustomOnBoardingStep(
      image: AppLotties.sellLottie,
      title: "Become a Seller",
      description: "List your products and manage your store with ease.",
    ),
    CustomOnBoardingStep(
      image: AppLotties.postsLottie,
      title: "Stories, Reels & Posts",
      description:
          "Boost your visibility by posting engaging content that reaches more buyers.",
    ),
    CustomOnBoardingStep(
      image: AppLotties.chatLottie,
      title: "Chat & Connect",
      description:
          "Communicate directly with buyers and sellers through secure in-app chat",
    ),
  ];

  double calculatePercentage(int index) {
    return (index + 1) / steps.length;
  }

  void nextPage() {
    if (state < steps.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInCirc,
      );
      final newIndex = state + 1;
      percentage = calculatePercentage(newIndex);
      emit(newIndex);
    }else{
      emit(steps.length);
    }
  }

  void previousPage() {
    if (state > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      final newIndex = state - 1;
      percentage = calculatePercentage(newIndex);
      emit(newIndex);
    }
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
    percentage = calculatePercentage(index);
    emit(index);
  }
}
