import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';

class GraphTest extends StatefulWidget {
  static String routeName = '/graphTest';
  static var keys;
  static var values;
  const GraphTest({Key? key}) : super(key: key);

  @override
  _GraphTestState createState() => _GraphTestState();
}

class _GraphTestState extends State<GraphTest> {
  Future<List<ChartData>> _getChartData() async {
    var url = Uri.parse('https://optymoney.com/__lib.ajax/ajax_response.php');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'get_nav': 'yes',
      'sch_code': 'SU5GODQ2SzAxMTY0',
    };
    Response response = await post(
      url,
      headers: headers,
      body: body,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<ChartData> chartDatas = [];
    jsonResponse.forEach((key, value) {
      ChartData chartData = ChartData.fromJson(jsonResponse);

      GraphTest.keys = jsonResponse.keys.toList();
      GraphTest.values = jsonResponse.values.toList();
      chartDatas.add(chartData);
    });
    print(GraphTest.keys);
    return chartDatas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
            } else {
              return Container(
                height: 500,
                width: double.infinity,
              );
            }
          },
        ),
      ),
    );
  }
}

class ChartData {
  // ignore: non_constant_identifier_names
  var price_date;
  // ignore: non_constant_identifier_names
  var net_asset_value;

  ChartData(
    this.price_date,
    this.net_asset_value,
  );

  Map<dynamic, dynamic> toJson() => {
        'price_date': price_date,
        'net_asset_value': net_asset_value,
      };

  ChartData.fromJson(Map<dynamic, dynamic> json)
      : price_date = json['price_date'],
        net_asset_value = json['net_asset_value'];
}
