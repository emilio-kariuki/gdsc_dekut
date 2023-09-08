part of 'resource_cubit.dart';

sealed class ResourceState extends Equatable {
  const ResourceState();

  @override
  List<Object> get props => [];
}

final class ResourceInitial extends ResourceState {}

final class ResourceLoading extends ResourceState {}

final class ResourceSuccess extends ResourceState {
  final List<Resource> resources;

  const ResourceSuccess({required this.resources});

  @override
  List<Object> get props => [resources];
}

final class ResourceFetched extends ResourceState {
  final Resource resource;

  const ResourceFetched({required this.resource});

  @override
  List<Object> get props => [resource];
}

final class ResourceCreated extends ResourceState {}

final class ResourceUpdated extends ResourceState {}

final class ResourceApproved extends ResourceState {}

final class ResourceDeleted extends ResourceState {}

final class ResourceError extends ResourceState {
  final String message;

  const ResourceError({required this.message});

  @override
  List<Object> get props => [message];
}
