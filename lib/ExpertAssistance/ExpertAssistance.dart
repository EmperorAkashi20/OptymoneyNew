import 'package:flutter/material.dart';
import 'package:optymoney/ExpertAssistance/Components/Body.dart';

class ExpertAssistance extends StatelessWidget {
  static String routeName = 'expertAssistance';
  const ExpertAssistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
