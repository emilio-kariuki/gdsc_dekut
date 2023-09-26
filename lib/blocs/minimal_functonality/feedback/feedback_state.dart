part of 'feedback_cubit.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackSuccess extends FeedbackState {
  final List<FeedbackModel> feedbacks;

  const FeedbackSuccess({required this.feedbacks});

  @override
  List<Object> get props => [feedbacks];
}

final class FeedbackFetched extends FeedbackState {
  final FeedbackModel feedback;

  const FeedbackFetched({required this.feedback});

  @override
  List<Object> get props => [feedback];
}

final class FeedbackCreated extends FeedbackState {}

final class FeedbackUpdated extends FeedbackState {}

final class FeedbackDeleted extends FeedbackState {}

final class FeedbackError extends FeedbackState {
  final String message;

  const FeedbackError({required this.message});

  @override
  List<Object> get props => [message];
}
