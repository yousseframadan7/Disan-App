part of 'home_cubit.dart';

class HomeState {
  final int currentIndex;
  final bool isDrawerOpen;

  HomeState({
    required this.currentIndex,
    this.isDrawerOpen = false,
  });
}