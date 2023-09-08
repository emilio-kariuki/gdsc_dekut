part of 'image_download_cubit.dart';

sealed class ImageDownloadState extends Equatable {
  const ImageDownloadState();

  @override
  List<Object> get props => [];
}

final class ImageDownloadInitial extends ImageDownloadState {}

final class Saved extends ImageDownloadState {}

final class Saving extends ImageDownloadState {}

final class DownloadError extends ImageDownloadState {
  final String message;

  const DownloadError({required this.message});

  @override
  List<Object> get props => [message];
}
