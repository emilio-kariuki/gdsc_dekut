import '../../models/developer_model.dart';
import '../repositories/developer_repository.dart';

class DeveloperProviders {

  Future<bool> contactDeveloper({required String email}) async {
    final response = await DeveloperRepository().contactDeveloper(
      email: email,
    );
    return response;
  }

  Future<List<DeveloperModel>> getDevelopers() async {
    final response = await DeveloperRepository().getDevelopers();
    return response;
  }
}