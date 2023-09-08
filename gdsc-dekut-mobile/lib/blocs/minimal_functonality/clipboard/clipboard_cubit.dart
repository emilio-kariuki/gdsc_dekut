import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/providers/app_providers.dart';

part 'clipboard_state.dart';

class ClipboardCubit extends Cubit<ClipboardState> {
  ClipboardCubit() : super(ClipboardInitial());

  void copyToClipboard({required String text}) async {
    try {
      await AppProviders().copyToClipboard(text: text);
      emit(Copied());
    } catch (e) {
      emit(ClipboardError(message: e.toString()));
    }
  }
}
