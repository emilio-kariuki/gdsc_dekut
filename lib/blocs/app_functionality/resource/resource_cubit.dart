// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gdsc_bloc/data/models/resource_model.dart';
import '../../../data/services/providers/resource_providers.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit() : super(ResourceInitial());

  void createResource({
    required String title,
    required String link,
    required String imageUrl,
    required String category,
  }) async {
    try {
      final isCreated = await ResourceProviders().createResource(
        title: title,
        link: link,
        imageUrl: imageUrl,
        category: category,
      );

      if (isCreated) {
        emit(ResourceCreated());
      } else {
        emit(const ResourceError(message: 'Failed to send resource'));
      }
    } catch (e) {
      emit(ResourceError(message: e.toString()));
    }
  }

  void createAdminResource({
    required String title,
    required String link,
    required String imageUrl,
    required String category,
  }) async {
    try {
      final isCreated = await ResourceProviders().createAdminResource(
        title: title,
        link: link,
        imageUrl: imageUrl,
        category: category,
      );

      if (isCreated) {
        emit(ResourceCreated());
      } else {
        emit(const ResourceError(message: 'Failed to send resource'));
      }
    } catch (e) {
      emit(ResourceError(message: e.toString()));
    }
  }

  void approveResource({required String id}) async {
    try {
      final isApproved = await ResourceProviders().approveResource(id: id);

      if (isApproved) {
        emit(ResourceApproved());
      } else {
        emit(const ResourceError(message: "Failed to approve resource"));
      }
    } catch (e) {
      emit(const ResourceError(message: "Failed to approve resource"));
    }
  }

  void getAllResources() async {
    emit(ResourceLoading());
    try {
      final resource = await ResourceProviders().getAllResources();
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void getResourceById({required String id}) async {
    try {
      emit(ResourceLoading());
      final resource = await ResourceProviders().getParticularResource(id: id);

      if (resource != null) {
        emit(ResourceFetched(resource: resource));
      } else {
        emit(const ResourceError(message: "Failed to fetch resource"));
      }
    } catch (e) {
      emit(const ResourceError(message: "Failed to fetch resource"));
    }
  }

  void searchResource({required String query}) async {
    try {
      emit(ResourceLoading());
      final resource = await ResourceProviders().searchResources(
        query: query,
      );
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void getResourcesByCategory({required String category}) async {
    emit(ResourceLoading());
    try {
      final resource = await ResourceProviders().getResources(category: category);
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void searchResourceByCategory(
      {required String query, required String category}) async {
    try {
      emit(ResourceLoading());

      final resource = await ResourceProviders()
          .searchCategoryResources(query: query, category: category);
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load category resources"));
    }
  }

  void getUnApprovedResources() async {
    emit(ResourceLoading());
    try {
      final resource = await ResourceProviders().getUnApprovedResources();
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void searchUnApprovedResources({required String query}) async {
    try {
      emit(ResourceLoading());
      final resource = await ResourceProviders().searchUnApprovedResources(
        query: query,
      );
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void getUserResources() async {
    try {
      emit(ResourceLoading());
      final resource = await ResourceProviders().getUserResources();
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void searchUserResource({required String query}) async {
    try {
      emit(ResourceLoading());

      final resource = await ResourceProviders().searchUserResources(
        query: query,
      );
      emit(ResourceSuccess(resources: resource));
    } catch (e) {
      emit(const ResourceError(message: "Failed to load resources"));
    }
  }

  void updateResource({
    required String id,
    required String title,
    required String link,
    required String imageUrl,
    required String description,
    required String category,
  }) async {
    try {
      emit(ResourceLoading());
      final isUpdated = await ResourceProviders().updateResource(
        id: id,
        title: title,
        link: link,
        imageUrl: imageUrl,
        description: description,
        category: category,
      );
      if (isUpdated) {
        emit(ResourceUpdated());
      } else {
        emit(const ResourceError(message: "Failed to update resource"));
      }
    } catch (e) {
      emit(const ResourceError(message: "Failed to update resource"));
    }
  }

  void deleteResource({required String id}) async {
    try {
      emit(ResourceLoading());
      final isDeleted = await ResourceProviders().deleteResource(id: id);

      if (isDeleted) {
        emit(ResourceDeleted());
      } else {
        emit(const ResourceError(message: 'Failed to delete Group'));
      }
    } catch (e) {
      emit(ResourceError(message: e.toString()));
    }
  }
}
