import 'package:flutter/material.dart';
import 'package:optymoney/Orders/Components/Body.dart';

class Orders extends StatelessWidget {
  static String routeName = '/Orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
