import 'package:flutter/material.dart';
import 'package:optymoney/Onboarding/Components/Body.dart';

class Onboarding extends StatefulWidget {
  static String routeName = '/Onboarding';
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
