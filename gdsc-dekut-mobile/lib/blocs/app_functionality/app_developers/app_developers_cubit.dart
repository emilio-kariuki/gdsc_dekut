import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/developer_model.dart';

import '../../../data/services/providers/developer_providers.dart';

part 'app_developers_state.dart';

class AppDevelopersCubit extends Cubit<AppDevelopersState> {
  AppDevelopersCubit() : super(AppDevelopersInitial());

  void getDevelopers() async {
    try {
      emit(AppDevelopersLoading());
      final developers = await DeveloperProviders().getDevelopers();
      emit(AppDevelopersSuccess(appDevelopers: developers));
    } catch (e) {
      emit(const AppDevelopersError(message: "Failed to load developers"));
    }
  }
}
