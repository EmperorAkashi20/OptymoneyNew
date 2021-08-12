import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/Onboarding/Onboarding.dart';
import 'package:url_launcher/url_launcher.dart';

deleteCartItem(cartid) async {
  var url = Uri.parse(
      'https://optymoney.com/__lib.ajax/mutual_fund.php?action=rmv_sch_api&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    "cart_id": cartid,
    "uid": LoginSignUp.globalUserId,
  });
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );
  print(response.body);
}

checkoutCartItem() async {
  var url = Uri.parse(
      'https://optymoney.com/__lib.ajax/mutual_fund.php?action=p_to_pay_api&subaction=submit');
  final headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    "status": 2,
    "uid": LoginSignUp.globalUserId,
  });
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );
  //print(response.body);
  // if (response.body is String) {
  //   print('yes');
  // } else {
  //   print('no');
  // }
  print(response.body);
  final payUrl = Uri.encodeFull(response.body);
  var len = payUrl.length;
  final payUrl1 = payUrl.substring(len);
  print(payUrl1);
  if (await canLaunch(payUrl)) {
    await launch(payUrl, forceWebView: true, enableJavaScript: true);
  } else {
    throw 'Could not launch $payUrl1';
  }
}

class Body extends StatefulWidget {
  static var totalAmt;
  static var url;
  static var responseBody;
  static var parsed;
  static var kycStatus;
  static var id;
  static var ttl;
  static var created;
  static var userId;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _suffix;
  var _lumpsum;
  var sum;
  Future<List<CartData>> _getCartData() async {
    var url = Uri.parse(
        'https://optymoney.com/__lib.ajax/mutual_fund.php?action=view_cart_api&subaction=submit');
    final headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "status": 0,
      "uid": LoginSignUp.globalUserId,
    });
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var cartBody = response.body;
    var jsonData = json.decode(cartBody);
    List<CartData> cartDatas = [];
    Body.totalAmt = 0.0;
    for (var sch in jsonData) {
      if (sch['date_sip'] == '0') {
        _lumpsum = 'Lumpsum Investment';
      } else if (sch['date_sip'] == '1' || sch['date_sip'] == '21') {
        _suffix = 'st';
        _lumpsum = 'SIP Date';
      } else if (sch['date_sip'] == '2' || sch['date_sip'] == '22') {
        _suffix = 'nd';
        _lumpsum = 'SIP Date';
      } else if (sch['date_sip'] == '3' || sch['date_sip'] == '23') {
        _suffix = 'rd';
        _lumpsum = 'SIP Date';
      } else {
        _suffix = 'th';
        _lumpsum = 'SIP Date';
      }
      CartData cartData = CartData(
        sch['scheme_name'],
        sch['amnt'],
        sch['p_method'],
        sch['date_sip'],
        sch['mf_cart_id'],
        _suffix,
        _lumpsum,
      );
      cartDatas.add(cartData);
    }
    return cartDatas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          CloseButton(color: Colors.black),
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: _getCartData(),
            builder: (BuildContext context, AsyncSnapshot snaphot) {
              if (snaphot.data == null) {
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
                        Text('Loading...'),
                      ],
                    ),
                  ),
                );
              } else if (snaphot.data.length == 0) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: Colors.grey.shade600,
                        size: 38,
                      ),
                      Text(
                        'Your Cart Is Empty.\n Please Add funds to your cart',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 15,
                        child: ListView.builder(
                          itemCount: snaphot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              child: Card(
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  snaphot
                                                      .data[index].scheme_name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  radius: 20,
                                                  child: IconButton(
                                                    icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .trashAlt,
                                                        size: 17),
                                                    onPressed: () async {
                                                      await deleteCartItem(
                                                          snaphot.data[index]
                                                              .mf_cart_id);
                                                      setState(() {
                                                        _getCartData();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    snaphot.data[index]
                                                        .lumpsumorsip,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  if (snaphot.data[index]
                                                          .lumpsumorsip ==
                                                      'SIP Date')
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snaphot.data[index]
                                                              .date_sip,
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          snaphot.data[index]
                                                              .suffix,
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Amount',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    snaphot.data[index].amnt,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (LoginSignUp.kycStatus == 'success') {
                              await checkoutCartItem();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'KYC Not Done',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: Text(
                                      'Please Complete Your KYC To Proceed Forward',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancle'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pushNamed(
                                              context, Onboarding.routeName);
                                        },
                                        child: Text('Continue'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: PrimaryButton(btnText: 'Checkout'),
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
}

class CartData {
  // ignore: non_constant_identifier_names
  var scheme_name;
  var amnt;
  // ignore: non_constant_identifier_names
  var p_method;
  // ignore: non_constant_identifier_names
  var date_sip;
  // ignore: non_constant_identifier_names
  var mf_cart_id;
  var suffix;
  var lumpsumorsip;

  CartData(
    this.scheme_name,
    this.amnt,
    this.p_method,
    this.date_sip,
    this.mf_cart_id,
    this.suffix,
    this.lumpsumorsip,
  );
}
