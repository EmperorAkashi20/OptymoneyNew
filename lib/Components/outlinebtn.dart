import 'package:flutter/material.dart';

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({required this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    return Container(
      height: windowHeight * 0.07,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Color(0xFFFDB2D4B)), //Color(0xFFB40284A)),
          borderRadius: BorderRadius.circular(50)),
      //padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}
