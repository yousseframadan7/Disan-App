part of 'get_customer_chats_cubit.dart';

@immutable
sealed class GetCustomerChatsState {}

final class GetCustomerChatsInitial extends GetCustomerChatsState {}
final class GetCustomerChatsLoading extends GetCustomerChatsState {}
final class GetCustomerChatsSuccess extends GetCustomerChatsState {}
final class GetCustomerChatsFailure extends GetCustomerChatsState {
  final String message;
  GetCustomerChatsFailure({required this.message});
}
final class EmptyCustomerChats extends GetCustomerChatsState {
}
