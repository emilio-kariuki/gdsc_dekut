import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/providers/app_providers.dart';

part 'image_download_state.dart';

class ImageDownloadCubit extends Cubit<ImageDownloadState> {
  ImageDownloadCubit() : super(ImageDownloadInitial());

    void downloadAndSaveImage(
      {required String image, required String fileName}) async {
    try {
      emit(Saving());
      await AppProviders().downloadAndSaveImage(url: image, fileName: fileName);
      emit(Saved());
    } catch (e) {
      emit(DownloadError(message: e.toString()));
    }
  }
}
