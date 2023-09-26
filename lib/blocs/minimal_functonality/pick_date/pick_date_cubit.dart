import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/services/providers/app_providers.dart';

part 'pick_date_state.dart';

class PickDateCubit extends Cubit<PickDateState> {
  PickDateCubit() : super(PickDateInitial());

    void pickDate({required BuildContext context}) async {
    final date = await AppProviders().selectDate(context);
    emit(DatePicked(date: date));
  }
}
