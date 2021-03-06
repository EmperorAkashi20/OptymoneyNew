import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/Dashboard/Components/BuyingSchemes.dart';
import 'package:optymoney/Dashboard/Components/DashboardData.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

makeRedeemRequest() async {
  var url = Uri.parse(
      'https://optymoney.com/__lib.ajax/mutual_fund.php?action=p_to_redeem_api&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    "status": 2,
    "uid": LoginSignUp.globalUserId,
    "redeem_amt": DetailsPage.amount,
    "redeem_folio": DashboardData.folioNo,
    "redeem_scheme_id": DashboardData.schemeCode,
    "redeem_order_id": "",
    "redeem_all_amount": "",
    "exampleradios": "option1",
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
  var jsonData = responseBody;

  var parsedJson = json.decode(jsonData);
  print(parsedJson);
  DetailsPage.orderId = parsedJson['order_id'];
  DetailsPage.status = parsedJson['status'];
}

class DetailsPage extends StatefulWidget {
  static String routeName = '/DetailsPage';
  static var amount;
  static var orderId;
  static var status;
  const DetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController amountController = new TextEditingController(
    text: DashboardData.currentValue.toString(),
  );
  Future<List<ChartData>> _getChartData() async {
    var url = Uri.parse('https://optymoney.com/__lib.ajax/ajax_response.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'get_nav': 'yes',
      'sch_code': DashboardData.encodedIsinForGraph,
    };
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    var responseBody = response.body;
    var jsonData = json.decode(responseBody);
    List<ChartData> chartsData = [];
    for (var sch in jsonData) {
      ChartData chartData = ChartData(
        sch['price_date'],
        sch['net_asset_value'],
      );
      chartsData.add(chartData);
    }
    return chartsData;
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
        flexibleSpace: Container(
          height: 110,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    DashboardData.schemeName,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CloseButton(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
              future: _getChartData(),
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
                      child: Text('Implement'),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   width: double.infinity,
                            //   height: windowHeight * 0.3,
                            //   child: Placeholder(),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Current Holdings',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "???" +
                                                  DashboardData.currentValue
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              DashboardData.units.toString() +
                                                  ' Units',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              child: Text(
                                'Returns',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '1 Year',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '5.8%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '3 Years',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '18.3%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '5 Years',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '25.1%',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              child: Text(
                                'Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ISIN',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        DashboardData.isin,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Scheme Code',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        DashboardData.schemeCode,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Scheme Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        DashboardData.schemeType,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Net Asset Value (NAV)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        DashboardData.nav,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 10000),
                                        curve: Curves.easeIn,
                                        height: windowHeight * 0.2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(context,
                                                      BuyingSchemes.routeName);
                                                },
                                                child: Row(
                                                  children: [
                                                    FaIcon(FontAwesomeIcons
                                                        .syncAlt),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Buy More',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'You will be taken to the scheme page',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      30.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30.0)),
                                                    ),
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Container(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      22.0,
                                                                  vertical: 18),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InputWithIcon(
                                                                icon: Icons
                                                                    .wrap_text,
                                                                hint: 'Enter amount to redeem ???' +
                                                                    DashboardData
                                                                        .currentValue
                                                                        .toString() +
                                                                    '(MAX)',
                                                                obscureText:
                                                                    false,
                                                                dataController:
                                                                    amountController,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    windowHeight *
                                                                        0.03,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  DetailsPage
                                                                          .amount =
                                                                      amountController
                                                                          .text
                                                                          .toString();
                                                                  await makeRedeemRequest();
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(() {
                                                                    _showSnackBar(DetailsPage
                                                                            .status
                                                                            .toString() +
                                                                        ' : ' +
                                                                        DetailsPage
                                                                            .orderId
                                                                            .toString());
                                                                  });
                                                                },
                                                                child: PrimaryButton(
                                                                    btnText:
                                                                        'Redeem'),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    FaIcon(FontAwesomeIcons
                                                        .exchangeAlt),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Redeem',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'The max redeemable amount is ???' +
                                                              DashboardData
                                                                  .currentValue
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: OutlineBtn(
                                  btnText: 'Transact',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
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

class ChartData {
  ChartData(this.date, this.amount);
  final String date;
  final String amount;
}
