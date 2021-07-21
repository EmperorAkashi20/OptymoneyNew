import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optymoney/LoginWithMpin/LoginWithMPin.dart';
import 'package:optymoney/OnboardingScreen/onBoarding.dart';
import 'package:optymoney/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey globalKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  MyApp.prefs = await SharedPreferences.getInstance();
  MyApp.user = MyApp.prefs.getString('userId') ?? '0';
  MyApp.email = MyApp.prefs.getString('emailId') ?? '0';
  MyApp.name = MyApp.prefs.getString('name') ?? '0';
  MyApp.pan = MyApp.prefs.getString('pan') ?? '0';
  MyApp.hash = MyApp.prefs.getString('hash') ?? '0';
  MyApp.pinSet = MyApp.prefs.getString('pinSet') ?? '0';
  MyApp.newSignUp = MyApp.prefs.getString('newSingUp') ?? '0';
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  static var prefs;
  static var user;
  static var email;
  static var name;
  static var pan;
  static var hash;
  static var newSignUp;
  static var pinSet;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: MyApp.pinSet == 'Yes' ? LoginWithMPin() : OnboardingScreen(),
      routes: routes,
    );
  }
}
