import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/ViewProfile/ViewProfile.dart';
import 'package:url_launcher/url_launcher.dart';

makeOnboardRequest() async {
  var url = Uri.parse('https://multi-channel.signzy.tech/api/channels/login');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    "username": 'icici_OPTYmoney_prod',
    "password": 'Ld38M*9HS@rZs9nc#eK\$2OcQ6%D',
  });
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );
  var parsedJson = json.decode(response.body);
  Body.id = parsedJson['id'];
  Body.ttl = parsedJson['ttl'];
  Body.created = parsedJson['created'];
  Body.userId = parsedJson['userId'];
  //print(response.body);
  // print(Body.id);
  // print(Body.ttl);
  // print(Body.created);
  // print(Body.userId);
}

onBoardingProcess() async {
  var url = Uri.parse('https://multi-channel.signzy.tech/api/channels/' +
      Body.userId +
      '/onboardings');

  var body = jsonEncode({
    "email": LoginSignUp.globalEmail,
    "username": Body.kycTodayUn.toString(),
    "phone": LoginSignUp.customerMobile,
    "name": LoginSignUp.globalName,
    "redirectUrl":
        'https://optymoney.com/mySaveTax/?module_interface=a3ljX29uYm9hcmQ=',
    "channelEmail": "support@optymoney.com"
  });
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Authorization': Body.id.toString(),
    },
    body: body,
    encoding: encoding,
  );
  var parsedJson = json.decode(response.body);
  var mobUrl = (parsedJson['createdObj']['mobileAutoLoginUrl']);
  if (await canLaunch(mobUrl)) {
    launch(mobUrl);
  } else {
    throw 'Unable to launch $mobUrl';
  }
}

getDataFunction() {
  var now = DateTime.now();

  Body.kycTodayDateTime = (now.day.toString() +
      now.month.toString() +
      now.year.toString() +
      now.hour.toString() +
      now.minute.toString() +
      now.second.toString());
  Body.kycTodayUn = "opty_" +
      LoginSignUp.globalName
          .toString()
          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
          .toLowerCase() +
      "_" +
      Body.kycTodayDateTime.toString();
  Body.kycData = LoginSignUp.globalEmail.toString() +
      Body.kycTodayUn.toString() +
      LoginSignUp.customerMobile.toString() +
      LoginSignUp.globalName.toString() +
      'support@optymoney.com';
  print(Body.kycTodayUn);
  print(Body.kycData);
}

class Body extends StatefulWidget {
  static var id;
  static var ttl;
  static var created;
  static var userId;
  static var kycTodayDateTime;
  static var kycTodayUn;
  static var kycData;
  static var test;
  static var test1;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    //double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/2.png',
                height: windowHeight * 0.06,
              ),
              Text(
                'Check your data',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(),
            ],
          ),
        ),
        actions: [
          CloseButton(
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: windowHeight * 0.03,
                    ),
                    InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: LoginSignUp.globalName.toString(),
                      obscureText: false,
                      enabledOrNot: false,
                    ),
                    SizedBox(
                      height: windowHeight * 0.01,
                    ),
                    InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: LoginSignUp.globalEmail.toString(),
                      obscureText: false,
                      enabledOrNot: false,
                    ),
                    SizedBox(
                      height: windowHeight * 0.01,
                    ),
                    InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: LoginSignUp.globalPan.toString(),
                      obscureText: false,
                      enabledOrNot: false,
                    ),
                    SizedBox(
                      height: windowHeight * 0.01,
                    ),
                    InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: LoginSignUp.customerMobile.toString(),
                      obscureText: false,
                      enabledOrNot: false,
                    ),
                    SizedBox(
                      height: windowHeight * 0.01,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: windowHeight * 0.35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await getDataFunction();
                        await makeOnboardRequest();
                        if (Body.id != null) {
                          await onBoardingProcess();
                        } else {
                          _showSnackBar(
                              'Something went wrong, please try again later');
                        }
                      },
                      child: PrimaryButton(btnText: 'Proceed'),
                    ),
                    SizedBox(
                      height: windowHeight * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ViewProfile.routeName);
                      },
                      child: OutlineBtn(btnText: 'Edit Details'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 40.0,
        color: Colors.transparent,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
