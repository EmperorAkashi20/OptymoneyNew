import 'package:flutter/material.dart';
import 'package:optymoney/Cart/Components/Body.dart';

class Cart extends StatelessWidget {
  static String routeName = '/Cart';
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
