import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/Dashboard/dashboard.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/main.dart';
import 'package:pinput/pin_put/pin_put.dart';

makeSetMpinRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=savePin&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'userid': LoginSignUp.globalUserId,
    'mpin': Body.mpin,
  };
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  //int statusCode = response.statusCode;
  Body.responseBody = (response.body);
  //print(responseBody);
}

class Body extends StatefulWidget {
  static var mpin;
  static var responseBody;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'MPIN Setup',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Since this is the 1st time you are signing in from our mobile app, you need to setup an mpin',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: animatingBordersForMpin(),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    Body.mpin = _pinPutController.text.toString();
                  });
                  await makeSetMpinRequest();
                  if (Body.responseBody != 1) {
                    Navigator.pushNamed(context, Dashboard.routeName);
                    await MyApp.prefs.setString('pinSet', 'Yes');
                  } else {
                    print('object');
                  }
                },
                child: PrimaryButton(btnText: 'Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget animatingBordersForMpin() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(
        color: Color(0xFFBB9B9B9).withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(15.0),
      color: Color(0xFFBB9B9B9).withOpacity(0.5),
    );
    return PinPut(
      obscureText: '*',
      fieldsCount: 4,
      eachFieldHeight: 50.0,
      eachFieldWidth: 50,
      withCursor: false,
      //onSubmit: (String pin) => _showSnackBar(pin),
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      submittedFieldDecoration: pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(20.0),
      ),
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0xFFBB9B9B9).withOpacity(0.5),
        ),
      ),
    );
  }
}
