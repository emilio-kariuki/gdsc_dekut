import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gdsc_bloc/data/models/groups_model.dart';

import '../../../data/services/providers/group_providers.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());

  void createGroup({
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    try {
      emit(GroupLoading());
      final isCreated = await GroupProviders().createGroup(
        title: title,
        description: description,
        imageUrl: imageUrl,
        link: link,
      );

      if (isCreated) {
        emit(GroupCreated());
      }
    } catch (e) {
      emit(GroupError(message: e.toString()));
    }
  }

  void getAllGroups() async {
    try {
      emit(GroupLoading());
      final groups = await GroupProviders().getGroups();
      emit(GroupSuccess(groups: groups));
    } catch (e) {
      emit(const GroupError(message: "Failed to load groups"));
    }
  }

  void searchGroup({required String query}) async {
    try {
      emit(GroupLoading());
      final groups = await GroupProviders().searchGroup(query: query);
      emit(GroupSuccess(groups: groups));
    } catch (e) {
      emit(const GroupError(message: "Failed to load groups"));
    }
  }

  void getGroupById({required String id}) async {
    try {
      emit(GroupLoading());
      final group = await GroupProviders().getParticularGroup(id: id);
      emit(GroupFetched(group: group));
    } catch (e) {
      emit(const GroupError(message: "Failed to fetch Group"));
    }
  }

  void updateGroup({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    try {
      emit(GroupLoading());
      final isUpdated = await GroupProviders().updateGroup(
        id: id,
        title: title,
        link: link,
        imageUrl: imageUrl,
        description: description,
      );

      if (isUpdated) {
        emit(GroupUpdated());
      }
    } catch (e) {
      emit(const GroupError(message: "Failed to update Group"));
    }
  }

  void deleteGroup({required String id}) async {
    try {
      emit(GroupLoading());
      final isDeleted = await GroupProviders().deleteParticularGroup(id: id);

      if (isDeleted) {
        emit(GroupDeleted());
      }
    } catch (e) {
      emit(GroupError(message: e.toString()));
    }
  }
}
