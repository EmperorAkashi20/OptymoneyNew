import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  static String routeName = '/tos';
  const TermsOfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Support Ticket',
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
