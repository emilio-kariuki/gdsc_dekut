import '../../../data/services/repositories/auth_repository.dart';

class AuthProviders {
  Future<bool> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    var response = AuthRepository().registerUser(
      email: email,
      password: password,
      name: name,
    );
    return response;
  }

  Future<bool> loginAccount(
      {required String email, required String password}) async {
    var response = AuthRepository().loginUser(
      email: email,
      password: password,
    );
    return response;
  }

  Future<bool> logoutAccount() async {
    var response = AuthRepository().logoutUser();
    return response;
  }

  Future<bool> resetPassword({required String email}) async {
    var response = AuthRepository().resetPassword(email: email);
    return response;
  }

  Future<bool> changePassword(
      {required String email,
      required String oldPassword,
      required String newPassword,}) async {
    var response = AuthRepository().changePassword(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return response;
  }

  Future<bool> deleteAccount(
      {required String email, required String password}) async {
    var response =
        AuthRepository().deleteUser(email: email, password: password);
    return response;
  }

  Future<bool> signInWithGoogle() async {
    var response = AuthRepository().signInWithGoogle();
    return response;
  }
}
