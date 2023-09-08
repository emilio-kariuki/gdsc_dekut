import '../../models/user_model.dart';
import '../../services/repositories/user_repository.dart';

class UserProviders {
  Future<bool> createUserData(
      {required UserModel user, required String id}) async {
    final response = await UserRepository().createUserData(user: user, id: id);
    return response;
  }

    Future<UserModel> getUser() async {
    final response = await UserRepository().getUser();
    return response;
  }

   Future<bool> updateUser({
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
    final response = await UserRepository().updateUser(
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

    return response;
  }


  Future<bool> isUserAdmin() async {
    final response = await UserRepository().isUserAdmin();
    return response;
  }



}
