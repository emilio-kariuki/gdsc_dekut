part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationInitial extends BottomNavigationState {}

final class TabChanged extends BottomNavigationState {
  final int index;

  const TabChanged({required this.index});

  @override
  List<Object> get props => [index];
}

