part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String message;

  const RegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String message;

  const LogoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}


class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordFailure extends AuthState {
  final String message;

  const ResetPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}


class DeleteAccountLoading extends AuthState {}

class DeleteAccountSuccess extends AuthState {}

class DeleteAccountFailure extends AuthState {
  final String message;

  const DeleteAccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class GoogleLoginLoading extends AuthState {}

class GoogleLoginSuccess extends AuthState {}

class GoogleLoginFailure extends AuthState {
  final String message;

  const GoogleLoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}