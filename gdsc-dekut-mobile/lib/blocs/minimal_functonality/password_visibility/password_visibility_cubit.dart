import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityInitial());

  void changePasswordVisibility(bool isObscured) {
    emit(PasswordObscured(isObscured: !isObscured));
  }
}
