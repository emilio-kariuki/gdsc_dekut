part of 'carousel_value_cubit.dart';

sealed class CarouselValueState extends Equatable {
  const CarouselValueState();

  @override
  List<Object> get props => [];
}

final class CarouselValueInitial extends CarouselValueState {}

final class CarouselChanged extends CarouselValueState {
  final int index;

   const CarouselChanged({required this.index});

  @override
  List<Object> get props => [index];
}

