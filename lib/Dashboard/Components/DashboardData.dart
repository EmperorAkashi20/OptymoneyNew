import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class DashboardData extends StatefulWidget {
  static var purPrice;
  static var presentVal;
  static var navPrice;
  static var presentValIndi;
  static var profitLoss;
  const DashboardData({Key? key}) : super(key: key);

  @override
  _DashboardDataState createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  Timer? _timer;
  late double _progress;
  Future<List<Scheme>> _getScheme() async {
    var url = Uri.parse(
        'https://optymoney.com/ajax-request/ajax_response.php?action=fetchPortfolioApp&subaction=submit');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'uid': '2052',
      'pan': 'AXFPP0304C',
    };
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
    //var len = jsonData.length;
    //print(len);
    List<Scheme> schemes = [];
    DashboardData.purPrice = 0.0;
    DashboardData.presentVal = 0.0;
    for (var sch in jsonData) {
      var a = sch['nav_price'] * sch['all_units'];
      //  Scheme(this.isin, this.folio, this.bse_scheme_code, this.fr_scheme_name,
      // this.purchase_price, this.scheme_type, this.amount, this.all_units);

      Scheme scheme = Scheme(
          sch['isin'],
          sch['folio'],
          sch['bse_scheme_code'],
          sch['fr_scheme_name'],
          sch['purchase_price'],
          sch['nav_price'], // sch['nav_price'],
          sch['scheme_type'],
          sch['amount'].toDouble(),
          sch['all_units'].toDouble(),
          a.toDouble().round());
      // print(scheme.toString());
      //
      if (sch['all_units'] != 0) {
        // print(sch['amount']);
        // print(sch['all_units']);
        // print(sch['nav_price']);
      }

      //print(scheme.sch_amount);
      if (sch['all_units'].toDouble() == 0 || sch['all_units'].toDouble() < 0) {
        // sch++;
      } else {
        schemes.add(scheme);
        DashboardData.presentVal =
            DashboardData.presentVal + (sch['nav_price'] * sch['all_units']);
        DashboardData.purPrice =
            DashboardData.purPrice + sch['amount'].toDouble();
        DashboardData.navPrice = sch['nav_price'].toDouble();
        DashboardData.presentValIndi = sch['nav_price'] * sch['all_units'];
        //Body.purchasePrice = sch['purchase_price'].toDouble();
      }
    }
    //print(Body.presentVal);
    //initialText = Body.presentValIndi.toString();
    DashboardData.profitLoss =
        DashboardData.presentVal - DashboardData.purPrice;
    return schemes;
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
        toolbarHeight: 10,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getScheme(),
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
                        size: 40,
                        backgroundColor: Color(0xFF5B16D0),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text('Implement pan card logic'),
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 10,
                                color: Color(0xFF3594DD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: windowWidth * 0.45,
                                  height: windowHeight * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3594DD),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Investment',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "₹",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            NumberSlideAnimation(
                                              number: DashboardData.purPrice
                                                  .round()
                                                  .toString(),
                                              duration: Duration(seconds: 2),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                color: Color(0xFF3594DD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: windowWidth * 0.45,
                                  height: windowHeight * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3594DD),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Present Value',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "₹",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            NumberSlideAnimation(
                                              number: DashboardData.presentVal
                                                  .round()
                                                  .toString(),
                                              duration: Duration(seconds: 2),
                                              curve: Curves.bounceIn,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 10,
                            color: DashboardData.presentVal >
                                    DashboardData.purPrice
                                ? Colors.green
                                : Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: windowWidth * 0.45,
                              height: windowHeight * 0.08,
                              decoration: BoxDecoration(
                                color: DashboardData.presentVal >
                                        DashboardData.purPrice
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Profit/Loss',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        if (DashboardData.presentVal >
                                            DashboardData.purPrice)
                                          Icon(
                                            Icons.arrow_upward_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        if (DashboardData.presentVal <
                                            DashboardData.purPrice)
                                          Icon(
                                            Icons.arrow_downward_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₹",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        NumberSlideAnimation(
                                          number: DashboardData.profitLoss
                                              .round()
                                              .toString(),
                                          duration: Duration(seconds: 2),
                                          curve: Curves.bounceIn,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 3,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Text(snapshot
                                            .data[index].fr_scheme_name),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index].all_units
                                                    .toString() +
                                                " units"),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹ " +
                                                      snapshot.data[index]
                                                          .presentVal
                                                          .toString(),
                                                ),
                                                if ((snapshot.data[index]
                                                            .sch_amount)
                                                        .toDouble()
                                                        .round() <
                                                    (snapshot.data[index]
                                                            .presentVal)
                                                        .toDouble()
                                                        .round())
                                                  Icon(
                                                    Icons.arrow_upward_rounded,
                                                    size: 17,
                                                  ),
                                                if ((snapshot.data[index]
                                                            .sch_amount)
                                                        .toDouble()
                                                        .round() >
                                                    (snapshot.data[index]
                                                            .presentVal)
                                                        .toDouble()
                                                        .round())
                                                  Icon(
                                                    Icons.arrow_upward_rounded,
                                                    size: 17,
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class Scheme {
  final String isin;
  final String folio;
  // ignore: non_constant_identifier_names
  final String bse_scheme_code;
  // ignore: non_constant_identifier_names
  final String fr_scheme_name;
  // ignore: non_constant_identifier_names
  var purchase_price;
  // ignore: non_constant_identifier_names
  var nav_price;
  var presentVal;
  // ignore: non_constant_identifier_names
  final double sch_amount;
  // ignore: non_constant_identifier_names
  final double all_units;
  // ignore: non_constant_identifier_names
  final String scheme_type;

  Scheme(
    this.isin,
    this.folio, //redeem_folio
    this.bse_scheme_code, //redeem_scheme_id
    this.fr_scheme_name,
    this.purchase_price,
    this.nav_price,
    this.scheme_type,
    this.sch_amount,
    this.all_units,
    this.presentVal,
  );
}
