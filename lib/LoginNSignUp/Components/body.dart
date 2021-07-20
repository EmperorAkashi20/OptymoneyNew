import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/Dashboard/dashboard.dart';
import 'package:optymoney/main.dart';
import 'package:pinput/pin_put/pin_put.dart';

makeLoginRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=doLoginApp&subaction=loginSubmit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'email': Body.email, 'passwd': Body.password});
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = response.body;
  print(responseBody);
  var jsonData = responseBody;

  var parsedJson = json.decode(jsonData);
  var status = parsedJson['status'].toString();
  print(status);
  var message = parsedJson['message'].toString();
  print(message);
}

class Body extends StatefulWidget {
  static String? email;
  static String? password;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  TextEditingController _emailControllerSignIn = new TextEditingController();
  TextEditingController _passwordControllerSignIn = new TextEditingController();
  TextEditingController _emailControllerSignUp = new TextEditingController();
  TextEditingController _phoneControllerSignUp = new TextEditingController();
  TextEditingController _nameControllerSignUp = new TextEditingController();
  TextEditingController _passControllerSignUp = new TextEditingController();
  TextEditingController _rePassControllerSignUp = new TextEditingController();
  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _loginYOffset = 0;
  double _loginXOffset = 0;

  double _registerYOffset = 0;
  double _registerHeight = 0;
  double _registerWidth = 0;
  double _registerOpacity = 1;
  double _registerXOffset = 0;

  double _otpXOffset = 0;
  double _otpYOffset = 0;
  double _otpHeight = 0;
  double _otpWidth = 0;
  double _otpOpacity = 1;

  double _mpinXOffset = 0;
  double _mpinYOffset = 0;
  double _mpinHeight = 0;
  double _mpinWidth = 0;
  double _mpinOpacity = 1;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;
    _otpHeight = windowHeight - 270;
    _mpinHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _loginYOffset = _keyboardVisible ? 20 : 270;
        _loginYOffset = windowHeight;
        _loginXOffset = 0;
        _loginOpacity = 1;

        _registerWidth = windowWidth;
        _registerYOffset = windowHeight;
        _registerXOffset = 0;

        _otpWidth = windowWidth;
        _otpYOffset = windowHeight;
        _otpXOffset = 0;

        _mpinYOffset = windowHeight;
        _mpinXOffset = 0;
        _mpinWidth = windowWidth;

        break;

      case 1:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginYOffset = _keyboardVisible ? 20 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _loginXOffset = 0;
        _loginOpacity = 1;

        _registerWidth = windowWidth;
        _registerXOffset = 0;
        _registerYOffset = windowHeight;

        _otpWidth = windowWidth;
        _otpYOffset = windowHeight;
        _otpXOffset = 0;

        _mpinWidth = windowWidth;
        _mpinYOffset = windowHeight;
        _mpinXOffset = 0;

        break;

      case 2:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginYOffset = _keyboardVisible ? 20 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _loginXOffset = 20;
        _loginOpacity = 0.7;

        _registerXOffset = 0;
        _registerWidth = windowWidth;
        _registerYOffset = _keyboardVisible ? 20 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _registerOpacity = 1;

        _otpWidth = windowWidth;
        _otpYOffset = windowHeight;
        _otpXOffset = 0;

        _mpinWidth = windowWidth;
        _mpinYOffset = windowHeight;
        _mpinXOffset = 0;

        break;

      case 3:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 70;

        _loginYOffset = _keyboardVisible ? 50 : 240;
        _loginOpacity = 0.5;

        _registerYOffset = _keyboardVisible ? 40 : 260;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _registerXOffset = 10;
        _registerWidth = windowWidth - 20;
        _registerOpacity = 0.7;

        _otpWidth = windowWidth;
        _otpYOffset = _keyboardVisible ? 20 : 275;
        _otpHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _otpXOffset = 0;
        _otpOpacity = 1;

        _mpinWidth = windowWidth;
        _mpinYOffset = windowHeight;
        _mpinXOffset = 0;

        break;

      case 4:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 60;

        _loginYOffset = 210;
        _loginOpacity = 0.3;

        _registerXOffset = 15;
        _registerWidth = windowWidth - 30;
        _registerYOffset = 230;
        _registerOpacity = 0.5;

        _otpWidth = windowWidth - 20;
        _otpYOffset = 250;
        _otpXOffset = 10;
        _otpOpacity = 0.7;
        _otpYOffset = _keyboardVisible ? 10 : 250;

        _mpinYOffset = _keyboardVisible ? 20 : 270;
        _mpinHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        break;
    }

    return Stack(
      key: globalKey,
      children: <Widget>[
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          color: _backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 0;
                  });
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 1000),
                        margin: EdgeInsets.only(
                          top: _headingTop,
                        ),
                        child: Text(
                          "Invest Freely",
                          style: TextStyle(color: _headingColor, fontSize: 28),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "We make investing and managing your portfolio easy for you.\nStart your savings today!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _headingColor, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: SvgPicture.asset('assets/icons/signup.svg'),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_pageState != 0) {
                        _pageState = 0;
                      } else {
                        _pageState = 1;
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFB40284A),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          width: _loginWidth,
          height: _loginHeight,
          transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_loginOpacity),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Enter your details to login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    children: [
                      InputWithIcon(
                        icon: Icons.person,
                        hint: 'Email',
                        dataController: _emailControllerSignIn,
                        obscureText: false,
                        keyboardTypeGlobal: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.vpn_key,
                        hint: 'Password',
                        dataController: _passwordControllerSignIn,
                        obscureText: true,
                        keyboardTypeGlobal: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (_emailControllerSignIn.text.isEmpty &&
                          _passwordControllerSignIn.text.isEmpty) {
                        _showSnackBar('Fields cannot be empty');
                      } else if (_emailControllerSignIn.text.isEmpty) {
                        _showSnackBar('Please enter a valid email address');
                      } else if (_passwordControllerSignIn.text.isEmpty) {
                        _showSnackBar('Password cannot be empty');
                      } else {
                        Body.email = _emailControllerSignIn.text.toString();
                        Body.password =
                            _passwordControllerSignIn.text.toString();
                        await makeLoginRequest();
                        Navigator.pushNamed(context, Dashboard.routeName);
                      }
                    },
                    child: PrimaryButton(btnText: 'Login'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    child: OutlineBtn(btnText: "Register With Us"),
                  ),
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _registerWidth,
          //height: _registerHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform:
              Matrix4.translationValues(_registerXOffset, _registerYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_registerOpacity),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Create a new account',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InputWithIcon(
                icon: Icons.person,
                hint: "Name",
                obscureText: false,
                dataController: _nameControllerSignUp,
                keyboardTypeGlobal: TextInputType.name,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.person,
                hint: "Email Id",
                obscureText: false,
                dataController: _emailControllerSignUp,
                keyboardTypeGlobal: TextInputType.emailAddress,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.phone,
                hint: "Mobile Number",
                obscureText: false,
                dataController: _phoneControllerSignUp,
                keyboardTypeGlobal: TextInputType.number,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.vpn_key,
                hint: "Password",
                obscureText: true,
                dataController: _passControllerSignUp,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.vpn_key,
                hint: "Password",
                obscureText: true,
                dataController: _rePassControllerSignUp,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_nameControllerSignUp.text.isEmpty ||
                      _emailControllerSignUp.text.isEmpty ||
                      _phoneControllerSignUp.text.isEmpty ||
                      _passControllerSignUp.text.isEmpty ||
                      _rePassControllerSignUp.text.isEmpty) {
                    setState(() {
                      _showSnackBar('Fields Cannot be empty');
                    });
                  } else if (_passControllerSignUp.text !=
                      _rePassControllerSignUp.text) {
                    setState(() {
                      _showSnackBar('Passwords Do Not Match');
                    });
                  } else {
                    setState(() {
                      _pageState = 3;
                      _showSnackBar('Check Your Inbox for OTP');
                    });
                  }
                },
                child: PrimaryButton(btnText: 'Continue'),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 1;
                  });
                },
                child: OutlineBtn(btnText: 'Back to Login'),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _otpWidth,
          height: _otpHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(_otpXOffset, _otpYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_otpOpacity),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Enter the OTP',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: animatingBorders(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showSnackBar('Sent');
                        },
                        child: Text('Resend OTP'),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print(_pinPutController.text);
                        _pageState = 4;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: PrimaryButton(btnText: 'Continue'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _showSnackBar('Sent');
                  //       print('sent');
                  //     });
                  //   },
                  //   child: OutlineBtn(btnText: 'Resend OTP'),
                  // ),
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          height: _mpinHeight,
          padding: EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(_mpinXOffset, _mpinYOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Set your 4 digit MPIN',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Form(
                child: animatingBordersForMpin(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Dashboard.routeName);
                },
                child: PrimaryButton(btnText: 'I am ready!'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget animatingBorders() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(
        color: Color(0xFFBB9B9B9).withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(15.0),
      color: Color(0xFFBB9B9B9).withOpacity(0.5),
    );
    return PinPut(
      obscureText: '*',
      fieldsCount: 6,
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
