import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/shared_preference_manager.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnitialized()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final isLoggedIn = await SharedPreferencesManager().isLoggedIn();
        final user = FirebaseAuth.instance.currentUser;
        debugPrint("user is $user");

        if (isLoggedIn && user != null) {
          emit(AuthenticationAuthenticated());
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } catch (e) {
        emit(AuthenticationFailure(message: e.toString()));
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      Future.delayed(const Duration(seconds: 1));
      emit(AuthenticationAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      Future.delayed(const Duration(seconds: 1));
      emit(AuthenticationUnauthenticated());
    });
  }
}
