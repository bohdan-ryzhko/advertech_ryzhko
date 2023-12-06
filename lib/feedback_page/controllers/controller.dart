import 'package:advertech_ryzhko/feedback_page/models/model.dart';
import 'package:advertech_ryzhko/feedback_page/service/service.dart';
import 'package:flutter/material.dart';

class FeedbackFormController extends ChangeNotifier {
  FeedbackFormController({
    required this.service,
    AsyncSnapshot<FeedbackType> feedback = const AsyncSnapshot.nothing(),
    bool isLoad = false,
  })  : _feedback = feedback,
        _isLoad = isLoad;

  final Service service;

  bool get isLoad => _isLoad;
  bool _isLoad;

  AsyncSnapshot<FeedbackType> _feedback;
  AsyncSnapshot<FeedbackType> get feedback => _feedback;

  Future<void> sendFeedback({
    required String name,
    required String email,
    required String message,
    required BuildContext context,
  }) async {
    try {
      Future.microtask(() {
        _isLoad = true;
        notifyListeners();
      });

      if (_feedback.connectionState == ConnectionState.waiting) {
        return;
      }

      final response = await service.submitFeedback(
        name: name,
        email: email,
        message: message,
      );

      _feedback = AsyncSnapshot.withData(ConnectionState.done, response);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Send message success!")),
      );
    } catch (error) {
      _feedback = AsyncSnapshot.withError(ConnectionState.done, error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message was not sent, please try again later"),
        ),
      );
    } finally {
      _isLoad = false;
      notifyListeners();
    }
  }

  void clearFeedback() {
    _feedback = const AsyncSnapshot.nothing();
    notifyListeners();
  }
}
