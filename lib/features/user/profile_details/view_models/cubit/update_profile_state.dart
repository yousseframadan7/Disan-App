part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}
final class UpdateProfileLoading extends UpdateProfileState {}
final class UpdateProfileSuccess extends UpdateProfileState {}
final class UpdateProfileEmail extends UpdateProfileState {}
final class UpdateProfileFailure extends UpdateProfileState {
  final String message;
  UpdateProfileFailure({required this.message});
}
final class NoChangeProfile extends UpdateProfileState {}
final class PickImageScucess extends UpdateProfileState {}
final class PickImageFailure extends UpdateProfileState {
  final String message;
  PickImageFailure({required this.message});
}
final class PickImageLoading extends UpdateProfileState {}
