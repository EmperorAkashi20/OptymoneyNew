import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/BestPerformingFunds/Components/Body.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

addToCartRequest() async {
  print(Body.encodedIndex);
  print(SingleProductDetailsPage.sipAmount);
  print(SingleProductDetailsPage.date);
  print(Body.idIndex);
  var url = Uri.parse(
      'https://optymoney.com/__lib.ajax/mutual_fund.php?action=add_cart_api&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var body = jsonEncode({
    "sch_code": Body.encodedIndex,
    "f_sip_amount": SingleProductDetailsPage.sipAmount,
    "sip_date": SingleProductDetailsPage.date,
    "sch_d": Body.idIndex,
    "uid": 2052,
  });
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  print(response.body);
  var responseBody = response.body;
  var decodedBody = jsonDecode(responseBody);
  SingleProductDetailsPage.message = decodedBody['msg'].toString();
  SingleProductDetailsPage.status = decodedBody['status'].toString();
}

addToCartRequestOneTime() async {
  var url = Uri.parse(
      'https://optymoney.com/__lib.ajax/mutual_fund.php?action=add_cart_api&subaction=submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var body = jsonEncode({
    "sch_code": Body.encodedIndex,
    "f_sip_amount": '',
    "sip_date": '0',
    "sch_d": Body.idIndex,
    "f_lum_amount": SingleProductDetailsPage.lumpSumAmount,
    "uid": '2052',
  });
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  print(response.body);
  var responseBody = response.body;
  var decodedBody = jsonDecode(responseBody);
  SingleProductDetailsPage.message = decodedBody['msg'].toString();
  SingleProductDetailsPage.status = decodedBody['status'].toString();
}

class SingleProductDetailsPage extends StatefulWidget {
  static var ignoreButton = false;
  static var date;
  static var sipAmount;
  static bool isSelected = false;
  static var message;
  static var status;
  static var lumpSumAmount;
  static String routeName = '/SingleProductPage';
  const SingleProductDetailsPage({Key? key}) : super(key: key);

  @override
  _SingleProductDetailsPageState createState() =>
      _SingleProductDetailsPageState();
}

class _SingleProductDetailsPageState extends State<SingleProductDetailsPage> {
  double miniamt = Body.minAmt;
  var selectedDate;
  Future<List<ChartData>> _getChartData() async {
    var url = Uri.parse('https://optymoney.com/__lib.ajax/ajax_response.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'get_nav': 'yes',
      'sch_code': Body.encodedIsinForGraph,
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
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    Body.schemeName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
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
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: windowHeight * 0.3,
                            child: Placeholder(),
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
                                color: Colors.blue.shade900,
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
                                      Body.return1,
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
                                      Body.return3,
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
                                      Body.return5,
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
                                color: Colors.blue.shade900,
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
                                      Body.isin,
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
                                      Body.schemeCode,
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
                                      Body.schemeType,
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
                                      'Scheme Plan',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      Body.schemePlan,
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
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            Text('Select and Add to Cart',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22)),
                            DefaultTabController(
                              length: 2, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: TabBar(
                                      labelColor: Colors.green,
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        Tab(text: 'SIP'),
                                        Tab(text: 'One Time'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: windowHeight *
                                        0.6, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Use the slider to adjust the installment amount',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SfSlider(
                                                    enableTooltip: true,
                                                    interval: 100,
                                                    stepSize: 100,
                                                    thumbIcon: Icon(
                                                      Icons
                                                          .compare_arrows_rounded,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    thumbShape: SfThumbShape(),
                                                    tooltipShape:
                                                        SfPaddleTooltipShape(),
                                                    activeColor:
                                                        Color(0xFF5B16D0),
                                                    min: Body.minAmt,
                                                    max: Body.maxAmt,
                                                    value: miniamt.toDouble(),
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        miniamt = value;
                                                      });
                                                    },
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Container(
                                                      width: windowWidth,
                                                      height:
                                                          windowHeight * 0.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: Text(miniamt
                                                            .toStringAsFixed(
                                                                2)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹1000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        1000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹3000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        3000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹5000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        5000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'SIP Date',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: windowHeight * 0.1,
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '1st',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 1;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '2nd',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 2;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '3rd',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 3;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '4th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 4;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '5th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 5;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '6th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 6;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '7th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 7;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '8th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 8;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '9th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 9;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '10th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 10;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '11th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 11;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '12th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 12;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '13th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 13;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '14th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 14;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '15th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 15;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '16th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 16;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '17th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 17;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '18th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 18;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '19th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 19;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '20th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 20;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '21st',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 21;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '22nd',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 22;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '23rd',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 23;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '24th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 24;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '25th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 25;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '26th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 26;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '27th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 27;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '28th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 28;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '29th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 29;
                                                            });
                                                          },
                                                        ),
                                                        DateCard(
                                                          windowWidth:
                                                              windowWidth,
                                                          windowHeight:
                                                              windowHeight,
                                                          date: '30th',
                                                          press: () {
                                                            setState(() {
                                                              selectedDate = 30;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Container(
                                                      width: windowWidth,
                                                      height:
                                                          windowHeight * 0.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: selectedDate ==
                                                                null
                                                            ? Text(
                                                                'Select A Date from above')
                                                            : Text(selectedDate
                                                                    .toString() +
                                                                " of every month"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1.0),
                                                    child: ConfirmationSlider(
                                                      foregroundColor: Colors
                                                          .green
                                                          .withOpacity(0.7),
                                                      textStyle: TextStyle(
                                                          fontSize: 22),
                                                      text: 'Add to cart',
                                                      width: windowWidth,
                                                      onConfirmation: () async {
                                                        SingleProductDetailsPage
                                                                .sipAmount =
                                                            miniamt;
                                                        SingleProductDetailsPage
                                                                .date =
                                                            selectedDate;

                                                        await addToCartRequest();
                                                        _showSnackBar(
                                                            SingleProductDetailsPage
                                                                    .status
                                                                    .toString()
                                                                    .toUpperCase() +
                                                                ' : ' +
                                                                SingleProductDetailsPage
                                                                    .message);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Use the slider to adjust the installment amount',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SfSlider(
                                                    enableTooltip: true,
                                                    thumbShape: SfThumbShape(),
                                                    tooltipShape:
                                                        SfPaddleTooltipShape(),
                                                    interval: 100,
                                                    stepSize: 100,
                                                    thumbIcon: Icon(
                                                      Icons
                                                          .compare_arrows_rounded,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    activeColor:
                                                        Color(0xFF5B16D0),
                                                    min: Body.lumpSumMin,
                                                    max: Body.lumpSumMax,
                                                    value: miniamt.toDouble(),
                                                    onChanged: (dynamic value) {
                                                      setState(() {
                                                        miniamt = value;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: windowHeight * 0.05,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Container(
                                                      width: windowWidth,
                                                      height:
                                                          windowHeight * 0.06,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: Text(miniamt
                                                            .toStringAsFixed(
                                                                2)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹1000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        1000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹3000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        3000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              IncrementButton(
                                                            windowHeight:
                                                                windowHeight,
                                                            amount: '+ ₹5000',
                                                            press: () {
                                                              setState(() {
                                                                miniamt = (miniamt +
                                                                        5000)
                                                                    .toDouble();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        windowHeight * 0.199,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1.0),
                                                    child: ConfirmationSlider(
                                                      foregroundColor: Colors
                                                          .green
                                                          .withOpacity(0.7),
                                                      textStyle: TextStyle(
                                                          fontSize: 22),
                                                      text: 'Add to cart',
                                                      width: windowWidth,
                                                      onConfirmation: () async {
                                                        SingleProductDetailsPage
                                                                .lumpSumAmount =
                                                            miniamt;

                                                        await addToCartRequestOneTime();
                                                        _showSnackBar(
                                                            SingleProductDetailsPage
                                                                    .status
                                                                    .toString()
                                                                    .toUpperCase() +
                                                                ' : ' +
                                                                SingleProductDetailsPage
                                                                    .message);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
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
}

class DateCard extends StatelessWidget {
  const DateCard({
    Key? key,
    required this.windowWidth,
    required this.windowHeight,
    required this.date,
    required this.press,
  }) : super(key: key);

  final double windowWidth;
  final double windowHeight;
  final String date;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function(),
      child: Card(
        color: SingleProductDetailsPage.isSelected == false
            ? Colors.white
            : Colors.lightBlueAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: windowWidth * 0.25,
          height: windowHeight * 0.06,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date + ' Of'),
                Text('Every Month'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({
    Key? key,
    required this.windowHeight,
    required this.press,
    required this.amount,
  }) : super(key: key);

  final double windowHeight;
  final Function press;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function(),
      child: Container(
        height: windowHeight * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFF5B16D0),
          ),
        ),
        child: Center(
          child: Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.date, this.amount);
  final String date;
  final String amount;
}
