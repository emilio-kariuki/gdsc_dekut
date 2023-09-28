import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/local_storage/shared_preference_manager.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<GetTheme>((event, emit) async {
      final isDark = await SharedPreferencesManager().getAppTheme();
      emit(AppTheme(isDark: isDark));
    });

    on<ChangeTheme>((event, emit) async {
      final isDark = await SharedPreferencesManager().getAppTheme();
      if (isDark) {
        await SharedPreferencesManager().setAppTheme(value: false);
        emit(AppTheme(isDark: false));
      } else {
        await SharedPreferencesManager().setAppTheme(value: true);
        emit(AppTheme(isDark: true));
      }
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final isDark = json["isDark"] as bool;
    return AppTheme(isDark: isDark);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    if (state is AppTheme) {
      return {"isDark": state.isDark};
    }
  }
}
