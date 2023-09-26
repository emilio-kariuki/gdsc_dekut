import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/feedback_model.dart';


import '../../../data/services/providers/help_providers.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  void sendFeedBack({required String feedback}) async {
    try {
      emit(FeedbackLoading());
      final isSent = await HelpProviders().createFeedback(feedback: feedback);

      if (isSent) {
        emit(FeedbackCreated());
      } else {
        emit(const FeedbackError(message: 'Failed to send feedback'));
      }
    } catch (e) {
      emit(FeedbackError(message: e.toString()));
    }
  }

  void getAllFeedbacks() async {
    try {
      emit(FeedbackLoading());
      final feedbacks = await HelpProviders().getFeedback();
      emit(FeedbackSuccess(feedbacks: feedbacks));
    } catch (e) {
      emit(const FeedbackError(message: "Failed to load feedbacks"));
    }
  }

  // TODO implement delete feedback

  // TODO implement update feedback

  // TODO implement search feedback

  // TODO implement get feedback by id

  


}
