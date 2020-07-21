import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedin = false;
  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedin = true;
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
                },
                child: Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedin
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff2F2F2F),
              body: Column(
                children: [
                  Text(_googleSignIn.currentUser.displayName),
                  Text(_googleSignIn.currentUser.email),
                  Text(_googleSignIn.currentUser.photoUrl),
                  Text(_googleSignIn.currentUser.id),
                  RaisedButton(
                    onPressed: () async {
                      try {
                        await _googleSignIn.signOut();
                        setState(() {
                          _isLoggedin = false;
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
                                  },
                                  child: Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(fontFamily: 'secondary'),
                    ),
                  )
                ],
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff2F2F2F),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: InkWell(
                      onTap: _login,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.5 + 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 3),
                                blurRadius: 2.5,
                                spreadRadius: .1),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: Image.asset('assets/google.png'),
                            ),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontFamily: 'secondary',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
