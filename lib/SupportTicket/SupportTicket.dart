import 'package:flutter/material.dart';
import 'package:optymoney/SupportTicket/Components/Body.dart';

class SupportTicket extends StatelessWidget {
  static String routeName = '/supportTicket';
  const SupportTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
