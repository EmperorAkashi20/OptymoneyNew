import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

import '../../Models.dart';

expertAssisstanceRequest() async {
  var url = Uri.parse(
      '${urlWeb}ajax-request/ajax_response.php?action=e_assist_app&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    "tax": Body.tax.toString(),
    "taxFile": Body.taxFile.toString(),
    "taxAssessment": Body.taxAssessment.toString(),
    "investment": Body.investment.toString(),
    "will": Body.will.toString(),
    "ea_name": Body.name,
    "ea_email": Body.email,
    "ea_mobile": Body.mobile,
  });
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );
  print(body);

  var responseBody = response.body;
  //print(responseBody);
  var jsonData = responseBody;
  var parsedJson = json.decode(jsonData);
  Body.status = parsedJson['status'];
  Body.message = parsedJson['message'];
}

class Body extends StatefulWidget {
  static var name;
  static var email;
  static var mobile;
  static var tax;
  static var taxFile;
  static var taxAssessment;
  static var investment;
  static var will;
  static var status;
  static var message;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool checkedValueTax = false;
  bool checkedValueWill = false;
  bool checkedValueInvestments = false;
  bool checkedValueTaxFile = false;
  bool checkedValueTaxAssessment = false;
  TextEditingController nameController =
      new TextEditingController(text: LoginSignUp.globalName);
  TextEditingController emailController =
      new TextEditingController(text: LoginSignUp.globalEmail);
  TextEditingController phoneController =
      new TextEditingController(text: LoginSignUp.customerMobile);
  @override
  Widget build(BuildContext context) {
    // double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;
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
                'Expert Assistance',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              CloseButton(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: windowHeight * 0.02,
                  ),
                  Text(
                    'Need Assistance for:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Tax"),
                    value: checkedValueTax,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValueTax = !checkedValueTax;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  if (checkedValueTax == true)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CheckboxListTile(
                        title: Text("Tax File"),
                        value: checkedValueTaxFile,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValueTaxFile = !checkedValueTaxFile;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                  if (checkedValueTax == true)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CheckboxListTile(
                        title: Text("Tax Assessment"),
                        value: checkedValueTaxAssessment,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValueTaxAssessment =
                                !checkedValueTaxAssessment;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                  CheckboxListTile(
                    title: Text("Investments"),
                    value: checkedValueInvestments,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValueInvestments = !checkedValueInvestments;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: Text("Will"),
                    value: checkedValueWill,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValueWill = !checkedValueWill;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: 'Name',
                      obscureText: false,
                      dataController: nameController,
                    ),
                  ),
                  SizedBox(
                    height: windowHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: 'Email Address',
                      dataController: emailController,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: windowHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputWithIcon(
                      icon: Icons.wrap_text,
                      hint: 'Mobile Number',
                      dataController: phoneController,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: windowHeight * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap: () async {
                        checkedValueTax == true
                            ? Body.tax = "tax"
                            : Body.tax = "";
                        checkedValueTaxFile == true
                            ? Body.taxFile = "taxFile"
                            : Body.taxFile = "";
                        checkedValueTaxAssessment == true
                            ? Body.taxAssessment = "taxFile"
                            : Body.taxAssessment = "";
                        checkedValueInvestments == true
                            ? Body.investment = "investment"
                            : Body.investment = "";
                        checkedValueWill == true
                            ? Body.will = "will"
                            : Body.will = "";
                        Body.name = nameController.text.toString();
                        Body.email = emailController.text.toString();
                        Body.mobile = phoneController.text.toString();
                        await expertAssisstanceRequest();
                        if (Body.status.toString() == '1') {
                          _showSnackBar(Body.message.toString() +
                              ' We will be in touch shortly');
                        }
                      },
                      child: PrimaryButton(btnText: 'Hire An Expert'),
                    ),
                  ),
                ],
              ),
            ),
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
            textAlign: TextAlign.center,
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
