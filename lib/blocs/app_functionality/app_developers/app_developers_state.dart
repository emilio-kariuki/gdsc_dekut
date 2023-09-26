part of 'app_developers_cubit.dart';

sealed class AppDevelopersState extends Equatable {
  const AppDevelopersState();

  @override
  List<Object> get props => [];
}

final class AppDevelopersInitial extends AppDevelopersState {}

final class AppDevelopersLoading extends AppDevelopersState {}

final class AppDevelopersSuccess extends AppDevelopersState {
  final List<DeveloperModel> appDevelopers;

  const AppDevelopersSuccess({required this.appDevelopers});

  @override
  List<Object> get props => [appDevelopers];
}

final class AppDevelopersFetched extends AppDevelopersState {
  final DeveloperModel appDeveloper;

  const AppDevelopersFetched({required this.appDeveloper});

  @override
  List<Object> get props => [appDeveloper];
}


final class AppDevelopersCreated extends AppDevelopersState {}

final class AppDevelopersUpdated extends AppDevelopersState {}

final class AppDevelopersDeleted extends AppDevelopersState {}

final class AppDevelopersError extends AppDevelopersState {
  final String message;

  const AppDevelopersError({required this.message});

  @override
  List<Object> get props => [message];
}
