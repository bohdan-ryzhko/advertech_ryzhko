import 'package:advertech_ryzhko/feedback_page/models/model.dart';
import 'package:advertech_ryzhko/feedback_page/repository/repository.dart';

class Service {
  final Repository repository;

  Service(this.repository);

  Future<FeedbackType> submitFeedback({
    required String name,
    required String email,
    required String message,
  }) async {
    return await repository.createFeedback(
      name: name,
      email: email,
      message: message,
    );
  }
}
