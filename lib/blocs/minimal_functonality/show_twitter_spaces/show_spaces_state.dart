part of 'show_spaces_cubit.dart';

sealed class ShowSpacesState extends Equatable {
  const ShowSpacesState();

  @override
  List<Object> get props => [];
}

final class ShowSpacesInitial extends ShowSpacesState {}

final class ShowTwitterSpaces extends ShowSpacesState {
  final bool value;

  ShowTwitterSpaces(this.value);

  @override
  List<Object> get props => [value];
}
