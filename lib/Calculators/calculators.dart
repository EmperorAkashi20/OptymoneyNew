import 'package:flutter/material.dart';
import 'package:optymoney/Calculators/Components/Body.dart';

class Calculators extends StatelessWidget {
  static String routeName = '/calculators';
  const Calculators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
