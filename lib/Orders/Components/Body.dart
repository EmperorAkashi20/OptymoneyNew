import 'package:flutter/material.dart';
import 'package:optymoney/Orders/Components/MfOrders.dart';
import 'package:optymoney/Orders/Components/WillOrders.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    // double windowWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 90,
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
                  'Your Previous Orders',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                CloseButton(
                  color: Colors.black,
                )
              ],
            ),
          ),
          bottom: TabBar(
            tabs: [
              Text(
                'Mutual Fund Orders',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                'Will Orders',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MutualFundOrdersTab(),
            WillOrdersTab(),
          ],
        ),
      ),
    );
  }
}
