import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(DropDownInitial());

  void dropDownClicked({required String value}) {
    emit(DropDownChanged(value: value));
  }
}
