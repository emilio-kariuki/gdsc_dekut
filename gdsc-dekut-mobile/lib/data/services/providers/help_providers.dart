import '../../models/feedback_model.dart';
import '../../models/report_model.dart';
import '../repositories/help_repository.dart';

class HelpProviders {
  Future<bool> createFeedback({
    required String feedback,
  }) async {
    final response = await HelpRepository().createFeedback(
      feedback: feedback,
    );
    return response;
  }

  Future<bool> reportProblem({
    required String title,
    required String description,
    required String appVersion,
    required String contact,
    required String image,
  }) async {
    final response = await HelpRepository().reportProblem(
      title: title,
      description: description,
      appVersion: appVersion,
      contact: contact,
      image: image,
    );
    return response;
  }

  Future<List<FeedbackModel>> getFeedback() async {
    final response = await HelpRepository().getFeedback();
    return response;
  }

  Future<List<ReportModel>> getReports() async {
    final response = await HelpRepository().getReports();
    return response;
  }
}
