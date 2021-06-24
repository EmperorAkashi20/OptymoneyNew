import 'package:flutter/material.dart';
import 'package:optymoney/Dashboard/Components/body.dart';

class Dashboard extends StatelessWidget {
  static String routeName = '/Dashboard';
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
