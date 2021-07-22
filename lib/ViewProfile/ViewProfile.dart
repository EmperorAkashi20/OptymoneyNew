import 'package:flutter/material.dart';
import 'package:optymoney/ViewProfile/Components/Body.dart';

class ViewProfile extends StatelessWidget {
  static String routeName = '/ViewProfile';
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
