import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/utilities/shared_preference_manager.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUnitialized()) {
    on<AppStarted>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final isLoggedIn = await SharedPreferencesManager().isLoggedIn();
        if (isLoggedIn) {
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
