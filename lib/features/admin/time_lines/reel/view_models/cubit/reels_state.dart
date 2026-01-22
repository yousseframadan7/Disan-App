
abstract class ReelsState {}

class ReelsInitial extends ReelsState {}

class ReelsLoaded extends ReelsState {}

class ReelsChanged extends ReelsState {}

class ReelsPlaying extends ReelsState {}

class ReelsPaused extends ReelsState {}

class ReelsError extends ReelsState {
  final String message;
  ReelsError(this.message);
}
