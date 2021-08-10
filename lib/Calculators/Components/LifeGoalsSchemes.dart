import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Calculators/Components/Body.dart';

import '../../Models.dart';
import 'LifeGoalsDetailsPage.dart';

class LifeGoalsSchemes extends StatefulWidget {
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
  static String routeName = '/LifeGoalsSchemes';
  const LifeGoalsSchemes({Key? key}) : super(key: key);

  @override
  _LifeGoalsSchemesState createState() => _LifeGoalsSchemesState();
}

class _LifeGoalsSchemesState extends State<LifeGoalsSchemes> {
  Future<List<GetIndiScheme>> getScheme() async {
    var url = Uri.parse(
        '${urlWeb}__lib.ajax/ajax_response.php?action=offer_select&subaction=submit');
    final headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'offer_id': Body.offerId,
    });
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var schemeBody = response.body;
    var jsonData = json.decode(schemeBody);

    //print(jsonData);

    List<GetIndiScheme> getIndiSchemes = [];
    for (var sch in jsonData) {
      var a = (sch['nav_price']);
      var nav1 = a['1'];
      var nav2 = a['3'];
      var nav3 = a['5'];
      String credentials = sch['isin'];
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      LifeGoalsSchemes.encoded =
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
        LifeGoalsSchemes.encoded,
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
    LifeGoalsSchemes.minAmt =
        double.tryParse(jsonData[0]['sip_minimum_installment_amount']);
    LifeGoalsSchemes.maxAmt =
        double.tryParse(jsonData[0]['sip_maximum_installment_amount']);
    LifeGoalsSchemes.id = jsonData[0]['pk_nav_id'];

    LifeGoalsSchemes.lumpSumMin =
        double.tryParse(jsonData[0]['minimum_purchase_amount']);
    LifeGoalsSchemes.lumpSumMax =
        double.tryParse(jsonData[0]['maximum_purchase_amount']);
    if (LifeGoalsSchemes.lumpSumMin == LifeGoalsSchemes.lumpSumMax) {
      LifeGoalsSchemes.lumpSumMin = 0.0;
      LifeGoalsSchemes.lumpSumMax = 99999999.0;
    } else if (LifeGoalsSchemes.lumpSumMin > LifeGoalsSchemes.lumpSumMax) {
      LifeGoalsSchemes.lumpSumMin = LifeGoalsSchemes.lumpSumMin;
      LifeGoalsSchemes.lumpSumMax = LifeGoalsSchemes.lumpSumMin * 200;
    }
    if (LifeGoalsSchemes.minAmt == LifeGoalsSchemes.maxAmt) {
      LifeGoalsSchemes.minAmt = 0.0;
      LifeGoalsSchemes.maxAmt = 99999999.0;
    }
    LifeGoalsSchemes.values = LifeGoalsSchemes.minAmt;
  }

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;
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
                'Meet your life goals',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
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
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () async {
                            LifeGoalsSchemes.schemePlan =
                                snapshot.data[index].scheme_plan;
                            LifeGoalsSchemes.isin = snapshot.data[index].isin;
                            LifeGoalsSchemes.schemeCode =
                                snapshot.data[index].scheme_code;
                            LifeGoalsSchemes.schemeType =
                                snapshot.data[index].scheme_type;
                            LifeGoalsSchemes.return1 =
                                snapshot.data[index].nav_price1;
                            LifeGoalsSchemes.return3 =
                                snapshot.data[index].nav_price2;
                            LifeGoalsSchemes.return5 =
                                snapshot.data[index].nav_price3;
                            LifeGoalsSchemes.encodedIsinForGraph =
                                snapshot.data[index].encodedIsin;
                            LifeGoalsSchemes.schemeName =
                                snapshot.data[index].scheme_name;
                            LifeGoalsSchemes.idIndex =
                                snapshot.data[index].pk_nav_id;
                            LifeGoalsSchemes.encodedIndex =
                                snapshot.data[index].encodedIsin;
                            await makeSipRequest(
                                snapshot.data[index].pk_nav_id);
                            Navigator.pushNamed(
                                context, SingleProductDetailsPage1.routeName);
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
                                        color: Colors.blue.shade700,
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
                                                snapshot.data[index]
                                                        .nav_price1 +
                                                    "%",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("3 Years"),
                                              Text(
                                                snapshot.data[index]
                                                        .nav_price2 +
                                                    "%",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("5 Years"),
                                              Text(
                                                snapshot.data[index]
                                                        .nav_price3 +
                                                    "%",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
