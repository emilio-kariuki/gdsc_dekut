import 'package:bloc/bloc.dart';

import '../../../data/services/providers/user_providers.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

    void checkUserStatus() async {
    try {
      final isAdmin = await UserProviders().isUserAdmin();

      if (isAdmin) {
        emit( UserAdmin(isAdmin: true));
      } else {
        emit( UserNotAdmin(isAdmin: false));
      }
    } catch (e) {
      emit( UserNotAdmin(isAdmin: false));
    }
  }
}
