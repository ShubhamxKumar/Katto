import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katto/globalData.dart';
import 'package:katto/screens/RequestVerificationScreen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffDDA00A),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        backgroundColor: Color(0xff2f2f2f),
        elevation: 0,
        title: Text(
          'Privacy and Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: Color(0xff2f2f2f),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      RequestVerificationScreen(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Color(0xff2f2f2f),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(.1, .1),
                      blurRadius: 1.5,
                      spreadRadius: .1),
                ],
              ),
              child: Text(
                'Request Verification',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Color(0xff2f2f2f),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(.1, .1),
                    blurRadius: 1.5,
                    spreadRadius: .1),
              ],
            ),
            child: Text(
              'Visit Website',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await FirebaseAuth.instance.signOut().then((u) {
                  clearUserInfo();
                }).then((u) {
                  Navigator.of(context).pop();
                });
              } catch (err) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text(err.message),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: Text('OK'),
                        )
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Color(0xff2f2f2f),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(.1, .1),
                      blurRadius: 1.5,
                      spreadRadius: .1),
                ],
              ),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xffDDA00A),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0xff2f2f2f),
                        ),
                        strokeWidth: 5,
                      ),
                    )
                  : Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
