import 'package:flutter/material.dart';
import 'package:optymoney/Feedback/Components/Body.dart';

class FeedbackApp extends StatelessWidget {
  static String routeName = '/feedback';
  const FeedbackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
