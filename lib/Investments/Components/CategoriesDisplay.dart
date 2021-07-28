import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';

class CategoriesDisplay extends StatefulWidget {
  static List selectedCategories = [];
  static var keys;
  static var values;
  const CategoriesDisplay({Key? key}) : super(key: key);

  @override
  _CategoriesDisplayState createState() => _CategoriesDisplayState();
}

class _CategoriesDisplayState extends State<CategoriesDisplay> {
  bool selected = false;
  var userStatus = <bool>[];
  var selectAll = <bool>[];
  final allCheckbox = CategoryFilters(title: 'SELECT ALL');

  Future<List<CategoryFiltersList>> getCategoryList() async {
    var url = Uri.parse(
        'https://optymoney.com/__lib.ajax/ajax_response.php?action=schemetypelist&subaction=submit');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'st_search': '',
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<CategoryFiltersList> categoryFiltersLists = [];
    jsonResponse.forEach((key, value) {
      CategoryFiltersList categoryFiltersList =
          CategoryFiltersList.fromJson(jsonResponse);

      CategoriesDisplay.keys = jsonResponse.keys.toList();
      CategoriesDisplay.values = jsonResponse.values.toList();
      categoryFiltersLists.add(categoryFiltersList);
    });

    return categoryFiltersLists;
  }

  @override
  void initState() {
    super.initState();
    CategoriesDisplay.selectedCategories = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getCategoryList(),
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
                    itemCount: CategoriesDisplay.keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      var key = CategoriesDisplay.keys.elementAt(index);
                      var values = CategoriesDisplay.values.elementAt(index);
                      var sch = values['value'];
                      var sch1 = sch;
                      selectAll.add(false);
                      return Column(
                        children: [
                          ExpansionTile(
                            title: Text('$key'),
                            children: [
                              CheckboxListTile(
                                title: Text('SELECT ALL'),
                                value: selectAll[index],
                                onChanged: (val) {
                                  setState(() {
                                    selectAll[index] = !selectAll[index];
                                    if (selectAll[index] == true) {
                                      for (int i = 0; i < sch.length; i++) {
                                        userStatus[i] = (true);
                                        CategoriesDisplay.selectedCategories
                                            .add(sch1[i]['id']);
                                        print(CategoriesDisplay
                                            .selectedCategories);
                                      }
                                    }
                                    if (selectAll[index] == false) {
                                      for (int i = 0; i < sch.length; i++) {
                                        userStatus[i] = (false);
                                        CategoriesDisplay.selectedCategories
                                            .remove(sch1[i]['id']);
                                        print(CategoriesDisplay
                                            .selectedCategories);
                                      }
                                    }
                                  });
                                },
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: sch.length,
                                itemBuilder: (context, index) {
                                  userStatus.add(false);
                                  return CheckboxListTile(
                                    title: Text(sch1[index]['name'].toString()),
                                    value: userStatus[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        //selected = !selected;
                                        userStatus[index] = !userStatus[index];
                                        if (userStatus[index] == true) {
                                          CategoriesDisplay.selectedCategories
                                              .add(sch1[index]['id']);
                                          print(CategoriesDisplay
                                              .selectedCategories);
                                        } else if (userStatus[index] == false) {
                                          CategoriesDisplay.selectedCategories
                                              .remove(sch1[index]['id']);
                                          print(CategoriesDisplay
                                              .selectedCategories);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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

class CategoryFiltersList {
  // ignore: non_constant_identifier_names
  var EQUITY;
  // ignore: non_constant_identifier_names
  var ELSS;
  // ignore: non_constant_identifier_names
  var HYBRID;
  // ignore: non_constant_identifier_names
  var DEBT;
  // ignore: non_constant_identifier_names
  var FOF;

  CategoryFiltersList(
    this.EQUITY,
    this.ELSS,
    this.HYBRID,
    this.DEBT,
    this.FOF,
  );

  Map<String, dynamic> toJson() => {
        'EQUITY': EQUITY,
        'ELSS': ELSS,
        'HYBRID': HYBRID,
        'DEBT': DEBT,
        'FOF': FOF,
      };

  // for init from a json object.
  CategoryFiltersList.fromJson(Map<String, dynamic> json)
      : EQUITY = json['EQUITY'],
        ELSS = json['ELSS'],
        HYBRID = json['HYBRID'],
        DEBT = json['DEBT'],
        FOF = json['FOF'];
}

class CategoryFilters {
  final String title;
  bool value;

  CategoryFilters({
    required this.title,
    this.value = false,
  });
}

class SingleValues {
  var name;
  var id;

  SingleValues(
    this.name,
    this.id,
  );
}
