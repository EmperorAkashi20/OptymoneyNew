import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';

class AmcFilters extends StatefulWidget {
  static List selecteCategorys = [];
  static var testVar;
  const AmcFilters({Key? key}) : super(key: key);

  @override
  _AmcFiltersState createState() => _AmcFiltersState();
}

class _AmcFiltersState extends State<AmcFilters> {
  var userStatus = <bool>[];
  bool selected = false;

  Future<List<AmcDetails>> makeAmcRequest() async {
    var url = Uri.parse(
        'https://optymoney.com/__lib.ajax/ajax_response.php?action=amccodes&subaction=submit');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {};
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    var dataBody = response.body;
    var jsonData = json.decode(dataBody);
    //print(jsonData);
    List<AmcDetails> amcDetailss = [];

    for (var sch in jsonData) {
      AmcDetails amcDetails = AmcDetails(
        sch['mf_schema_id'],
        sch['amc_name_act'],
      );
      if (sch['mf_schema_id'] != null) {}
      amcDetailss.add(amcDetails);
      userStatus.add(false);
    }
    return amcDetailss;
  }

  @override
  void initState() {
    super.initState();
    AmcFilters.selecteCategorys = [];
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidht = MediaQuery.of(context).size.width;
    return Container(
      child: FutureBuilder(
        future: makeAmcRequest(),
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
            return Column(
              children: [
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        title: Text(snapshot.data[index].amc_name_act),
                        value: userStatus[index],
                        onChanged: (val) {
                          setState(() {
                            userStatus[index] = !userStatus[index];
                            if (userStatus[index] == true) {
                              AmcFilters.selecteCategorys
                                  .add(snapshot.data[index].mf_schema_id);
                            } else if (userStatus[index] == false) {
                              AmcFilters.selecteCategorys
                                  .remove(snapshot.data[index].mf_schema_id);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class AmcDetails {
  // ignore: non_constant_identifier_names
  final String mf_schema_id;
  // ignore: non_constant_identifier_names
  final String amc_name_act;

  AmcDetails(this.mf_schema_id, this.amc_name_act);
}
