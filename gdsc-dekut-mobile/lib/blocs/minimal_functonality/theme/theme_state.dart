part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeDark extends ThemeState {
  final ThemeData themeData;

  const ThemeDark({required this.themeData});

  @override
  List<Object> get props => [themeData];
}


class ThemeLight extends ThemeState {
  final ThemeData themeData;

  const ThemeLight({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
