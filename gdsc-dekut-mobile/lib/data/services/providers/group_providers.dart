import '../../models/groups_model.dart';
import '../repositories/group_repository.dart';

class GroupProviders {

    Future<bool> createGroup({
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    final response = await GroupRepository().createGroup(
      title: title,
      description: description,
      imageUrl: imageUrl,
      link: link,
    );
    return response;
  }


  Future<List<GroupsModel>> getGroups() async {
    final response = await GroupRepository().getGroups();
    return response;
  }

  Future<List<GroupsModel>> searchGroup({required String query}) async {
    final response = await GroupRepository().searchGroup(query: query);
    return response;
  }

  Future<GroupsModel> getParticularGroup({required String id}) async {
    final response = await GroupRepository().getParticularGroup(id: id);
    return response;
  }


  Future<bool> updateGroup({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    final response = await GroupRepository().updateGroup(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      link: link,
    );
    return response;
  }

  Future<bool> deleteParticularGroup({required String id}) async {
    final response = await GroupRepository().deleteParticularGroup(id: id);
    return response;
  }


}