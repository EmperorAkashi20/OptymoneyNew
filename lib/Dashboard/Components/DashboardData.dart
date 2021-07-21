import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:optymoney/Dashboard/Components/DetailsPage.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

class DashboardData extends StatefulWidget {
  static var purPrice;
  static var presentVal;
  static var navPrice;
  static var presentValIndi;
  static var profitLoss;
  static var folioNo;
  static var schemeName;
  static var encodedIsin;
  static var encodedIsinForGraph;
  static var units;
  static var currentValue;
  static var isin;
  static var schemeCode;
  static var schemeType;
  static var nav;
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
      String isinFromData = sch['isin'];
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      DashboardData.encodedIsin = stringToBase64.encode(isinFromData);
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
        a.toDouble().round(),
        DashboardData.encodedIsin,
      );
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
      //backgroundColor: Color(0XFFE3D3FF).withOpacity(0.5),
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
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  color: Color(0xFF3594DD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: windowWidth * 0.28,
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
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
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
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  color: Color(0xFF3594DD),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: windowWidth * 0.25,
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
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
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
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  color: DashboardData.presentVal >
                                          DashboardData.purPrice
                                      ? Colors.green
                                      : Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: windowWidth * 0.25,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Profit/Loss',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
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
                                                  size: 14,
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
                                            height: 5,
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
                              ),
                            ],
                          ),
                          // Expanded(
                          //   child: Divider(
                          //     thickness: 2,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Card(
                      // color: Color(0XFFF2EBFF).withOpacity(0.5),
                      elevation: 0,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                DashboardData.schemeCode =
                                    snapshot.data[index].bse_scheme_code;
                                DashboardData.isin = snapshot.data[index].isin;
                                DashboardData.schemeType =
                                    snapshot.data[index].scheme_type;
                                DashboardData.nav =
                                    snapshot.data[index].nav_price.toString();
                                DashboardData.units =
                                    snapshot.data[index].all_units;
                                DashboardData.currentValue =
                                    snapshot.data[index].presentVal;
                                DashboardData.encodedIsinForGraph =
                                    snapshot.data[index].encodedIsin;
                                DashboardData.folioNo =
                                    snapshot.data[index].folio;
                                DashboardData.schemeName = snapshot
                                    .data[index].fr_scheme_name
                                    .toString();
                                Navigator.pushNamed(
                                    context, DetailsPage.routeName);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Card(
                                  elevation: 1,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].fr_scheme_name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Folio ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index].folio,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data[index].all_units
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text('All Units'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data[index].sch_amount
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text('Purchase Price'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (snapshot.data[index]
                                                              .sch_amount <
                                                          snapshot.data[index]
                                                              .presentVal)
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .sortUp,
                                                          color: Colors.green,
                                                          size: 18,
                                                        ),
                                                      if (snapshot.data[index]
                                                              .sch_amount >
                                                          snapshot.data[index]
                                                              .presentVal)
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .sortDown,
                                                          color: Colors.red,
                                                          size: 18,
                                                        ),
                                                      Text(
                                                        snapshot.data[index]
                                                            .presentVal
                                                            .toStringAsFixed(2),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: snapshot
                                                                        .data[
                                                                            index]
                                                                        .sch_amount <
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .presentVal
                                                                ? Colors.green
                                                                    .shade700
                                                                : Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  Text('Current Value'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
  var encodedIsin;

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
    this.encodedIsin,
  );
}
