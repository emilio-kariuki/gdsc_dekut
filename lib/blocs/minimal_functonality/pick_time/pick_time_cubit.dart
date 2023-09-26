import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/services/providers/app_providers.dart';

part 'pick_time_state.dart';

class PickTimeCubit extends Cubit<PickTimeState> {
  PickTimeCubit() : super(PickTimeInitial());

   void pickTime({required BuildContext context}) async {
    final time = await AppProviders().selectTime(context);
    emit(TimePicked(time: time));
  }
}
