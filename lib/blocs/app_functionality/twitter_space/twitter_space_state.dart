part of 'twitter_space_cubit.dart';

sealed class TwitterSpaceState extends Equatable {
  const TwitterSpaceState();

  @override
  List<Object> get props => [];
}

final class TwitterSpaceInitial extends TwitterSpaceState {}

final class TwitterSpaceLoading extends TwitterSpaceState {}

final class TwitterSpaceSuccess extends TwitterSpaceState {
  final List<TwitterModel> spaces;

  const TwitterSpaceSuccess({required this.spaces});

  @override
  List<Object> get props => [spaces];
}

final class TwitterSpaceFetched extends TwitterSpaceState {
  final TwitterModel space;

  const TwitterSpaceFetched({required this.space});

  @override
  List<Object> get props => [space];
}

final class TwitterSpaceCreated extends TwitterSpaceState {}

final class TwitterSpaceStarted extends TwitterSpaceState {}

final class TwitterSpaceCompleted extends TwitterSpaceState {}

final class TwitterSpaceUpdated extends TwitterSpaceState {}

final class TwitterSpaceDeleted extends TwitterSpaceState {}

final class TwitterSpaceError extends TwitterSpaceState {
  final String message;

  const TwitterSpaceError({required this.message});

  @override
  List<Object> get props => [message];
}