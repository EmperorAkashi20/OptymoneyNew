import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optymoney/Cart/Cart.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:http/http.dart' as http;
import 'package:optymoney/LoginNSignUp/Components/body.dart';

Future<http.StreamedResponse> makeItrRequest() async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://optymoney.com/ajax-request/ajax_response.php?action=itrRegistration&subaction=submit'),
  );
  request.headers.addAll({
    "content-type": "multipart/form-data",
  });
  request.fields['itr_e'] = 'itr';
  request.fields['fname'] = LoginSignUp.globalName.toString();
  request.fields['mobile'] = LoginSignUp.customerMobile.toString();
  request.fields['pan'] = LoginSignUp.globalPan.toString();
  request.fields['dobofusr'] = LoginSignUp.customerBday;
  request.fields['address'] = LoginSignUp.customerAddress1 +
      LoginSignUp.customerAddress2 +
      LoginSignUp.customerAddress3 +
      " " +
      LoginSignUp.customerCity +
      " " +
      LoginSignUp.customerState +
      " " +
      LoginSignUp.customerPinCode +
      " " +
      LoginSignUp.customerCountry;
  request.fields['father_name'] = LoginSignUp.nomineeName;
  request.fields['email'] = LoginSignUp.globalEmail;
  request.fields['aadhaar'] = LoginSignUp.aadhar;
  request.fields['description'] = '';
  request.fields['bank'] = Body.bank;
  request.fields['acno'] = Body.accno1;
  request.fields['ifsc'] = Body.ifsc1;
  request.fields['uid'] = LoginSignUp.globalUserId;
  if (Body.filesitr != null) {
    for (int i = 0; i < Body.filesitr.length; i++) {
      request.files.add(
        http.MultipartFile(
            'fileitr[]',
            File(Body.filesitr[i]).readAsBytes().asStream(),
            File(Body.filesitr[i]).lengthSync(),
            filename: Body.filesitr[i].split("/").last),
      );
    }
  }
  if (Body.addfileitr != null) {
    for (int i = 0; i < Body.addfileitr.length; i++) {
      request.files.add(
        http.MultipartFile(
            'addfileitr[]',
            File(Body.addfileitr[i]).readAsBytes().asStream(),
            File(Body.addfileitr[i]).lengthSync(),
            filename: Body.addfileitr[i].split("/").last),
      );
    }
  }
  if (Body.noticecopy != null) {
    for (int i = 0; i < Body.noticecopy.length; i++) {
      request.files.add(
        http.MultipartFile(
            'noticecopy',
            File(Body.noticecopy[i]).readAsBytes().asStream(),
            File(Body.noticecopy[i]).lengthSync(),
            filename: Body.noticecopy[i].split("/").last),
      );
    }
  }
  if (Body.itrfiledcopy != null) {
    for (int i = 0; i < Body.itrfiledcopy.length; i++) {
      request.files.add(
        http.MultipartFile(
            'itrfiledcopy',
            File(Body.itrfiledcopy[i]).readAsBytes().asStream(),
            File(Body.itrfiledcopy[i]).lengthSync(),
            filename: Body.itrfiledcopy[i].split("/").last),
      );
    }
  }
  if (Body.addeassest != null) {
    for (int i = 0; i < Body.addeassest.length; i++) {
      request.files.add(
        http.MultipartFile(
            'addeassest[]',
            File(Body.addeassest[i]).readAsBytes().asStream(),
            File(Body.addeassest[i]).lengthSync(),
            filename: Body.addeassest[i].split("/").last),
      );
    }
  }
  var res = await request.send();
  var response = await res.stream.bytesToString();
  // print(response);
  // var parsedJson = jsonDecode(response);
  //Body.status = parsedJson['status'];
  //print(parsedJson['msg']);
  // Body.message = parsedJson['msg'];
  Body.message = response.toString();
  return res;
}

class Body extends StatefulWidget {
  static var filesitr;
  static var addfileitr;
  static var noticecopy;
  static var itrfiledcopy;
  static var addeassest;
  static var message;
  static var status;

  static var bank;
  static var accno1;
  static var ifsc1;

  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _itr = false;
  var concatenate = StringBuffer();
  var a = ['nodata'];
  var b = ['nodata'];
  var c = ['nodata'];
  var d = ['nodata'];
  var e = ['nodata'];
  TextEditingController bankName = new TextEditingController();
  TextEditingController accno = new TextEditingController();
  TextEditingController ifsc = new TextEditingController();
  var refreshkey = GlobalKey<RefreshIndicatorState>();

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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Cart.routeName);
                },
                child: FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Financial Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InputWithIcon(
                  icon: Icons.wrap_text,
                  hint: 'Bank Name',
                  obscureText: false,
                  dataController: bankName,
                ),
              ),
              SizedBox(
                height: windowHeight * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InputWithIcon(
                  icon: Icons.wrap_text,
                  hint: 'Account number',
                  obscureText: false,
                  dataController: accno,
                  keyboardTypeGlobal: TextInputType.number,
                ),
              ),
              SizedBox(
                height: windowHeight * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InputWithIcon(
                  icon: Icons.wrap_text,
                  hint: 'IFSC',
                  obscureText: false,
                  dataController: ifsc,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ITR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 50.0),
                      child: Switch.adaptive(
                        value: _itr,
                        onChanged: (bool value) {
                          setState(() {
                            _itr = value;
                            print(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "E-Assessment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (_itr == false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: windowWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                if (result != null) {
                                  // print('\nfile:' + result.paths.toString());
                                  Body.filesitr = result.paths;
                                  a = Body.filesitr.toList().cast<String>();
                                }
                              },
                              child: Text(
                                "Form 16/16A",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            elevation: 1,
                            child: Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  height: windowHeight * 0.25,
                                  child: Scrollbar(
                                    child: RefreshIndicator(
                                      onRefresh: callList,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        itemCount: a.isNotEmpty ? a.length : 1,
                                        itemBuilder: (context, index) {
                                          if (Body.filesitr == null) {
                                            return Center(
                                                child: Text(
                                                    'After selecting files, please pull down here to refresh'));
                                          } else if (Body.filesitr.length ==
                                              0) {
                                            return Text('okay');
                                          } else {
                                            return ListTile(
                                              title: Text('File ' +
                                                  (index + 1).toString() +
                                                  ': ' +
                                                  Body.filesitr.toString()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: windowWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                if (result != null) {
                                  // print('\nfile:' + result.paths.toString());
                                  Body.addfileitr = result.paths;
                                  b = Body.addfileitr.toList();
                                }
                              },
                              child: Text(
                                "Other Attachments",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            elevation: 1,
                            child: Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  height: windowHeight * 0.25,
                                  child: Scrollbar(
                                    child: RefreshIndicator(
                                      onRefresh: callList,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        itemCount: b.isNotEmpty ? b.length : 1,
                                        itemBuilder: (context, index) {
                                          if (Body.addfileitr == null) {
                                            return Center(
                                                child: Text(
                                                    'After selecting files, please pull down here to refresh'));
                                          } else if (Body.addfileitr.length ==
                                              0) {
                                            return Text('okay');
                                          } else {
                                            return ListTile(
                                              title: Text('File ' +
                                                  (index + 1).toString() +
                                                  ': ' +
                                                  Body.addfileitr.toString()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_itr == true)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: windowWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                if (result != null) {
                                  // print('\nfile:' + result.paths.toString());
                                  Body.noticecopy = result.paths;
                                  c = Body.noticecopy.toList();
                                }
                              },
                              child: Text(
                                "Notice Copy",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            elevation: 1,
                            child: Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  height: windowHeight * 0.25,
                                  child: Scrollbar(
                                    child: RefreshIndicator(
                                      onRefresh: callList,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        itemCount: c.isNotEmpty ? c.length : 1,
                                        itemBuilder: (context, index) {
                                          if (Body.noticecopy == null) {
                                            return Center(
                                                child: Text(
                                                    'After selecting files, please pull down here to refresh'));
                                          } else if (Body.noticecopy.length ==
                                              0) {
                                            return Text('okay');
                                          } else {
                                            return ListTile(
                                              title: Text('File ' +
                                                  (index + 1).toString() +
                                                  ': ' +
                                                  Body.noticecopy.toString()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: windowWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                if (result != null) {
                                  // print('\nfile:' + result.paths.toString());
                                  Body.itrfiledcopy = result.paths;
                                  d = Body.itrfiledcopy.toList();
                                }
                              },
                              child: Text(
                                "Last ITR Filed",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            elevation: 1,
                            child: Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  height: windowHeight * 0.25,
                                  child: Scrollbar(
                                    child: RefreshIndicator(
                                      onRefresh: callList,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        itemCount: d.isNotEmpty ? d.length : 1,
                                        itemBuilder: (context, index) {
                                          if (Body.itrfiledcopy == null) {
                                            return Center(
                                                child: Text(
                                                    'After selecting files, please pull down here to refresh'));
                                          } else if (Body.itrfiledcopy.length ==
                                              0) {
                                            return Text('okay');
                                          } else {
                                            return ListTile(
                                              title: Text('File ' +
                                                  (index + 1).toString() +
                                                  ': ' +
                                                  Body.itrfiledcopy.toString()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: windowWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);

                                if (result != null) {
                                  // print('\nfile:' + result.paths.toString());
                                  Body.addeassest = result.paths;
                                  e = Body.addeassest.toList();
                                }
                              },
                              child: Text(
                                "Other Attachment",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            elevation: 1,
                            child: Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  height: windowHeight * 0.25,
                                  child: Scrollbar(
                                    child: RefreshIndicator(
                                      onRefresh: callList,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        itemCount: e.isNotEmpty ? e.length : 1,
                                        itemBuilder: (context, index) {
                                          if (Body.addeassest == null) {
                                            return Center(
                                                child: Text(
                                                    'After selecting files, please pull down here to refresh'));
                                          } else if (Body.addeassest.length ==
                                              0) {
                                            return Text('okay');
                                          } else {
                                            return ListTile(
                                              title: Text('File ' +
                                                  (index + 1).toString() +
                                                  ': ' +
                                                  Body.addeassest.toString()),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: windowHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    Body.bank = bankName.text.toString();
                    Body.ifsc1 = ifsc.text.toString();
                    Body.accno1 = accno.text.toString();
                    await makeItrRequest();
                    // Navigator.pushNamed(context, FileDisplay.routeName);
                    _showSnackBar(Body.message +
                        ' We have received your request. Our team will get in touch with you within 48 hours. Thank you.');
                  },
                  child: OutlineBtn(btnText: "Proceed"),
                ),
              ),
              SizedBox(height: windowHeight * 0.03),
            ],
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

  Future<void> callList() async {
    refreshkey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
}
