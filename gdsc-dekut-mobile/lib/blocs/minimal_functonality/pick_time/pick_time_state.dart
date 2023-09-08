part of 'pick_time_cubit.dart';

sealed class PickTimeState extends Equatable {
  const PickTimeState();

  @override
  List<Object> get props => [];
}

final class PickTimeInitial extends PickTimeState {}

final class TimePicked extends PickTimeState {
  final String time;

  const TimePicked({required this.time});

  @override
  List<Object> get props => [time];
}
