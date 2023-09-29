import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/user_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/services/providers/user_providers.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserInitial());

  void getUser() async {
    try {
      emit(UserLoading());
      final user = await UserProviders().getUser();
      emit(UserSuccess(user: user));
    } catch (e) {
      emit(const UserError(message: "Failed to load user"));
    }
  }

  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String github,
    required String linkedin,
    required String twitter,
    required String userId,
    required String technology,
    required String image,
  }) async {
    try {
      final user = await UserProviders().updateUser(
        name: name,
        email: email,
        phone: phone,
        github: github,
        linkedin: linkedin,
        twitter: twitter,
        userId: userId,
        technology: technology,
        image: image,
      );

      if (user) {
        emit(UserUpdated());
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
  
  @override
  UserState? fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel.fromJson(json);
    return UserSuccess(user: user);
    
  }
  
  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserSuccess) {
      return state.user.toJson();
    }
  }
}
