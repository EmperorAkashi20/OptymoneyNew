import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

import '../../Models.dart';

raiseTicket() async {
  var url = Uri.parse(
      '${urlWeb}ajax-request/ajax_response.php?action=ticketapp&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    'uid': LoginSignUp.globalUserId,
    'subject': Body.subject,
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
  print(responseBody);
  var parsedJson = jsonDecode(responseBody);
  Body.message = parsedJson['message'].toString();
  Body.status = parsedJson['status'].toString();
}

class Body extends StatefulWidget {
  static var subject;
  static var content;
  static var status;
  static var message;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController contentController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();

  Future<List<TicketData>> getTicketData() async {
    var url = Uri.parse(
        '${urlWeb}ajax-request/ajax_response.php?action=viewticketsapp&subaction=submit');
    final headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'uid': LoginSignUp.globalUserId,
    });
    //String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var schemeBody = response.body;
    var jsonData = json.decode(schemeBody);

    List<TicketData> ticketDatas = [];
    for (var sch in jsonData) {
      TicketData ticketData = TicketData(
        sch['ticket_id'].toString(),
        sch['ticket_uid'].toString(),
        sch['ticket_subject'].toString(),
        sch['ticket_content'].toString(),
        sch['ticket_date'].toString(),
        sch['ticket_attender'].toString(),
        sch['ticket_solution'].toString(),
        sch['ticket_res_date'].toString(),
      );
      if (sch['pk_nav_id'] != null) {}

      //print(Body.encoded);
      ticketDatas.add(ticketData);
      //print(getIndiScheme.encodedIsin);
    }

    return ticketDatas;
  }

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
                'Support Ticket',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              CloseButton(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.pen, size: 20),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            context: context,
            builder: (context) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'We are here to help',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CloseButton(),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(12),
                          height: windowHeight * 0.08,
                          child: TextField(
                            controller: subjectController,
                            maxLength: 100,
                            maxLines: 12,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintText: 'Subject',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(12),
                          height: windowHeight * 0.25,
                          child: TextField(
                            controller: contentController,
                            maxLength: 500,
                            maxLines: 12,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintText: 'How can we help you?',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: windowHeight * 0.03,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Body.subject = subjectController.text.toString();
                            Body.content = contentController.text.toString();
                            if (Body.subject.isEmpty && Body.content.isEmpty) {
                              _showSnackBar('Please enter details');
                            } else if (Body.subject.isEmpty ||
                                Body.content.isEmpty) {
                              _showSnackBar('Fileds cannot be empty');
                            } else {
                              await raiseTicket();
                              subjectController.clear();
                              contentController.clear();
                              Navigator.pop(context);
                              if (Body.status == 'true') {
                                _showSnackBar(Body.message);
                                setState(() {
                                  getTicketData();
                                });
                              } else {
                                _showSnackBar(
                                    'Something went wrong, please try again later.');
                              }
                            }
                          },
                          child: PrimaryButton(
                            btnText: 'Submit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: FutureBuilder(
            future: getTicketData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingDoubleFlipping.circle(
                          borderColor: Color(0xFF5B16D0),
                          borderSize: 2.0,
                          size: 40.0,
                          backgroundColor: Color(0xFF5B16D0),
                        ),
                        Text(
                          "We are fetching the data. \nPlease wait...",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'You do not have any active tickets',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)),
                            ),
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  title: Text(
                                    snapshot.data[index].ticket_subject,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: [
                                    CloseButton(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                body: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: windowHeight * 0.02,
                                        ),
                                        Text(
                                          'Problem faced by you:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.01,
                                        ),
                                        Text(
                                          snapshot.data[index].ticket_content,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.04,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Issue Attended By:',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index]
                                                          .ticket_attender ==
                                                      'null'
                                                  ? 'Pending'
                                                  : snapshot.data[index]
                                                      .ticket_attender,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Issue resolution date:',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index]
                                                          .ticket_res_date ==
                                                      'null'
                                                  ? 'Pending'
                                                  : snapshot.data[index]
                                                      .ticket_res_date,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.04,
                                        ),
                                        Text(
                                          'Resolution:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.01,
                                        ),
                                        Text(
                                          snapshot.data[index]
                                                      .ticket_solution ==
                                                  'null'
                                              ? 'Your issue will soon be resolved. Please be patient.'
                                              : snapshot
                                                  .data[index].ticket_solution,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: windowHeight * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        snapshot.data[index].ticket_subject,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        snapshot.data[index].ticket_date,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: windowHeight * 0.01),
                                Text(
                                  snapshot.data[index].ticket_content,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
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

class TicketData {
  // ignore: non_constant_identifier_names
  var ticket_id;
  // ignore: non_constant_identifier_names
  var ticket_uid;
  // ignore: non_constant_identifier_names
  var ticket_subject;
  // ignore: non_constant_identifier_names
  var ticket_content;
  // ignore: non_constant_identifier_names
  var ticket_date;
  // ignore: non_constant_identifier_names
  var ticket_attender;
  // ignore: non_constant_identifier_names
  var ticket_solution;
  // ignore: non_constant_identifier_names
  var ticket_res_date;

  TicketData(
    this.ticket_id,
    this.ticket_uid,
    this.ticket_subject,
    this.ticket_content,
    this.ticket_date,
    this.ticket_attender,
    this.ticket_solution,
    this.ticket_res_date,
  );
}
