import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optymoney/constants.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WELCOME TO OPTYMONEY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: size.height * 0.45,
          ),
          RoundedButton(
            text: 'LOGIN',
            press: () {},
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: Container(
        width: size.width * 0.8,
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 40),
          child: TextButton(
            onPressed: press(),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
