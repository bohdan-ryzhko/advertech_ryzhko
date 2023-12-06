import 'package:advertech_ryzhko/feedback_page/models/model.dart';
import 'package:dio/dio.dart';

class Repository {
  final Dio _dio = Dio();
  Dio get dio => _dio;

  final String _baseUrl = "https://api.byteplex.info/api/test";
  String get baseUrl => _baseUrl;

  Future<FeedbackType> createFeedback({
    required String name,
    required String email,
    required String message,
  }) async {
    final Map<String, String> data = {
      "name": name,
      "email": email,
      "message": message,
    };

    final response = await dio.post("$baseUrl/contact/", data: data);

    final responseName = response.data['name'];
    final responseEmail = response.data['email'];
    final responseMessage = response.data['message'];

    return FeedbackType(
      name: responseName,
      email: responseEmail,
      message: responseMessage,
    );
  }
}
