
import '../../models/resource_model.dart';
import '../repositories/resource_repository.dart';


class ResourceProviders {
  Future<bool> createResource({
    required String title,
    required String link,
    required String imageUrl,
    required String category,
  }) async {
    final response = ResourceRepository().createResource(
        title: title,
        link: link,
        imageUrl: imageUrl,
        category: category);
    return response;
  }

  Future<bool> createAdminResource({
    required String title,
    required String link,
    required String imageUrl,
    required String category,
  }) async {
    final response = ResourceRepository().createAdminResource(
        title: title,
        link: link,
        imageUrl: imageUrl,
        category: category);
    return response;
  }

  Future<List<Resource>> getAllResources() async {
    final response = await ResourceRepository().getAllResources();
    return response;
  }

  Future<List<Resource>> getUnApprovedResources() async {
    final response = await ResourceRepository().getUnApprovedResources();
    return response;
  }

  Future<List<Resource>> searchUnApprovedResources(
      {required String query}) async {
    final response =
        await ResourceRepository().searchUnApprovedResources(query: query);
    return response;
  }

  Future<bool> approveResource({required String id}) async {
    final response = await ResourceRepository().approveResource(id: id);
    return response;
  }

  Future<Resource> getParticularResource({required String id}) async {
    final response = await ResourceRepository().getParticularResource(id: id);
    return response;
  }

  Future<List<Resource>> getResources({required String category}) {
    return ResourceRepository().getResources(category: category);
  }

  Future<List<Resource>> searchResources({required String query}) async {
    return ResourceRepository().searchResources(query: query);
  }

  Future<List<Resource>> searchCategoryResources(
      {required String query, required String category}) async {
    final response = await ResourceRepository()
        .searchCategoryResources(query: query, category: category);

    return response;
  }

  Future<List<Resource>> getUserResources() async {
    return ResourceRepository().getUserResources();
  }

  Future<List<Resource>> searchUserResources({required String query}) async {
    return ResourceRepository().searchUserResources(
      query: query,
    );
  }

  Future<bool> updateResource({
    required String id,
    required String title,
    required String link,
    required String imageUrl,
    required String description,
    required String category,
  }) async {
    final response = await ResourceRepository().updateResource(
      id: id,
      title: title,
      link: link,
      imageUrl: imageUrl,
      description: description,
      category: category,
    );
    return response;
  }

  Future<bool> deleteResource({required String id}) async {
    return ResourceRepository().deleteResource(id: id);
  }
}
