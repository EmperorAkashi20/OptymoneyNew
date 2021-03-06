import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optymoney/LoginNSignUp/loginNsignup.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    // double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, LoginAndSignUp.routeName),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: windowHeight * 0.7,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/tax_vec.png',
                                ),
                                height: windowHeight * 0.3,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'TAX',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Personalized income tax consultation and tax filing services with expert assistance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/investment.png',
                                ),
                                height: windowHeight * 0.3,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Wealth - Live your life smarter with us!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Lets you manage your financial goals and allows you to invest in new ones',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/will.png',
                                ),
                                height: windowHeight * 0.3,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Will',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Hassle free WIll creation and revision with the expert assistance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: windowHeight * 0.1,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, LoginAndSignUp.routeName),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Awesome! Let's Go!!",
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
