import 'package:flutter/material.dart';
import 'package:optymoney/CompleteProfile/Components/Body.dart';

class CompleteProfile extends StatelessWidget {
  static String routeName = '/CompleteProfile';
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
