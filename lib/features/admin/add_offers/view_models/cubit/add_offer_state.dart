part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

class GetProductsLoading extends AddOfferState {}

class GetProductsSuccess extends AddOfferState {}

class GetProductsFailure extends AddOfferState {
  final String error;
  GetProductsFailure(this.error);
}

class EmptyProducts extends AddOfferState {}

class PickImageLoading extends AddOfferState {}

class PickImageSuccess extends AddOfferState {}

class PickImageFailure extends AddOfferState {
  final String error;
  PickImageFailure(this.error);
}

class PickDateLoading extends AddOfferState {} // حالة جديدة

class PickDateSuccess extends AddOfferState {} // حالة جديدة

class PickDateFailure extends AddOfferState { // حالة جديدة
  final String error;
  PickDateFailure(this.error);
}

class AddOfferLoading extends AddOfferState {}

class AddOfferSuccess extends AddOfferState {}

class AddOfferFailure extends AddOfferState {
  final String error;
  AddOfferFailure(this.error);
}

class FieldEmpty extends AddOfferState {
  final String message;
  FieldEmpty({required this.message});
}