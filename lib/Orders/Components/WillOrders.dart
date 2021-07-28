import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

import '../../Models.dart';

class WillOrdersTab extends StatefulWidget {
  const WillOrdersTab({Key? key}) : super(key: key);

  @override
  _WillOrdersTabState createState() => _WillOrdersTabState();
}

class _WillOrdersTabState extends State<WillOrdersTab> {
  Future<List<WillOrders>> getWillOrders() async {
    var url = Uri.parse(
        '${urlWeb}ajax-request/ajax_response.php?action=fetchwillordersapp&subaction=submit');
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

    var responseBody = response.body;
    var jsonData = json.decode(responseBody);

    List<WillOrders> willOrderss = [];
    for (var sch in jsonData) {
      WillOrders willOrders = WillOrders(
        sch['pk_user_settings_id'].toString(),
        sch['fr_user_id'].toString(),
        sch['paid_amount'].toString(),
        sch['pending_amount'].toString(),
        sch['pay_status'].toString(),
        sch['pay_for'].toString(),
        sch['txn_id'].toString(),
        sch['narration'].toString(),
        sch['setting_modified_date'].toString(),
        sch['setting_create_date'].toString(),
        sch['response_msg'].toString(),
        sch['url_link'].toString(),
      );
      if (sch['pk_nav_id'] != null) {}

      //print(Body.encoded);
      willOrderss.add(willOrders);
      //print(getIndiScheme.encodedIsin);
    }

    return willOrderss;
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    // double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getWillOrders(),
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
                  'You have no open orders',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data[index].txn_id,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹' + snapshot.data[index].paid_amount,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: windowHeight * 0.005),
                                Text(
                                  snapshot.data[index].setting_create_date,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: windowHeight * 0.005),
                                Text(
                                  snapshot.data[index].response_msg,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: snapshot.data[index].response_msg ==
                                            'Transaction successful'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}

class WillOrders {
  // ignore: non_constant_identifier_names
  var pk_user_settings_id;
  // ignore: non_constant_identifier_names
  var fr_user_id;
  // ignore: non_constant_identifier_names
  var paid_amount;
  // ignore: non_constant_identifier_names
  var pending_amount;
  // ignore: non_constant_identifier_names
  var pay_status;
  // ignore: non_constant_identifier_names
  var pay_for;
  // ignore: non_constant_identifier_names
  var txn_id;
  var narration;
  // ignore: non_constant_identifier_names
  var setting_modified_date;
  // ignore: non_constant_identifier_names
  var setting_create_date;
  // ignore: non_constant_identifier_names
  var response_msg;
  // ignore: non_constant_identifier_names
  var url_link;

  WillOrders(
    this.pk_user_settings_id,
    this.fr_user_id,
    this.paid_amount,
    this.pending_amount,
    this.pay_status,
    this.pay_for,
    this.txn_id,
    this.narration,
    this.setting_modified_date,
    this.setting_create_date,
    this.response_msg,
    this.url_link,
  );
}
