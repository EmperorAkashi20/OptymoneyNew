import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Investments/Components/AmcFilters.dart';
import 'package:optymoney/Investments/Components/CategoriesDisplay.dart';
import 'package:optymoney/Investments/Components/DetailsPage.dart';

class Body extends StatefulWidget {
  static var test;
  static var encoded;
  static var minAmt;
  static var maxAmt;
  static var values;
  static var lumpSumMin;
  static var lumpSumMax;
  static var id;
  static var netAsset;
  static var priceDate;
  static var priceList;
  static var dateList;
  static var i;
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
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<AllSchemeWithFilters>> getSchemeListRequest() async {
    print(AmcFilters.selecteCategorys);
    print(CategoriesDisplay.selectedCategories);
    var url = Uri.parse(
        'https://test.optymoney.com/__lib.ajax/ajax_response.php?action=filter_offer_search_app_test1');
    final headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "amc_code": AmcFilters.selecteCategorys,
      "schm_type": CategoriesDisplay.selectedCategories,
      "Offer_id": '',
    });

    Response response = await post(
      url,
      headers: headers,
      body: body,
    );
    var dataBody = response.body;
    var jsonData = json.decode(dataBody);
    //print(body);
    //print(jsonData);
    List<AllSchemeWithFilters> allSchemeWithFilterss = [];

    for (var sch in jsonData) {
      var a = (sch['nav_price']);
      var nav1 = a['1'];
      var nav2 = a['3'];
      var nav3 = a['5'];
      String credentials = sch['isin'];
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      Body.encoded = stringToBase64.encode(credentials);
      AllSchemeWithFilters allSchemeWithFilters = AllSchemeWithFilters(
        sch['pk_nav_id'],
        sch['unique_no'],
        sch['scheme_name'],
        sch['scheme_type'],
        sch['scheme_code'],
        sch['rta_scheme_code'],
        sch['amc_scheme_code'],
        sch['isin'],
        sch['scheme_plan'],
        nav1.toString(),
        nav2.toString(),
        nav3.toString(),
        Body.encoded,
      );
      if (sch['pk_nav_id'] != null) {}
      allSchemeWithFilterss.add(allSchemeWithFilters);
    }
    return allSchemeWithFilterss;
  }

  makeSipRequestFilters(pknavid) async {
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
    //print(response.body);
    Body.minAmt = double.tryParse(jsonData[0]['minimum_purchase_amount']);
    Body.maxAmt = double.tryParse(jsonData[0]['maximum_purchase_amount']);
    Body.id = jsonData[0]['pk_nav_id'];
    Body.lumpSumMin = double.tryParse(jsonData[0]['minimum_purchase_amount']);
    Body.lumpSumMax = double.tryParse(jsonData[0]['maximum_purchase_amount']);
    if (Body.lumpSumMin == Body.lumpSumMax) {
      Body.lumpSumMin = 0.0;
      Body.lumpSumMax = 99999999.0;
    }
    if (Body.minAmt == Body.maxAmt) {
      Body.minAmt = 0.0;
      Body.maxAmt = 99999999.0;
    }
    Body.values = Body.minAmt;
    // print(Body.minAmt);
    // print(Body.maxAmt);
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
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/2.png',
                height: windowHeight * 0.06,
              ),
              Text(
                'AMC List',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(),
            ],
          ),
        ),
        actions: [
          CloseButton(
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getSchemeListRequest(),
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Hold On We are fetching the data'),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OH!!!!',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'The selected filters do not have any schemes under them. Please try with a different options.',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                        await makeSipRequestFilters(
                            snapshot.data[index].pk_nav_id);
                        Navigator.pushNamed(
                            context, DetailsPageFilters.routeName);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Card(
                          elevation: 1,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}

class AllSchemeWithFilters {
  // ignore: non_constant_identifier_names
  final String pk_nav_id;
  // ignore: non_constant_identifier_names
  var unique_no;
  // ignore: non_constant_identifier_names
  var scheme_name;
  // ignore: non_constant_identifier_names
  var scheme_type;
  // ignore: non_constant_identifier_names
  var scheme_code;
  // ignore: non_constant_identifier_names
  var rta_scheme_code;
  // ignore: non_constant_identifier_names
  var amc_scheme_code;
  var isin;
  // ignore: non_constant_identifier_names
  var scheme_plan;
  // ignore: non_constant_identifier_names
  var nav_price1;
  // ignore: non_constant_identifier_names
  var nav_price2;
  // ignore: non_constant_identifier_names
  var nav_price3;
  var encodedIsin;

  AllSchemeWithFilters(
    this.pk_nav_id,
    this.unique_no,
    this.scheme_name,
    this.scheme_type,
    this.scheme_code,
    this.rta_scheme_code,
    this.amc_scheme_code,
    this.isin,
    this.scheme_plan,
    this.nav_price1,
    this.nav_price2,
    this.nav_price3,
    this.encodedIsin,
  );
}
