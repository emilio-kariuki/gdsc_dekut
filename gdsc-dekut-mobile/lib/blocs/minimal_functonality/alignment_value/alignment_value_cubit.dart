import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alignment_value_state.dart';

class AlignmentValueCubit extends Cubit<AlignmentValueState> {
  AlignmentValueCubit() : super(AlignmentValueInitial());

    void changeAlignment({required bool align}) {
    emit(AlignmentChanged(alignment: !align));
  }
}
