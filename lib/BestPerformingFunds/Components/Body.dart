import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/BestPerformingFunds/Components/DetailsPage.dart';

class Body extends StatefulWidget {
  static var offerId = 32;
  static var encoded;
  static var netAsset;
  static var priceDate;
  static var priceList;
  static var dateList;
  static var i;
  static var id;
  static var minAmt;
  static var maxAmt;
  static var values;
  static var lumpSumMin;
  static var lumpSumMax;
  static var encodedIndex;
  static var idIndex;
  static var schemeName;
  static var encodedIsinForGraph;
  static var return1;
  static var return3;
  static var return5;
  static var isin;
  static var schemeCode;
  static var schemeType;
  static var schemePlan;

  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _options = [
    'Best Performing Mutual Funds',
    'Best Equity Mutual Funds',
    'Best Liquid Funds',
    'Top SIP Funds',
    'Best ELSS Funds',
    'Best Large Cap Funds',
    'Explore Funds',
    'Best Mid Cap Funds',
    'New To Mutual Funds'
  ];
  String _currentItemSelected = 'Best Performing Mutual Funds';

  Future<List<GetIndiScheme>> getScheme() async {
    var url = Uri.parse('https://optymoney.com/__lib.ajax/ajax_response.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'filter_offer_search_app': 'yes',
      'offer_id': Body.offerId.toString(),
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var schemeBody = response.body;
    var jsonData = json.decode(schemeBody);

    List<GetIndiScheme> getIndiSchemes = [];
    for (var sch in jsonData) {
      var a = (sch['nav_price']);
      var nav1 = a['1'];
      var nav2 = a['3'];
      var nav3 = a['5'];
      String credentials = sch['isin'];
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      Body.encoded =
          stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=

      GetIndiScheme getIndiScheme = GetIndiScheme(
        sch['pk_nav_id'],
        sch['scheme_code'],
        sch['unique_no'],
        sch['rta_scheme_code'],
        sch['amc_scheme_code'],
        sch['isin'],
        sch['scheme_type'],
        sch['scheme_plan'],
        sch['scheme_name'],
        nav1.toString(),
        nav2.toString(),
        nav3.toString(),
        Body.encoded,
        //makeGraph(Body.encoded.toString()),
      );
      if (sch['pk_nav_id'] != null) {}

      //print(Body.encoded);
      getIndiSchemes.add(getIndiScheme);
      //print(getIndiScheme.encodedIsin);
    }

    return getIndiSchemes;
  }

  makeSipRequest(pknavid) async {
    var url = Uri.parse('https://optymoney.com/__lib.ajax/ajax_response.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'fetch_sch': pknavid,
      'get_scheme_data': 'yes',
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    var dataBody = response.body;
    var jsonData = json.decode(dataBody);
    Body.minAmt =
        double.tryParse(jsonData[0]['sip_minimum_installment_amount']);
    Body.maxAmt =
        double.tryParse(jsonData[0]['sip_maximum_installment_amount']);
    Body.id = jsonData[0]['pk_nav_id'];

    Body.lumpSumMin = double.tryParse(jsonData[0]['minimum_purchase_amount']);
    Body.lumpSumMax = double.tryParse(jsonData[0]['maximum_purchase_amount']);
    if (Body.lumpSumMin == Body.lumpSumMax) {
      Body.lumpSumMin = 0.0;
      Body.lumpSumMax = 99999999.0;
    } else if (Body.lumpSumMin > Body.lumpSumMax) {
      Body.lumpSumMin = Body.lumpSumMin;
      Body.lumpSumMax = Body.lumpSumMin * 200;
    }
    if (Body.minAmt == Body.maxAmt) {
      Body.minAmt = 0.0;
      Body.maxAmt = 99999999.0;
    }
    Body.values = Body.minAmt;
  }

  @override
  void initState() {
    super.initState();
    Body.offerId = 32;
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlueAccent,
              ),
              width: windowWidth * 0.7,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(Icons.arrow_circle_down_rounded),
                  dropdownColor:
                      Colors.lightBlueAccent.shade200.withOpacity(0.9),
                  isExpanded: true,
                  iconSize: 35,
                  //isDense: true,
                  menuMaxHeight: windowHeight * 0.3,
                  iconDisabledColor: Colors.blueGrey,
                  items: _options.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValueSelected) {
                    _dropDownItemSelected(newValueSelected);
                    if (_currentItemSelected ==
                        'Best Performing Mutual Funds') {
                      Body.offerId = 32;
                    } else if (_currentItemSelected ==
                        'Best Equity Mutual Funds') {
                      Body.offerId = 33;
                    } else if (_currentItemSelected == 'Best Liquid Funds') {
                      Body.offerId = 34;
                    } else if (_currentItemSelected == 'Top SIP Funds') {
                      Body.offerId = 35;
                    } else if (_currentItemSelected == 'Best ELSS Funds') {
                      Body.offerId = 36;
                    } else if (_currentItemSelected == 'Best Large Cap Funds') {
                      Body.offerId = 37;
                    } else if (_currentItemSelected == 'Explore Funds') {
                      Body.offerId = 38;
                    } else if (_currentItemSelected == 'Best Mid Cap Funds') {
                      Body.offerId = 39;
                    } else if (_currentItemSelected == 'New To Mutual Funds') {
                      Body.offerId = 40;
                    }
                  },
                  value: _currentItemSelected,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder(
            future: getScheme(),
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
                          "We are fetching the best schemes for you...\nHOLD TIGHT!!",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () async {
                          Body.schemePlan = snapshot.data[index].scheme_plan;
                          Body.isin = snapshot.data[index].isin;
                          Body.schemeCode = snapshot.data[index].scheme_code;
                          Body.schemeType = snapshot.data[index].scheme_type;
                          Body.return1 = snapshot.data[index].nav_price1;
                          Body.return3 = snapshot.data[index].nav_price2;
                          Body.return5 = snapshot.data[index].nav_price3;
                          Body.encodedIsinForGraph =
                              snapshot.data[index].encodedIsin;
                          Body.schemeName = snapshot.data[index].scheme_name;
                          Body.idIndex = snapshot.data[index].pk_nav_id;
                          Body.encodedIndex = snapshot.data[index].encodedIsin;
                          await makeSipRequest(snapshot.data[index].pk_nav_id);
                          Navigator.pushNamed(
                              context, SingleProductDetailsPage.routeName);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].scheme_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: windowWidth * 0.34,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data[index].scheme_type,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("1 Year"),
                                            Text(
                                              snapshot.data[index].nav_price1 +
                                                  "%",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("3 Years"),
                                            Text(
                                              snapshot.data[index].nav_price2 +
                                                  "%",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("5 Years"),
                                            Text(
                                              snapshot.data[index].nav_price3 +
                                                  "%",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

  void _dropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected.toString();
    });
  }
}

class CreateDataList {
  var price;
  var date;

  CreateDataList(this.price, this.date);
}

class GetIndiScheme {
  // ignore: non_constant_identifier_names
  final String pk_nav_id;
  // ignore: non_constant_identifier_names
  final String unique_no;
  // ignore: non_constant_identifier_names
  final String scheme_code;
  // ignore: non_constant_identifier_names
  final String rta_scheme_code;
  // ignore: non_constant_identifier_names
  final String amc_scheme_code;
  // ignore: non_constant_identifier_names
  final String isin;
  // ignore: non_constant_identifier_names
  final String scheme_type;
  // ignore: non_constant_identifier_names
  final String scheme_plan;
  // ignore: non_constant_identifier_names
  final String scheme_name;
  // ignore: non_constant_identifier_names
  final String nav_price1;
  // ignore: non_constant_identifier_names
  final String nav_price2;
  // ignore: non_constant_identifier_names
  final String nav_price3;
  final String encodedIsin;
  //Future makeGraph;

  GetIndiScheme(
    this.pk_nav_id,
    this.scheme_code,
    this.unique_no,
    this.rta_scheme_code,
    this.amc_scheme_code,
    this.isin,
    this.scheme_type,
    this.scheme_plan,
    this.scheme_name,
    this.nav_price1,
    this.nav_price2,
    this.nav_price3,
    this.encodedIsin,
    //this.makeGraph,
  );
}
