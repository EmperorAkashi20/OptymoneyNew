import 'package:flutter/widgets.dart';
import 'package:optymoney/LoginNSignUp/loginNsignup.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginAndSignUp.routeName: (context) => LoginAndSignUp(),
};
