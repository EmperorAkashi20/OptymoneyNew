import 'package:flutter/material.dart';
import 'package:optymoney/Settings/Components/body.dart';

class Settings extends StatelessWidget {
  static String routeName = '/Settings';
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
