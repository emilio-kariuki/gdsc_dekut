import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBlocBloc() : super(UserBlocInitial()) {
    on<UserBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
