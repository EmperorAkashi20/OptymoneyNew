import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/2.png',
                height: windowHeight * 0.06,
              ),
              Text(
                'Currently Processing',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              CloseButton(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WillOrders {
  // ignore: non_constant_identifier_names
  var pk_user_settings_id;
  // ignore: non_constant_identifier_names
  var fr_user_id;
  // ignore: non_constant_identifier_names
  var paid_amount;
  // ignore: non_constant_identifier_names
  var pending_amount;
  // ignore: non_constant_identifier_names
  var pay_status;
  // ignore: non_constant_identifier_names
  var pay_for;
  // ignore: non_constant_identifier_names
  var txn_id;
  var narration;
  // ignore: non_constant_identifier_names
  var setting_modified_date;
  // ignore: non_constant_identifier_names
  var setting_create_date;
  // ignore: non_constant_identifier_names
  var response_msg;
  // ignore: non_constant_identifier_names
  var url_link;

  WillOrders(
    this.pk_user_settings_id,
    this.fr_user_id,
    this.paid_amount,
    this.pending_amount,
    this.pay_status,
    this.pay_for,
    this.txn_id,
    this.narration,
    this.setting_modified_date,
    this.setting_create_date,
    this.response_msg,
    this.url_link,
  );
}
