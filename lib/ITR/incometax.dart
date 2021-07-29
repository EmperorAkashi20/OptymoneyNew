import 'package:flutter/material.dart';
import 'package:optymoney/ITR/Components/Body.dart';

class IncomeTax extends StatelessWidget {
  static String routeName = '/IncomeTax';
  const IncomeTax({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
