import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({required this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    return Container(
      height: windowHeight * 0.07,
      decoration: BoxDecoration(
          color: Color(0xFFFDB2D4B), //Color(0xFFB40284A),
          borderRadius: BorderRadius.circular(50)), //Color(0xFFB40284A)
      //padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
