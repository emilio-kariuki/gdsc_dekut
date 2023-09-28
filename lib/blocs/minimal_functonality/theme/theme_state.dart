part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class AppTheme extends ThemeState {
  final bool isDark;

  const AppTheme({required this.isDark});

  @override
  List<Object> get props => [isDark];
}

