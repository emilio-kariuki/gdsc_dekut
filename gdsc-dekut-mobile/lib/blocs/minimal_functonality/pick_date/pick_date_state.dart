part of 'pick_date_cubit.dart';

sealed class PickDateState extends Equatable {
  const PickDateState();

  @override
  List<Object> get props => [];
}

final class PickDateInitial extends PickDateState {}

final class DatePicked extends PickDateState {
  final String date;

   const DatePicked({required this.date});

  @override
  List<Object> get props => [date];
}
