part of 'get_image_cubit.dart';

sealed class GetImageState extends Equatable {
  const GetImageState();

  @override
  List<Object> get props => [];
}

final class GetImageInitial extends GetImageState {}

final class ImageUploading extends GetImageState {}

final class ImagePicked extends GetImageState {
  final File image;
  final String imageUrl;

  const ImagePicked({required this.image, required this.imageUrl});

  @override
  List<Object> get props => [image, imageUrl];
}

final class ImageError extends GetImageState {
  final String message;

  const ImageError({required this.message});

  @override
  List<Object> get props => [message];
}
