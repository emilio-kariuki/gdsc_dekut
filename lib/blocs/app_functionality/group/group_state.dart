part of 'group_cubit.dart';

sealed class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupSuccess extends GroupState {
  final List<GroupsModel> groups;

  const GroupSuccess({required this.groups});

  @override
  List<Object> get props => [groups];
}

final class GroupFetched extends GroupState {
  final GroupsModel group;

  const GroupFetched({required this.group});

  @override
  List<Object> get props => [group];
}

final class GroupCreated extends GroupState {}

final class GroupUpdated extends GroupState {}

final class GroupApproved extends GroupState {}

final class GroupDeleted extends GroupState {}

final class GroupError extends GroupState {
  final String message;

  const GroupError({required this.message});

  @override
  List<Object> get props => [message];
}

