import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/Dashboard/dashboard.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/LoginNSignUp/loginNsignup.dart';
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
  //print(responseData);
  Body.message = responseData['message'].toString();
  //print(Body.message);
  if (Body.message != 'LOGIN_FAILED') {
    var parsedToken = json.decode(responseData['token']);
    LoginSignUp.globalUserId = parsedToken['caTAX_user_id'].toString();
    LoginSignUp.globalPan = parsedToken['caTAX_pan_number'].toString();
    LoginSignUp.globalEmail = parsedToken['caTAX_email_id'].toString();
    LoginSignUp.globalName = parsedToken['caTAX_user_name'].toString();
    LoginSignUp.globalLetter = LoginSignUp.globalName[0];
  } else {
    print('oops');
  }
}

makeKycRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=kyccheck_api&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    'pan': LoginSignUp.globalPan,
  });
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );
  var parsedJson = json.decode(response.body);
  //print(response.body);
  LoginSignUp.kycStatus = parsedJson['status'].toString();
  //print(LoginSignUp.kycStatus);
}

makeUserRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=getCustomerInfo&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'uid': LoginSignUp.globalUserId,
  };
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

//  var statusCode = response.statusCode;
  var responseBody = response.body;
  var jsonData = responseBody;

  var parsedJson = json.decode(jsonData);
  LoginSignUp.customerId = parsedJson['fr_customer_id'].toString();
  LoginSignUp.customerBday = parsedJson['dob'].toString();
  LoginSignUp.customerAddress1 = parsedJson['address1'].toString();
  LoginSignUp.customerAddress2 = parsedJson['address2'].toString();
  LoginSignUp.customerAddress3 = parsedJson['address3'].toString();
  LoginSignUp.customerMobile = parsedJson['contact_no'].toString();
  LoginSignUp.customerState = parsedJson['state'].toString();
  LoginSignUp.customerCity = parsedJson['city'].toString();
  LoginSignUp.customerPinCode = parsedJson['pincode'].toString();
  LoginSignUp.customerCountry = parsedJson['country'].toString();
  LoginSignUp.nomineeName = parsedJson['nominee_name'].toString();
  LoginSignUp.nomineeRelation = parsedJson['r_of_nominee_w_app'].toString();
  LoginSignUp.aadhar = parsedJson['aadhaar_no'].toString();
}

resetMpinRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=doChangeMpinApp&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'userid': MyApp.user,
    'mpin': Body.resetMpin,
  };
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = response.body;
  var responseData = json.decode(responseBody);
  Body.resetMessage = responseData['message'].toString();
  Body.status = responseData['status'].toString();
}

class Body extends StatefulWidget {
  static var mpin;
  static var message;
  static var resetMessage;
  static var resetMpin;
  static var password;
  static var status;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final _pinPutControllerReset = TextEditingController();
  final _pinPutFocusNodeReset = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    // double windowWidth = MediaQuery.of(context).size.width;
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
                'Login with MPIN',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
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
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: animatingBordersForMpin(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            //barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: windowHeight * 0.6,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: windowHeight * 0.01,
                                      ),
                                      Text(
                                        'MPIN Reset',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: windowHeight * 0.05,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Text(
                                            'New MPIN',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: windowHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Form(
                                          key: _formKey1,
                                          child: animatingBordersForResetMpin(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: windowHeight * 0.05,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Text(
                                            'Your Password',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: windowHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: InputWithIcon(
                                          icon: Icons.vpn_key,
                                          hint: 'Password',
                                          obscureText: true,
                                          dataController: passwordController,
                                        ),
                                      ),
                                      SizedBox(
                                        height: windowHeight * 0.14,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            Body.resetMpin =
                                                _pinPutControllerReset.text
                                                    .toString();
                                            Body.password = passwordController
                                                .text
                                                .toString();
                                            var hashedPass = utf8.encode(
                                                Body.password.toString());
                                            var digest =
                                                sha512256.convert(hashedPass);
                                            if (Body.resetMpin.isEmpty &&
                                                Body.password.isEmpty) {
                                              setState(() {
                                                _showSnackBar(
                                                    'Fields cannot be empty');
                                              });
                                            } else if (Body.resetMpin.isEmpty) {
                                              _showSnackBar(
                                                  'Please enter MPIN');
                                            } else if (Body.password.isEmpty) {
                                              _showSnackBar(
                                                  'Please enter password to confirm');
                                            } else if (digest.toString() !=
                                                MyApp.hash.toString()) {
                                              setState(() {
                                                _showSnackBar(
                                                    'Password incorrect');
                                              });
                                            } else {
                                              await resetMpinRequest();
                                              if (Body.status == 1) {
                                                Navigator.pop(context);
                                                setState(() {
                                                  _showSnackBar(
                                                      Body.resetMessage);
                                                });
                                              } else {
                                                Navigator.pop(context);
                                                _showSnackBar(
                                                    Body.resetMessage);
                                              }
                                            }
                                          },
                                          child:
                                              PrimaryButton(btnText: 'Confirm'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('Forgot MPIN?'),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, LoginAndSignUp.routeName);
                    },
                    child: OutlineBtn(
                      btnText: 'Use Email and password instead',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        Body.mpin = _pinPutController.text.toString();
                      });
                      await makeLoginWithMpinRequest();
                      if (Body.message == 'LOGIN_SUCCESS') {
                        // await makeKycRequest();
                        Navigator.pushNamed(context, Dashboard.routeName);
                        await makeUserRequest();
                      } else if (Body.message == 'LOGIN_FAILED') {
                        _showSnackBar('Entered PIN is incorrect');
                      }
                    },
                    child: PrimaryButton(btnText: 'Confirm'),
                  ),
                ],
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

  Widget animatingBordersForResetMpin() {
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
      focusNode: _pinPutFocusNodeReset,
      controller: _pinPutControllerReset,
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
