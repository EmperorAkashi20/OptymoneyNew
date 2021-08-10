import 'package:flutter/widgets.dart';
import 'package:optymoney/BankDetails/BankDetails.dart';
import 'package:optymoney/BestPerformingFunds/BestPerformingFunds.dart';
import 'package:optymoney/BestPerformingFunds/Components/DetailsPage.dart';
import 'package:optymoney/Calculators/Components/LifeGoalsDetailsPage.dart';
import 'package:optymoney/Calculators/Components/LifeGoalsSchemes.dart';
import 'package:optymoney/Calculators/calculators.dart';
import 'package:optymoney/Cart/Cart.dart';
import 'package:optymoney/CompleteProfile/CompleteProfile.dart';
import 'package:optymoney/Dashboard/Components/DetailsPage.dart';
import 'package:optymoney/Dashboard/dashboard.dart';
import 'package:optymoney/Feedback/Feedback.dart';
import 'package:optymoney/ITR/incometax.dart';
import 'package:optymoney/Investments/Components/DetailsPage.dart';
import 'package:optymoney/Investments/investments.dart';
import 'package:optymoney/LoginNSignUp/loginNsignup.dart';
import 'package:optymoney/LoginWithMpin/LoginWithMPin.dart';
import 'package:optymoney/Onboarding/Onboarding.dart';
import 'package:optymoney/Orders/Orders.dart';
import 'package:optymoney/PinSetupLogin/PinSetupLogin.dart';
import 'package:optymoney/Settings/Components/PrivacyPolicy.dart';
import 'package:optymoney/Settings/Settings.dart';
import 'package:optymoney/SupportTicket/SupportTicket.dart';
import 'package:optymoney/ViewProfile/ViewProfile.dart';
import 'package:optymoney/graphtest.dart';

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
  CompleteProfile.routeName: (context) => CompleteProfile(),
  ViewProfile.routeName: (context) => ViewProfile(),
  BankDetails.routeName: (context) => BankDetails(),
  Cart.routeName: (context) => Cart(),
  Orders.routeName: (context) => Orders(),
  FeedbackApp.routeName: (context) => FeedbackApp(),
  SupportTicket.routeName: (context) => SupportTicket(),
  DetailsPageFilters.routeName: (context) => DetailsPageFilters(),
  Onboarding.routeName: (context) => Onboarding(),
  GraphTest.routeName: (context) => GraphTest(),
  LifeGoalsSchemes.routeName: (context) => LifeGoalsSchemes(),
  SingleProductDetailsPage1.routeName: (context) => SingleProductDetailsPage1(),
  PrivacyPolicy.routeName: (context) => PrivacyPolicy(),
};
