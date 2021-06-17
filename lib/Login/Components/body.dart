import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optymoney/Components/alreadyHaveAnAccountCheck.dart';
import 'package:optymoney/Components/roundedButton.dart';
import 'package:optymoney/Components/roundedInputFiled.dart';
import 'package:optymoney/Components/roundedPasswordField.dart';
import 'package:optymoney/Login/Components/background.dart';
import 'package:optymoney/SignUp/signupscreen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            'assets/icons/login.svg',
            height: size.height * 0.35,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: 'Your Email',
            icon: Icons.person,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedButton(
            text: 'Login',
            press: () {},
          ),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
