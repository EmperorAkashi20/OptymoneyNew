import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optymoney/BankDetails/BankDetails.dart';
import 'package:optymoney/Cart/Cart.dart';
import 'package:optymoney/CompleteProfile/CompleteProfile.dart';
import 'package:optymoney/Feedback/Feedback.dart';
import 'package:optymoney/LoginNSignUp/Components/body.dart';
import 'package:optymoney/Onboarding/Onboarding.dart';
import 'package:optymoney/Orders/Orders.dart';
import 'package:optymoney/SupportTicket/SupportTicket.dart';
import 'package:optymoney/ViewProfile/ViewProfile.dart';
import 'package:optymoney/graphtest.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: windowHeight * 0.5,
                width: windowWidth,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Center(
                            child: Text(
                              LoginSignUp.globalLetter.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          LoginSignUp.globalName.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LoginSignUp.globalEmail.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (LoginSignUp.kycStatus.toString() != 'success')
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Onboarding.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.blueGrey.shade700),
                              ),
                              height: windowHeight * 0.04,
                              width: windowWidth * 0.4,
                              child: Center(
                                child: Text('Complete Your KYC'),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile Completion Status',
                          style: TextStyle(fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showSnackBar('Basic Details: Complete');
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: windowWidth * 0.3,
                                height: 4,
                                color: Colors.blue.shade700,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (LoginSignUp.globalPan.toString() !=
                                      'null') {
                                    setState(() {
                                      _showSnackBar('Profile Status: Complete');
                                    });
                                  } else {
                                    setState(() {
                                      _showSnackBar(
                                          'Profile Status: Incomplete');
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  child: Center(
                                    child: LoginSignUp.globalPan.toString() !=
                                            'null'
                                        ? Icon(
                                            Icons.check,
                                            size: 15,
                                          )
                                        : Text(
                                            '?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Container(
                                width: windowWidth * 0.3,
                                height: 4,
                                color: LoginSignUp.kycStatus == 'success'
                                    ? Colors.blue.shade700
                                    : Colors.white,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (LoginSignUp.kycStatus.toString() ==
                                      'success') {
                                    setState(() {
                                      _showSnackBar(
                                          'KYC Status: Complete. You are investment ready.');
                                    });
                                  } else {
                                    setState(() {
                                      _showSnackBar(
                                          'KYC Status: Incomplete. You cannot invest yet.');
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  child: Center(
                                    child: LoginSignUp.kycStatus == 'success'
                                        ? Icon(
                                            Icons.check,
                                            size: 15,
                                          )
                                        : Text(
                                            '?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: windowHeight * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.listUl,
                      size: 25,
                    ),
                    title: Text(
                      'Orders',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    subtitle: Text('Check your order status'),
                    onTap: () {
                      Navigator.pushNamed(context, Orders.routeName);
                    },
                    // tileColor: Colors.lightBlue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.users,
                      size: 25,
                    ),
                    title: Text(
                      'Profile Details',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    subtitle: Text('Tap to view or edit your data'),
                    onTap: () {
                      if (LoginSignUp.globalPan.toString() == 'null') {
                        Navigator.pushNamed(context, CompleteProfile.routeName);
                      } else {
                        Navigator.pushNamed(context, ViewProfile.routeName);
                      }
                    },
                    // tileColor: Colors.lightBlue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.moneyCheck,
                      size: 25,
                    ),
                    title: Text(
                      'Bank Accounts',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    subtitle: Text('Tap to view or edit your bank details'),
                    onTap: () {
                      Navigator.pushNamed(context, BankDetails.routeName);
                    },
                    // tileColor: Colors.lightBlue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.history,
                      size: 25,
                    ),
                    title: Text(
                      'Transaction History',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    subtitle: Text('Tap to view your previous transactions'),
                    onTap: () {},
                    // tileColor: Colors.lightBlue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.shoppingCart,
                      size: 25,
                    ),
                    title: Text(
                      'Cart',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    subtitle: Text('Tap to view your cart and checkout'),
                    onTap: () {
                      Navigator.pushNamed(context, Cart.routeName);
                    },
                    // tileColor: Colors.lightBlue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, GraphTest.routeName);
                    },
                    child: Text('Knowledge & FAQ'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Contact an Expert'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Help Center'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Privacy Policy'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FeedbackApp.routeName);
                    },
                    child: Text('Feedback'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SupportTicket.routeName);
                    },
                    child: Text('Raise a support ticket'),
                  ),
                ),
              ),
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
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
