import 'dart:async';

import 'package:flutter/material.dart';
import 'package:katto/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToHome() async {
    Timer(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyApp2(),
        ),
      );
    });
  }

  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5713,
              child: Image.asset(
                "assets/upper_slant.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff2F2F2F),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width * 0.4637,
                      child: Image.asset('assets/splash_screen_icon.jpg'),
                    ),
                    Text(
                      'KATTO',
                      style: TextStyle(
                        color: Color(0xffDDA00A),
                        fontFamily: 'primary',
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'A B   J H U M E G A   I N D I A',
                      style: TextStyle(
                        color: Color(0xff4B4B4B),
                        fontFamily: 'secondary',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5713,
              child: Image.asset(
                "assets/bottom_slant.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
