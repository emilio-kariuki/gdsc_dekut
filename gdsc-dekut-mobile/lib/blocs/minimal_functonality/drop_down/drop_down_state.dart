part of 'drop_down_cubit.dart';

sealed class DropDownState extends Equatable {
  const DropDownState();

  @override
  List<Object> get props => [];
}

final class DropDownInitial extends DropDownState {}

final class DropDownChanged extends DropDownState {
  final String value;

   const DropDownChanged({required this.value});

  @override
  List<Object> get props => [value];
}
