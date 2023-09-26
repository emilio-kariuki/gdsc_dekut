import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carousel_value_state.dart';

class CarouselValueCubit extends Cubit<CarouselValueState> {
  CarouselValueCubit() : super(CarouselValueInitial());

  void changeCarousel({required int index}) {
    emit(CarouselChanged(index: index));
  }
}
