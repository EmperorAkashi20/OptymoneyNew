import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/Settings/Settings.dart';
import 'package:optymoney/main.dart';

makeUpdateUserInfoRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=settinginfoapp&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'cust_name': LoginSignUp.globalName,
    'birthday': Body.dob,
    'sex': Body.sex,
    'aadhar_num': LoginSignUp.aadhar,
    'nominee': LoginSignUp.nomineeName,
    'line1': LoginSignUp.customerAddress1,
    'line2': LoginSignUp.customerAddress2,
    'line3': LoginSignUp.customerAddress3,
    'city': LoginSignUp.customerCity,
    'state': LoginSignUp.customerState,
    'pincode': LoginSignUp.customerPinCode,
    'country': LoginSignUp.customerCountry,
    'r_of_nominee_w_app': LoginSignUp.nomineeRelation,
    'uid': LoginSignUp.globalUserId,
    'pan': LoginSignUp.globalPan,
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
  var jsonData = responseBody;

  var parsedJson = json.decode(jsonData);
  print(parsedJson);
  Body.message = parsedJson['msg'].toString();
  Body.status = parsedJson['status'].toString();
}

class Body extends StatefulWidget {
  static var sex;
  static var dob;
  static var message;
  static var status;

  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        helpText: "SELECT YOUR DATE OF BIRTH",
        confirmText: "CONFIRM",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        var bday = picked.toString();
        Body.dob = bday.substring(0, 10);
      });
  }

  TextEditingController aadharController = new TextEditingController();
  TextEditingController panController = new TextEditingController();
  TextEditingController nomineeController = new TextEditingController();
  TextEditingController relationWithController = new TextEditingController();
  TextEditingController address1Controller = new TextEditingController();
  TextEditingController address2Controller = new TextEditingController();
  TextEditingController address3Controller = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController pinController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  var _options = [
    'Male',
    'Female',
    'Transgender',
    'Rather Not Say',
  ];
  String _currentItemSelected = 'Male';

  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _page1Width = 0;
  double _page1Height = 0;
  double _page1Opacity = 1;
  double _page1YOffset = 0;
  double _page1XOffset = 0;

  double _page2YOffset = 0;
  double _page2Width = 0;
  double _page2Opacity = 1;
  double _page2XOffset = 0;

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

    _page1Height = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _page1Width = windowWidth;
        _page1Height = _keyboardVisible ? windowHeight : windowHeight - 270;
        _page1YOffset = _keyboardVisible ? 20 : 270;
        _page1YOffset = windowHeight;
        _page1XOffset = 0;
        _page1Opacity = 1;

        _page2Width = windowWidth;
        _page2YOffset = windowHeight;
        _page2XOffset = 0;

        break;

      case 1:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 90;

        _page1Width = windowWidth;
        _page1YOffset = _keyboardVisible ? 20 : 270;
        _page1Height = _keyboardVisible ? windowHeight : windowHeight - 270;
        _page1XOffset = 0;
        _page1Opacity = 1;

        _page2Width = windowWidth;
        _page2XOffset = 0;
        _page2YOffset = windowHeight;

        break;

      case 2:
        _backgroundColor = Color(0xFF4563DB);
        _headingColor = Colors.white;

        _headingTop = 80;

        _page1Width = windowWidth - 40;
        _page1YOffset = _keyboardVisible ? 20 : 240;
        _page1Height = _keyboardVisible ? windowHeight : windowHeight - 270;
        _page1XOffset = 20;
        _page1Opacity = 0.7;

        _page2XOffset = 0;
        _page2Width = windowWidth;
        _page2YOffset = _keyboardVisible ? 20 : 270;
        _page2Opacity = 1;

        break;
    }
    return Stack(
      key: globalKey1,
      children: [
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
                          "Complete Your Profile",
                          style: TextStyle(color: _headingColor, fontSize: 28),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "According to the government rules in India, you cannot invest without your PAN details. Please Complete your profile and enter correct details.",
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
          width: _page1Width,
          height: _page1Height,
          transform: Matrix4.translationValues(_page1XOffset, _page1YOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_page1Opacity),
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
                      'Please enter all necessary details',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    children: [
                      InputWithIcon(
                        icon: Icons.credit_card_rounded,
                        hint: 'Aadhar Number',
                        dataController: aadharController,
                        obscureText: false,
                        keyboardTypeGlobal: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.credit_card_rounded,
                        hint: 'PAN Number',
                        dataController: panController,
                        obscureText: false,
                        keyboardTypeGlobal: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.person,
                        hint: 'Nominee Name',
                        dataController: nomineeController,
                        obscureText: false,
                        keyboardTypeGlobal: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.person,
                        hint: 'Relation With Nominee',
                        dataController: relationWithController,
                        obscureText: false,
                        keyboardTypeGlobal: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              width: windowWidth * 0.4,
                              height: windowHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color(0xFFBC7C7C7), width: 2),
                              ),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    disabledHint: Text('Choose One'),
                                    hint: Text('Choose One'),
                                    isExpanded: true,
                                    menuMaxHeight: windowHeight * 0.2,
                                    items: _options
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0, right: 6.0),
                                              child: Text(
                                                dropDownStringItem,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected) {
                                      _dropDownItemSelected(newValueSelected);
                                      if (_currentItemSelected == 'Male') {
                                        Body.sex = 'Male';
                                      } else if (_currentItemSelected ==
                                          'Female') {
                                        Body.sex = 'Female';
                                      } else if (_currentItemSelected ==
                                          'Rather Not Say') {
                                        Body.sex = 'Not Provided';
                                      } else if (_currentItemSelected ==
                                          'Transgender') {
                                        Body.sex = 'Transgender';
                                      }
                                    },
                                    value: _currentItemSelected,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: windowWidth * 0.4,
                              height: windowHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color(0xFFBC7C7C7), width: 2),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () => _selectDate(context),
                                  child: Body.dob.toString() == 'null'
                                      ? Text('Tap to Select DOB')
                                      : Text(Body.dob.toString()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (aadharController.text.isEmpty &&
                          panController.text.isEmpty &&
                          nomineeController.text.isEmpty &&
                          relationWithController.text.isEmpty &&
                          Body.dob.toString() == 'null') {
                        _showSnackBar('No Fields can be empty');
                      } else if (aadharController.text.isEmpty) {
                        _showSnackBar('Enter Your Aadhar Number');
                      } else if (aadharController.text.length < 12 ||
                          aadharController.text.length > 12) {
                        _showSnackBar('Please recheck your aadhar number');
                      } else if (panController.text.isEmpty) {
                        _showSnackBar('Enter Your PAN Number');
                      } else if (nomineeController.text.isEmpty) {
                        _showSnackBar('Enter Nominee Name');
                      } else if (relationWithController.text.isEmpty) {
                        _showSnackBar('Enter Your Relation with nominee');
                      } else if (Body.dob.toString() == 'null') {
                        _showSnackBar('Enter Your Date Of Birth');
                      } else {
                        setState(() {
                          LoginSignUp.aadhar.aadhar =
                              aadharController.text.toString();
                          LoginSignUp.globalPan = panController.text.toString();
                          LoginSignUp.nomineeName =
                              nomineeController.text.toString();
                          LoginSignUp.nomineeRelation =
                              relationWithController.text.toString();
                          Body.sex = _currentItemSelected;
                          _pageState = 2;
                        });
                      }
                    },
                    child: PrimaryButton(btnText: "Continue"),
                  ),
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _page2Width,
          //height: _page2Height,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          transform: Matrix4.translationValues(_page2XOffset, _page2YOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_page2Opacity),
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
                  'Please enter all necessary details',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InputWithIcon(
                icon: Icons.location_city,
                hint: "Address Line 1",
                obscureText: false,
                dataController: address1Controller,
                keyboardTypeGlobal: TextInputType.name,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_city,
                hint: "Address Line 2",
                obscureText: false,
                dataController: address2Controller,
                keyboardTypeGlobal: TextInputType.emailAddress,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_city,
                hint: 'Address Line 3',
                obscureText: false,
                dataController: address3Controller,
                keyboardTypeGlobal: TextInputType.number,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_pin,
                hint: 'City',
                obscureText: false,
                dataController: cityController,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_pin,
                hint: 'State',
                obscureText: false,
                dataController: stateController,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_pin,
                hint: 'Pin Code',
                obscureText: false,
                dataController: pinController,
              ),
              SizedBox(height: 5),
              InputWithIcon(
                icon: Icons.location_searching,
                hint: 'Country',
                obscureText: false,
                dataController: countryController,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (address1Controller.text.isEmpty &&
                      address2Controller.text.isEmpty &&
                      cityController.text.isEmpty &&
                      stateController.text.isEmpty &&
                      pinController.text.isEmpty &&
                      countryController.text.isEmpty) {
                    _showSnackBar('Please fill the form correctly');
                  } else if (address1Controller.text.isEmpty ||
                      address2Controller.text.isEmpty) {
                    _showSnackBar('Please Enter your address properly');
                  } else if (cityController.text.isEmpty ||
                      stateController.text.isEmpty ||
                      pinController.text.isEmpty ||
                      countryController.text.isEmpty) {
                    _showSnackBar('Please Enter your location details');
                  }
                },
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      LoginSignUp.customerAddress1 =
                          address1Controller.text.toString();
                      LoginSignUp.customerAddress2 =
                          address2Controller.text.toString();
                      LoginSignUp.customerAddress3 =
                          address3Controller.text.toString();
                      LoginSignUp.customerCity = cityController.text.toString();
                      LoginSignUp.customerState =
                          stateController.text.toString();
                      LoginSignUp.customerCountry =
                          countryController.text.toString();
                      LoginSignUp.customerPinCode =
                          pinController.text.toString();
                    });
                    await makeUpdateUserInfoRequest();
                    if (Body.status == '1') {
                      Navigator.pushNamed(context, Settings.routeName);
                      _showSnackBar(Body.message);
                    } else {
                      _showSnackBar('Something went wrong');
                    }
                  },
                  child: PrimaryButton(
                      btnText: 'I confirm that entered detials are correct'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ],
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

  void _dropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected.toString();
    });
  }
}
