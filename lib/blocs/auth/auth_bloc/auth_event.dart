part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String email;
  final String password;

  const Login({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
// register ocde for the user
class Register extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const Register(
      {required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}

class Logout extends AuthEvent {}

class ChangePassword extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;
  const ChangePassword(
      {required this.email,
      required this.oldPassword,
      required this.newPassword});

  @override
  List<Object> get props => [email, oldPassword, newPassword];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  const ResetPasswordEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class DeleteAccount extends AuthEvent {
  final String email;
  final String password;
  const DeleteAccount({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class GoogleAuthentication extends AuthEvent {}