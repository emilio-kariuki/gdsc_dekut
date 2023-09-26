import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/services/providers/app_providers.dart';

part 'pick_twitter_time_state.dart';

class PickTwitterTimeCubit extends Cubit<PickTwitterTimeState> {
  PickTwitterTimeCubit() : super(PickTwitterTimeInitial());

  void pickSpaceTime({required BuildContext context}) async {
    final time = await AppProviders().selectSpaceTime(context);
    emit(TwitterTimePicked(timestamp: time));
  }
}
