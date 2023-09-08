part of 'alignment_value_cubit.dart';

sealed class AlignmentValueState extends Equatable {
  const AlignmentValueState();

  @override
  List<Object> get props => [];
}

final class AlignmentValueInitial extends AlignmentValueState {}

final class AlignmentChanged extends AlignmentValueState {
  final bool alignment;

  const AlignmentChanged({required this.alignment});

  @override
  List<Object> get props => [alignment];
}
