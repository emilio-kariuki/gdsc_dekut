part of 'password_visibility_cubit.dart';

sealed class PasswordVisibilityState extends Equatable {
  const PasswordVisibilityState();

  @override
  List<Object> get props => [];
}

final class PasswordVisibilityInitial extends PasswordVisibilityState {}

final class PasswordObscured extends PasswordVisibilityState {
  final bool isObscured;

  const PasswordObscured({required this.isObscured});

  @override
  List<Object> get props => [isObscured];
  
}
