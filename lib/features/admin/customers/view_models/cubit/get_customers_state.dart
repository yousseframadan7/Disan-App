part of 'get_customers_cubit.dart';

@immutable
sealed class GetCustomersState {}

final class GetCustomersInitial extends GetCustomersState {}

final class GetCustomersLoading extends GetCustomersState {}

final class GetCustomersSuccess extends GetCustomersState {}

final class GetCustomersFailure extends GetCustomersState {
  final String message;
  GetCustomersFailure({required this.message});
}

final class NoCustomersExist extends GetCustomersState {}
