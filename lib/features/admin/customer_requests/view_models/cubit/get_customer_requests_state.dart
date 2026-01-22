part of 'get_customer_requests_cubit.dart';

@immutable
sealed class GetCustomerRequestsState {}

final class GetCustomerRequestsInitial extends GetCustomerRequestsState {}

final class GetCustomerRequestsLoading extends GetCustomerRequestsState {}

final class GetCustomerRequestsSuccess extends GetCustomerRequestsState {}

final class GetCustomerRequestsFailure extends GetCustomerRequestsState {
  final String message;
  GetCustomerRequestsFailure({required this.message});
}

final class CustomerRequestsEmpty extends GetCustomerRequestsState {}
final class UpdateCustomerRequestStatus extends GetCustomerRequestsState {
  final String status;
  final String userName;
  UpdateCustomerRequestStatus({ required this.status, required this.userName});
}
final class UpdateCustomerRequestLoading extends GetCustomerRequestsState {
}
final class UpdateCustomerRequestFailure extends GetCustomerRequestsState {
  final String message;
  UpdateCustomerRequestFailure({required this.message});
}
final class DeleteCustomerRequestSuccess extends GetCustomerRequestsState {
  final String userName;

  DeleteCustomerRequestSuccess({required this.userName});
}
