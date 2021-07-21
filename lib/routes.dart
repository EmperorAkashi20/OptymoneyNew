import 'package:flutter/widgets.dart';
import 'package:optymoney/BestPerformingFunds/BestPerformingFunds.dart';
import 'package:optymoney/BestPerformingFunds/Components/DetailsPage.dart';
import 'package:optymoney/Calculators/calculators.dart';
import 'package:optymoney/Dashboard/Components/DetailsPage.dart';
import 'package:optymoney/Dashboard/dashboard.dart';
import 'package:optymoney/ITR/incometax.dart';
import 'package:optymoney/Investments/investments.dart';
import 'package:optymoney/LoginNSignUp/loginNsignup.dart';
import 'package:optymoney/LoginWithMpin/LoginWithMPin.dart';
import 'package:optymoney/PinSetupLogin/PinSetupLogin.dart';
import 'package:optymoney/Settings/Settings.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginAndSignUp.routeName: (context) => LoginAndSignUp(),
  Dashboard.routeName: (context) => Dashboard(),
  IncomeTax.routeName: (context) => IncomeTax(),
  Settings.routeName: (context) => Settings(),
  Investments.routeName: (context) => Investments(),
  DetailsPage.routeName: (context) => DetailsPage(),
  Calculators.routeName: (context) => Calculators(),
  BestPerformingFunds.routeName: (context) => BestPerformingFunds(),
  SingleProductDetailsPage.routeName: (context) => SingleProductDetailsPage(),
  PinSetupLogin.routeName: (context) => PinSetupLogin(),
  LoginWithMPin.routeName: (context) => LoginWithMPin(),
};
