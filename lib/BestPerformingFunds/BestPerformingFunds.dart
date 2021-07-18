import 'package:flutter/material.dart';
import 'package:optymoney/BestPerformingFunds/Components/Body.dart';

class BestPerformingFunds extends StatelessWidget {
  static String routeName = '/bestPerformingFunds';
  const BestPerformingFunds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
