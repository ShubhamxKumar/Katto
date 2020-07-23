import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:katto/globalData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:katto/screens/HomeScreen.dart';
import 'package:katto/screens/SettingScreen.dart';
import 'package:katto/widgets/BottomNavigationBar.dart';
import 'package:katto/widgets/LoggedInProfile.dart';
import 'package:katto/widgets/Login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  Future<void> _login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      GoogleSignInAccount account = await _googleSignIn.signIn();
      AuthResult _authResult = await _auth
          .signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken),
      )
          .then((user) async {
        try {
          await Firestore.instance
              .collection('Users')
              .document(user.user.uid)
              .get()
              .then((doc) {
            if (!doc.exists) {
              doc.reference.setData({
                'fullname': user.user.displayName,
                'username':
                    user.user.email.substring(0, user.user.email.indexOf('@')),
                'userId': user.user.uid,
                'profilePic': null,
                'useremail': user.user.email,
                'liked' : 0,
                'followers' : 0,
                'following' : 0,
                'videos' : [],
              });
            }
          });
        } catch (err) {
          print(err.message );
          setState(() {
            _isLoading = false;
          });
        }
      }).then((user) async {
        await getUserInfo();
      });
      setState(() {
        _isLoading = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff2f2f2f),
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffDDA00A),
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xff2f2f2f),
                  ),
                  strokeWidth: 5,
                ),
              ),
            ),
          )
        : StreamBuilder(
            builder: (context, sdata) {
              if (sdata.connectionState == ConnectionState.waiting) {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Color(0xff2f2f2f),
                    body: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xffDDA00A),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0xff2f2f2f),
                        ),
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                );
              }
              if (sdata.hasData) {
                return LoggedInProfile();
              } else {
                return Login(
                  login: _login,
                );
              }
            },
            stream: FirebaseAuth.instance.onAuthStateChanged,
          );
  }
}
