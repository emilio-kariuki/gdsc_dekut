import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/services/providers/remote_config_providers.dart';

part 'show_spaces_state.dart';

class ShowSpacesCubit extends Cubit<ShowSpacesState> {
  ShowSpacesCubit() : super(ShowSpacesInitial());

  void showTwitterSpaces() async {
    try {
      final response = await RemoteConfigProviders().showTwitterSpaces();
      emit(ShowTwitterSpaces(response));
    } catch (e) {
      emit(ShowTwitterSpaces(false));
    }
  }
}
