import 'package:flutter/material.dart';
import 'package:optymoney/PinSetupLogin/Components/Body.dart';

class PinSetupLogin extends StatelessWidget {
  static String routeName = '/PinSetupLogin';
  const PinSetupLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
