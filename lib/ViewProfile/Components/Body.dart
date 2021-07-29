import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

makeUserRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=settinginfoapp&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'cust_name': LoginSignUp.globalName,
    'birthday': Body.bday,
    'aadhar_num': Body.aadhar,
    'nominee': Body.nominee,
    'line1': Body.line1,
    'line2': Body.line2,
    'line3': Body.line3,
    'city': Body.city,
    'state': Body.state,
    'pincode': Body.pinCode,
    'country': Body.country,
    'r_of_nominee_w_app': Body.relationWithNominee,
    'uid': LoginSignUp.globalUserId,
    'pan': Body.pan,
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
  //print(responseBody);
  var jsonData = responseBody;

  var parsedJson = json.decode(jsonData);
  //print(parsedJson);
  Body.message = parsedJson['msg'].toString();
}

class Body extends StatefulWidget {
  static var bday;
  static var aadhar;
  static var nominee;
  static var line1;
  static var line2;
  static var line3;
  static var city;
  static var state;
  static var pinCode;
  static var country;
  static var relationWithNominee;
  static var message;
  static var pan;

  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  bool enabled = false;
  TextEditingController cityController =
      new TextEditingController(text: LoginSignUp.customerCity);
  TextEditingController bdayController =
      new TextEditingController(text: LoginSignUp.customerBday);
  TextEditingController mobController =
      new TextEditingController(text: LoginSignUp.customerMobile);
  TextEditingController address1Controller =
      new TextEditingController(text: LoginSignUp.customerAddress1);
  TextEditingController address2Controller =
      new TextEditingController(text: LoginSignUp.customerAddress2);
  TextEditingController address3Controller =
      new TextEditingController(text: LoginSignUp.customerAddress3);
  TextEditingController stateController =
      new TextEditingController(text: LoginSignUp.customerState);
  TextEditingController pinCodeController =
      new TextEditingController(text: LoginSignUp.customerPinCode);
  TextEditingController countryController =
      new TextEditingController(text: LoginSignUp.customerCountry);
  TextEditingController panController =
      new TextEditingController(text: LoginSignUp.globalPan);
  TextEditingController aadharController =
      new TextEditingController(text: LoginSignUp.aadhar);
  TextEditingController nomineeNameController =
      new TextEditingController(text: LoginSignUp.nomineeName);
  TextEditingController nomineeRelationController =
      new TextEditingController(text: LoginSignUp.nomineeRelation);
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.withOpacity(0.3),
        automaticallyImplyLeading: false,
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                setState(() {
                  enabled = true;
                });
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Spacer(),
          CloseButton(
            color: Colors.black,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: callList,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: windowHeight * 0.3,
                width: windowWidth,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Center(
                        child: Text(
                          LoginSignUp.globalLetter,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      LoginSignUp.globalName,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      LoginSignUp.globalEmail,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (LoginSignUp.kycStatus != 'success')
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            print('object');
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blueGrey.shade700),
                          ),
                          height: windowHeight * 0.04,
                          width: windowWidth * 0.4,
                          child: Center(
                            child: Text('Complete Your KYC'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: windowHeight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    InputWithIcon(
                      icon: Icons.cake,
                      enabledOrNot: enabled,
                      hint: "Birthday",
                      obscureText: false,
                      dataController: bdayController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.send_to_mobile_rounded,
                      enabledOrNot: false,
                      hint: 'Mobile No',
                      obscureText: false,
                      dataController: mobController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.location_city,
                      enabledOrNot: enabled,
                      hint: 'Address Line 1',
                      obscureText: false,
                      dataController: address1Controller,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.location_city,
                      enabledOrNot: enabled,
                      hint: 'Address Line 2',
                      obscureText: false,
                      dataController: address2Controller,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      enabledOrNot: enabled,
                      icon: Icons.location_city,
                      hint: 'Address Line 3',
                      obscureText: false,
                      dataController: address3Controller,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.location_pin,
                      hint: 'City',
                      enabledOrNot: enabled,
                      dataController: cityController,
                      obscureText: false,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.location_pin,
                      enabledOrNot: enabled,
                      hint: 'State',
                      obscureText: false,
                      dataController: stateController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.location_pin,
                      enabledOrNot: enabled,
                      hint: 'PIN Code',
                      obscureText: false,
                      dataController: pinCodeController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.my_location,
                      enabledOrNot: enabled,
                      hint: 'Country',
                      obscureText: false,
                      dataController: countryController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.credit_card_rounded,
                      enabledOrNot: enabled,
                      hint: 'PAN Number',
                      obscureText: false,
                      dataController: panController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.credit_card_rounded,
                      enabledOrNot: enabled,
                      hint: 'Aadhar Number',
                      obscureText: false,
                      dataController: aadharController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.people_alt_rounded,
                      enabledOrNot: enabled,
                      hint: 'Nominee Name',
                      obscureText: false,
                      dataController: nomineeNameController,
                      onChanged: (value) => value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputWithIcon(
                      icon: Icons.people_alt_rounded,
                      enabledOrNot: enabled,
                      hint: 'Relation with Nominee',
                      obscureText: false,
                      dataController: nomineeRelationController,
                      onChanged: (value) => value,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: GestureDetector(
                  onTap: () async {
                    Body.bday = bdayController.text.toString();
                    Body.aadhar = aadharController.text.toString();
                    Body.nominee = nomineeNameController.text.toString();
                    Body.line1 = address1Controller.text.toString();
                    Body.line2 = address2Controller.text.toString();
                    Body.line3 = address3Controller.text.toString();
                    Body.city = cityController.text.toString();
                    Body.state = stateController.text.toString();
                    Body.pinCode = pinCodeController.text.toString();
                    Body.country = countryController.text.toString();
                    Body.pan = panController.text.toString();
                    Body.relationWithNominee =
                        nomineeRelationController.text.toString();
                    await makeUserRequest();
                    setState(() {
                      enabled = false;
                    });
                    _showSnackBar(Body.message);
                  },
                  child: OutlineBtn(btnText: 'Save Updated Details'),
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

  Future<void> callList() async {
    //var random = Random();
    refreshkey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
}
