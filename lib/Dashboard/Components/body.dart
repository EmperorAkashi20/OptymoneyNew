import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:optymoney/BestPerformingFunds/BestPerformingFunds.dart';
import 'package:optymoney/Calculators/calculators.dart';
import 'package:optymoney/Dashboard/Components/DashboardData.dart';
import 'package:optymoney/ITR/incometax.dart';
import 'package:optymoney/Investments/investments.dart';
import 'package:optymoney/Settings/Settings.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;
  List pageList = [
    DashboardData(),
    BestPerformingFunds(),
    Calculators(),
    IncomeTax(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.white.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Color(0xFF5B16D0).withOpacity(0.1),
              // tab button ripple color when pressed
              hoverColor: Color(0xFF5B16D0).withOpacity(0.5),
              // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 12,
              // tabActiveBorder: Border.all(
              //     color: Color(0xFF5B16D0).withOpacity(0.5),
              //     width: 0), // tab button border
              // tabBorder: Border.all(
              //     color: Color(0xFF5B16D0).withOpacity(0.5),
              //     width: 0), // tab button border
              // tabShadow: [
              //   BoxShadow(
              //       color: Color(0xFF5B16D0).withOpacity(0.5), blurRadius: 1)
              // ], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 900), // tab animation duration
              gap: 1, // the tab button gap between icon and text
              color: Color(0xFF5B16D0).withOpacity(0.5),
              // unselected icon color
              activeColor: Colors.purple, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Color(0xFF5B16D0).withOpacity(0.5),
// selected tab background color
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Dashboard',
                  textStyle: TextStyle(color: Colors.white),
                ),
                GButton(
                  icon: Icons.credit_card_rounded,
                  text: 'Investment',
                  textStyle: TextStyle(color: Colors.white),
                ),
                GButton(
                  icon: Icons.calculate_rounded,
                  text: 'Calculators',
                  textStyle: TextStyle(color: Colors.white),
                ),
                GButton(
                  icon: Icons.file_copy_rounded,
                  text: 'ITR',
                  textStyle: TextStyle(color: Colors.white),
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                  textStyle: TextStyle(color: Colors.white),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: pageList[_selectedIndex],
    );
  }
}
