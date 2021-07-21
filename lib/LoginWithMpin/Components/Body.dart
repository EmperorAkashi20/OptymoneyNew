import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../main.dart';

makeLoginWithMpinRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=doLoginAppWithPin&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'userid': MyApp.user,
    'mpin': Body.mpin,
  };
  //print(PinForm.mpin);
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = (response.body);
  var responseData = json.decode(responseBody);
  var responseMessgae = responseData['message'].toString();
  if (responseMessgae != 'LOGIN_FAILED') {
    var parsedToken = json.decode(responseData['token']);
    var responseUser = parsedToken['caTAX_user_id'].toString();
    var responsePan = parsedToken['caTAX_pan_number'].toString();

    var userIdGlobal = responseUser;
    var pan = responsePan;
  } else {
    print('oops');
  }
}

class Body extends StatefulWidget {
  static var mpin;
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
                    'Enter Your MPIN',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please enter your MPIN to Login',
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
                  await makeLoginWithMpinRequest();
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
