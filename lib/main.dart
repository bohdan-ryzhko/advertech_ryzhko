import 'package:advertech_ryzhko/feedback_page/controllers/controller.dart';
import 'package:advertech_ryzhko/feedback_page/repository/repository.dart';
import 'package:advertech_ryzhko/feedback_page/service/service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:advertech_ryzhko/feedback_page/feedback_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedbackFormController(service: Service(Repository())),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FeedbackPage(),
    );
  }
}
