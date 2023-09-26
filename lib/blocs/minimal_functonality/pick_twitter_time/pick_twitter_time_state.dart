part of 'pick_twitter_time_cubit.dart';

sealed class PickTwitterTimeState extends Equatable {
  const PickTwitterTimeState();

  @override
  List<Object> get props => [];
}

final class PickTwitterTimeInitial extends PickTwitterTimeState {}

final class TwitterTimePicked extends PickTwitterTimeState {
  final Timestamp timestamp;

  const TwitterTimePicked({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
  
}
