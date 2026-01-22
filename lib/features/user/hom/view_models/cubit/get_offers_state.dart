part of 'get_offers_cubit.dart';

@immutable
sealed class GetOffersState {}

final class GetOffersInitial extends GetOffersState {}
final class GetOffersLoading extends GetOffersState {}
final class GetOffersSuccess extends GetOffersState {}
final class GetOffersFailure extends GetOffersState {
  final String message;

  GetOffersFailure({required this.message});
}
final class EmptyOffers extends GetOffersState {}
