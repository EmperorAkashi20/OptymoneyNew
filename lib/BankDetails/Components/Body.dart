import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:optymoney/Components/inputwithicon.dart';
import 'package:optymoney/Components/outlinebtn.dart';
import 'package:optymoney/Components/primarybtn.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';

addBankAccount() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=insertbank_api&subaction=Submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'bank_name': Body.bankName.toString(),
    'acc_no': Body.accountNumber.toString(),
    'ifsc_code': Body.ifsc.toString(),
    'id': '',
    'uid': LoginSignUp.globalUserId,
  };
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = response.body;
  var jsonData = json.decode(responseBody);
  print(jsonData);
}

deleteBankAccount() async {
  var url = Uri.parse(
      'https://optymoney.com/ajax-request/ajax_response.php?action=deletebank_api&subaction=Submit');
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, dynamic> body = {
    'id': Body.bankId,
    'uid': LoginSignUp.globalUserId,
  };
  //String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    url,
    headers: headers,
    body: body,
    encoding: encoding,
  );

  var responseBody = response.body;
  var jsonData = json.decode(responseBody);
  print(jsonData);
}

class Body extends StatefulWidget {
  static var bankName;
  static var accountNumber;
  static var ifsc;
  static var bankId;
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var color1;

  TextEditingController bankAccountNameController =
      new TextEditingController(text: Body.bankName);
  TextEditingController bankAccountNumberController =
      new TextEditingController(text: Body.accountNumber);
  TextEditingController bankAccountIfscController =
      new TextEditingController(text: Body.ifsc);
  TextEditingController addBankNameController = new TextEditingController();
  TextEditingController addBankIfscController = new TextEditingController();
  TextEditingController addBankAccountNumberController =
      new TextEditingController();
  Future<List<BankDetail>> _getBankDetail() async {
    var url = Uri.parse(
        'https://optymoney.com/ajax-request/ajax_response.php?action=getBankDetails_api&subaction=submit');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {
      'uid': LoginSignUp.globalUserId,
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var bankBody = response.body;
    var jsonData = json.decode(bankBody);
    print(jsonData);
    var len = jsonData.length;
    print('Length');
    print(len);
    List<BankDetail> bankDetails = [];
    for (var sch in jsonData) {
      BankDetail bankDetail = BankDetail(
        sch['pk_bank_detail_id'],
        sch['fr_user_id'],
        sch['bank_name'],
        sch['acc_no'],
        sch['ifsc_code'],
        sch['swift_code'].toString(),
        sch['mandate_id'],
        sch['mandate_start_dt'].toString(),
        sch['mandate_end_dt'].toString(),
        sch['default_bank'],
        sch['bank_created_date'],
        sch['bank_modified_date'],
      );
      print(sch['fr_user_id']);
      if (sch['pk_bank_details_id'] != null) {
        print('object');
      } else {
        bankDetails.add(bankDetail);
      }
    }
    return bankDetails;
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = false;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          CloseButton(color: Colors.black),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getBankDetail(),
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
                      Text('Loading...'),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data.length == 0) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.university,
                          color: Colors.grey.shade400,
                          size: 60,
                        ),
                        Text(
                          'You have not added any accounts,\nPurchase will Not be possible without adding accounts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Please Tap on the \'+\' Icon in the bottom to add your account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF5B16D0),
                            child: Icon(
                              Icons.add,
                              size: 40,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    automaticallyImplyLeading: false,
                                    title: Text(
                                      'Add New Bank Account',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      CloseButton(
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                  body: SingleChildScrollView(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InputWithIcon(
                                                icon: Icons.text_fields,
                                                hint: 'Bank Name',
                                                obscureText: false,
                                                dataController:
                                                    addBankNameController,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InputWithIcon(
                                                icon: Icons.text_fields,
                                                hint: 'Account Number',
                                                obscureText: false,
                                                dataController:
                                                    addBankAccountNumberController,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InputWithIcon(
                                                icon: Icons.text_fields,
                                                hint: 'IFSC',
                                                obscureText: false,
                                                dataController:
                                                    addBankIfscController,
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Body.ifsc =
                                                      addBankIfscController
                                                          .text;
                                                  Body.bankName =
                                                      addBankNameController
                                                          .text;
                                                  Body.accountNumber =
                                                      addBankAccountNumberController
                                                          .text;
                                                  await addBankAccount();
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _getBankDetail();
                                                  });
                                                },
                                                child: PrimaryButton(
                                                    btnText: 'Add Account'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          color1 = Color(0xFF5B16D0);
                        } else if (index == 1) {
                          color1 = Color(0xFF5B16D0).withOpacity(0.5);
                        } else if (2 % index == 0) {
                          color1 = Color(0xFF5B16D0);
                        } else if (2 % index != 0) {
                          color1 = Color(0xFF5B16D0).withOpacity(0.5);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            shadowColor: color1,
                            color: color1,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Color(0xFF5B16D0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.university,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LoginSignUp.globalName
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[index].bank_name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 20,
                                          child: IconButton(
                                            icon: Icon(Icons.add_chart),
                                            onPressed: () {
                                              setState(() {
                                                Body.accountNumber =
                                                    snapshot.data[index].acc_no;
                                                Body.bankName = snapshot
                                                    .data[index].bank_name;
                                                Body.ifsc = snapshot
                                                    .data[index].ifsc_code;
                                              });
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) => Scaffold(
                                                  appBar: AppBar(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    automaticallyImplyLeading:
                                                        false,
                                                    title: Text(
                                                      'Manage Your Account',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    actions: [
                                                      CloseButton(
                                                          color: Colors.black),
                                                    ],
                                                  ),
                                                  body: SingleChildScrollView(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    18.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                InputWithIcon(
                                                                  icon: Icons
                                                                      .text_fields,
                                                                  hint:
                                                                      'Bank Name',
                                                                  obscureText:
                                                                      false,
                                                                  dataController:
                                                                      bankAccountNameController,
                                                                  enabledOrNot:
                                                                      enabled,
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                InputWithIcon(
                                                                  icon: Icons
                                                                      .text_fields,
                                                                  hint:
                                                                      'Account Number',
                                                                  obscureText:
                                                                      false,
                                                                  dataController:
                                                                      bankAccountNumberController,
                                                                  enabledOrNot:
                                                                      enabled,
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                InputWithIcon(
                                                                  icon: Icons
                                                                      .text_fields,
                                                                  hint:
                                                                      'Bank Name',
                                                                  obscureText:
                                                                      false,
                                                                  dataController:
                                                                      bankAccountIfscController,
                                                                  enabledOrNot:
                                                                      enabled,
                                                                ),
                                                                // SizedBox(
                                                                //   height: 20,
                                                                // ),
                                                                // TextButton(
                                                                //   child: Text(
                                                                //       'Save'),
                                                                //   onPressed:
                                                                //       () {
                                                                //     setState(
                                                                //         () {
                                                                //       enabled =
                                                                //           false;
                                                                //     });
                                                                //   },
                                                                // ),
                                                                // SizedBox(
                                                                //   height: 40,
                                                                // ),
                                                                // GestureDetector(
                                                                //   onTap: () {
                                                                //     setState(
                                                                //         () {
                                                                //       enabled =
                                                                //           true;
                                                                //     });
                                                                //   },
                                                                //   child: PrimaryButton(
                                                                //       btnText:
                                                                //           'Edit Bank Details'),
                                                                // ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Body.bankId = snapshot
                                                                        .data[
                                                                            index]
                                                                        .pk_bank_detail_id
                                                                        .toString();

                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('Please Confirm'),
                                                                          content:
                                                                              Text('Are you sure you want to delete this account?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                await deleteBankAccount();
                                                                                Navigator.pop(context);
                                                                                setState(() {
                                                                                  _getBankDetail();
                                                                                });
                                                                              },
                                                                              child: Text('Yes'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                setState(() {
                                                                                  _getBankDetail();
                                                                                });
                                                                              },
                                                                              child: Text('Cancel'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: OutlineBtn(
                                                                      btnText:
                                                                          'Delete This Account'),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
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
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.white,
                                    thickness: 0.3,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Account Number',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].acc_no
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'IFSC Code',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].ifsc_code
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Mandate Id',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].mandate_id,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
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
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FloatingActionButton(
                        backgroundColor: Color(0xFF5B16D0),
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                automaticallyImplyLeading: false,
                                title: Text(
                                  'Add New Bank Account',
                                  style: TextStyle(color: Colors.black),
                                ),
                                actions: [
                                  CloseButton(
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              body: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InputWithIcon(
                                          icon: Icons.text_fields,
                                          hint: 'Bank Name',
                                          obscureText: false,
                                          dataController: addBankNameController,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InputWithIcon(
                                          icon: Icons.text_fields,
                                          hint: 'Account Number',
                                          obscureText: false,
                                          dataController:
                                              addBankAccountNumberController,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InputWithIcon(
                                          icon: Icons.text_fields,
                                          hint: 'IFSC',
                                          obscureText: false,
                                          dataController: addBankIfscController,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Body.ifsc =
                                                addBankIfscController.text;
                                            Body.bankName =
                                                addBankNameController.text;
                                            Body.accountNumber =
                                                addBankAccountNumberController
                                                    .text;
                                            await addBankAccount();
                                            Navigator.pop(context);
                                            setState(() {
                                              _getBankDetail();
                                            });
                                          },
                                          child: PrimaryButton(
                                              btnText: 'Add Account'),
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
                    ),
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

class BankDetail {
  // ignore: non_constant_identifier_names
  final String pk_bank_detail_id;
  // ignore: non_constant_identifier_names
  final String fr_user_id;
  // ignore: non_constant_identifier_names
  final String bank_name;
  // ignore: non_constant_identifier_names
  final String acc_no;
  // ignore: non_constant_identifier_names
  final String ifsc_code;
  // ignore: non_constant_identifier_names
  final String swift_code;
  // ignore: non_constant_identifier_names
  final String mandate_id;
  // ignore: non_constant_identifier_names
  final String mandate_start_dt;
  // ignore: non_constant_identifier_names
  final String mandate_end_dt;
  // ignore: non_constant_identifier_names
  final String default_bank;
  // ignore: non_constant_identifier_names
  final String bank_created_date;
  // ignore: non_constant_identifier_names
  final String bank_modified_date;

  BankDetail(
    this.pk_bank_detail_id,
    this.fr_user_id,
    this.bank_name,
    this.acc_no,
    this.ifsc_code,
    this.swift_code,
    this.mandate_id,
    this.mandate_start_dt,
    this.mandate_end_dt,
    this.default_bank,
    this.bank_created_date,
    this.bank_modified_date,
  );
}
