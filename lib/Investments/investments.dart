import 'package:flutter/material.dart';
import 'package:optymoney/Investments/Components/body.dart';

class Investments extends StatelessWidget {
  static String routeName = '/Investments';
  const Investments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
