import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

import '../../Models.dart';

class MutualFundOrdersTab extends StatefulWidget {
  const MutualFundOrdersTab({Key? key}) : super(key: key);

  @override
  _MutualFundOrdersTabState createState() => _MutualFundOrdersTabState();
}

class _MutualFundOrdersTabState extends State<MutualFundOrdersTab> {
  Future<List<MfOrders>> getMfOrders() async {
    var url = Uri.parse(
        '${urlWeb}ajax-request/ajax_response.php?action=fetchordersapp&subaction=submit');
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

    List<MfOrders> mfOrderss = [];
    for (var sch in jsonData) {
      MfOrders mfOrders = MfOrders(
        sch['scheme_name'].toString(),
        sch['amnt'].toString(),
        sch['p_method'].toString(),
        sch['date_sip'].toString(),
        sch['mf_cart_id'].toString(),
        sch['cart_timestamp'].toString(),
      );
      if (sch['pk_nav_id'] != null) {}

      //print(Body.encoded);
      mfOrderss.add(mfOrders);
      //print(getIndiScheme.encodedIsin);
    }

    return mfOrderss;
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getMfOrders(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data[index].scheme_name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: windowHeight * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Investment Type:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                snapshot.data[index].date_sip == '0'
                                    ? Text(
                                        'Lump Sum',
                                      )
                                    : Text('SIP'),
                              ],
                            ),
                            if (snapshot.data[index].date_sip != '0')
                              SizedBox(height: windowHeight * 0.005),
                            if (snapshot.data[index].date_sip != '0')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SIP Date:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data[index].date_sip)
                                ],
                              ),
                            SizedBox(height: windowHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data[index].amnt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: windowHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(snapshot.data[index].cart_timestamp),
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

class MfOrders {
  // ignore: non_constant_identifier_names
  var scheme_name;
  // ignore: non_constant_identifier_names
  var amnt;
  // ignore: non_constant_identifier_names
  var p_method;
  // ignore: non_constant_identifier_names
  var date_sip;
  // ignore: non_constant_identifier_names
  var mf_cart_id;
  // ignore: non_constant_identifier_names
  var cart_timestamp;

  MfOrders(
    this.scheme_name,
    this.amnt,
    this.p_method,
    this.date_sip,
    this.mf_cart_id,
    this.cart_timestamp,
  );
}
