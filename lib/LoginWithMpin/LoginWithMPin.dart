import 'package:flutter/material.dart';
import 'package:optymoney/LoginWithMpin/Components/Body.dart';

class LoginWithMPin extends StatelessWidget {
  static String routeName = '/LoginWithMpin';
  const LoginWithMPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
