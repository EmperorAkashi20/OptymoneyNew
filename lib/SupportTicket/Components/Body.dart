import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

import '../../Models.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController contentController = new TextEditingController();
  TextEditingController subjectCOntroller = new TextEditingController();

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
    double windowWidth = MediaQuery.of(context).size.width;
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
      body: Container(
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
              return Center(
                child: Text(
                  'You do not have any active tickets',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        snapshot.data[index].ticket_id +
                                            '.' +
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
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    actions: [
                                      CloseButton(
                                        color: Colors.black,
                                      ),
                                    ],
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      'Please tell us your concern',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  body: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            margin: EdgeInsets.all(12),
                                            height: windowHeight * 0.08,
                                            child: TextField(
                                              controller: contentController,
                                              maxLines: 12,
                                              decoration: InputDecoration(
                                                hintText: 'Subject',
                                                //fillColor: Colors.grey[200],
                                                filled: true,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            margin: EdgeInsets.all(12),
                                            height: windowHeight * 0.25,
                                            child: TextField(
                                              controller: contentController,
                                              maxLines: 12,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'How can we help you?',
                                                //fillColor: Colors.grey[200],
                                                filled: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: windowHeight * 0.03,
                                          ),
                                          PrimaryButton(btnText: 'Submit'),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
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
