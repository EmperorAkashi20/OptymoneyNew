import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/Models.dart';

sendFeedbackApp() async {
  var url = Uri.parse(
      '${urlWeb}ajax-request/ajax_response.php?action=feedbackapp&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    'uid': LoginSignUp.globalUserId,
    'opinion': Body.opinion,
    'category': Body.category,
    'content': Body.content,
  });
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  print(body);

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = response.body;
  //print(responseBody);
  var parsedJson = jsonDecode(responseBody);
  Body.message = parsedJson['message'].toString();
  Body.status = parsedJson['status'].toString();
}

class Body extends StatefulWidget {
  static var opinion;
  static var category;
  static var content;
  static var message;
  static var status;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController contentController = new TextEditingController();
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  bool isSelected5 = false;
  bool isSelected6 = false;
  bool isSelected7 = false;
  bool isSelected8 = false;

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
                'Your Feedback',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              CloseButton(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: windowHeight * 0.03,
                ),
                Text(
                  'We would like your feedback to improve ourselves',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: windowHeight * 0.02,
                ),
                Text(
                  'What is your opinion of our services?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: windowHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Body.opinion = '1';
                            isSelected1 = !isSelected1;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                            isSelected5 = false;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.tired,
                          size: 50,
                          color:
                              isSelected1 == true ? Colors.red : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Body.opinion = '2';
                            isSelected2 = !isSelected2;
                            isSelected1 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                            isSelected5 = false;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.frown,
                          size: 50,
                          color:
                              isSelected2 == true ? Colors.red : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Body.opinion = '3';
                            isSelected3 = !isSelected3;
                            isSelected2 = false;
                            isSelected1 = false;
                            isSelected4 = false;
                            isSelected5 = false;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.meh,
                          size: 50,
                          color:
                              isSelected3 == true ? Colors.red : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Body.opinion = '4';
                            isSelected4 = !isSelected4;
                            isSelected1 = false;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected5 = false;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.smile,
                          size: 50,
                          color:
                              isSelected4 == true ? Colors.red : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Body.opinion = '5';
                            isSelected5 = !isSelected5;
                            isSelected2 = false;
                            isSelected3 = false;
                            isSelected4 = false;
                            isSelected1 = false;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.laughBeam,
                          size: 50,
                          color:
                              isSelected5 == true ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.02,
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  'Please select your category from below',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Body.category = 'Suggestion';
                              isSelected6 = !isSelected6;
                              isSelected7 = false;
                              isSelected8 = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: isSelected6 == false
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isSelected6 == false
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              height: windowHeight * 0.07,
                              child: Center(
                                child: Text(
                                  'Suggestion',
                                  style: TextStyle(
                                    color: isSelected6 == false
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Body.category = 'Complain';
                              isSelected7 = !isSelected7;
                              isSelected6 = false;
                              isSelected8 = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: isSelected7 == false
                                    ? Colors.white
                                    : Colors.red,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isSelected7 == false
                                    ? Colors.white
                                    : Colors.red,
                              ),
                              height: windowHeight * 0.07,
                              child: Center(
                                child: Text(
                                  'Complaint',
                                  style: TextStyle(
                                    color: isSelected7 == false
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Body.category = 'Compliment';
                              isSelected8 = !isSelected8;
                              isSelected6 = false;
                              isSelected7 = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: isSelected8 == false
                                    ? Colors.white
                                    : Colors.green,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isSelected8 == false
                                    ? Colors.white
                                    : Colors.green,
                              ),
                              height: windowHeight * 0.07,
                              child: Center(
                                child: Text(
                                  'Compliment',
                                  style: TextStyle(
                                    color: isSelected8 == false
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.02,
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  height: windowHeight * 0.25,
                  child: TextField(
                    controller: contentController,
                    maxLines: 12,
                    decoration: InputDecoration(
                      hintText: isSelected7 == true
                          ? 'How can we improve your experience?'
                          : 'We are glad to help you out!',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: GestureDetector(
                      onTap: () async {
                        Body.content = contentController.text.toString();
                        await sendFeedbackApp();
                        if (Body.status == 'true') {
                          _showSnackBar(
                            Body.message,
                          );
                        } else {
                          _showSnackBar(
                              'Something went wrong, please try again later');
                        }
                      },
                      child: PrimaryButton(btnText: 'Submit your request')),
                ),
              ],
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
            textAlign: TextAlign.center,
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
