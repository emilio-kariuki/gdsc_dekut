import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/providers/app_providers.dart';

part 'get_image_state.dart';

class GetImageCubit extends Cubit<GetImageState> {
  GetImageCubit() : super(GetImageInitial());

  void getImage() async {
    try {
      final pickedFile = await AppProviders().getImage();
      emit(ImageUploading());
      final imageUrl = await AppProviders().uploadImage(image: pickedFile);
      Future.delayed(const Duration(milliseconds: 1500));
      emit(ImagePicked(image: File(pickedFile.path), imageUrl: imageUrl));
    } catch (e) {
      emit(ImageError(message: e.toString()));
    }
  }
}
