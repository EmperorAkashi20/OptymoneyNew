import 'package:flutter/material.dart';
import 'package:optymoney/BankDetails/Components/Body.dart';

class BankDetails extends StatelessWidget {
  static String routeName = '/BankDetails';
  const BankDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
