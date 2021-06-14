import 'package:flutter/widgets.dart';
import 'package:optymoney/SignUp/signupscreen.dart';
import 'package:optymoney/WelcomeScreen/welcomescreen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignUpScreen.routeName: (context) => SignUpScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
};
