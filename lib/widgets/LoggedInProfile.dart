import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:katto/globalData.dart';
import 'package:katto/screens/HomeScreen.dart';
import 'package:katto/screens/SettingScreen.dart';

class LoggedInProfile extends StatefulWidget {
  @override
  _LoggedInProfileState createState() => _LoggedInProfileState();
}

class _LoggedInProfileState extends State<LoggedInProfile> {
  bool _isLoading = false;
  bool _isUploading = false;
  File _profilepic;

  buildfunction() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await getUserInfo();
    } catch (err) {
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    buildfunction();
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      backgroundColor: Color(0xff2f2f2f),
      elevation: 0,
      actions: <Widget>[
        DropdownButton(
          underline: Container(
            height: 0,
          ),
          focusColor: Color(0xff2f2f2f),
          isExpanded: false,
          items: [
            DropdownMenuItem(
              child: Text('Setting'),
              value: 'setting',
            ),
            DropdownMenuItem(
              child: Text('Logout'),
              value: 'logout',
            ),
          ],
          onChanged: (whatwaspressed) async {
            if (whatwaspressed == 'logout') {
              try {
                await _auth.signOut();
                clearUserInfo();
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
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingScreen(),
                ),
              );
            }
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
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
        : SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff2F2F2F),
              appBar: appbar,
              body: Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top -
                            65) /
                        2,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Color(0xff2f2f2f),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: userInfo['profilePic'] == null
                                    ? AssetImage('assets/user.png')
                                    : NetworkImage(
                                        userInfo['profilePic'],
                                      ),
                              ),
                            ),
                            child: Center(
                              child: !_isUploading
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          _isUploading = true;
                                        });
                                        File _image;
                                        try {
                                          _image = await ImagePicker.pickImage(
                                              source: ImageSource.camera,
                                              maxWidth: 800,
                                              maxHeight: 800);
                                          var ref = FirebaseStorage.instance
                                              .ref()
                                              .child('profilePic')
                                              .child(userInfo['userId']
                                                      .toString() +
                                                  '.jpg');
                                          await ref.putFile(_image).onComplete;
                                          var url = await ref.getDownloadURL();
                                          await Firestore.instance
                                              .collection('Users')
                                              .document(userInfo['userId'])
                                              .updateData({
                                            'profilePic': url,
                                          }).then((v) {
                                            userInfo['profilePic'] = url;
                                          });
                                          setState(() {
                                            _profilepic = _image;
                                            _isUploading = false;
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        _isUploading = false;
                                                      });
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: Color(0xffDDA00A),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                        Color(0xff2f2f2f),
                                      ),
                                      strokeWidth: 5,
                                    ),
                            ),
                          ),
                          Text(
                            userInfo['fullname'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@${userInfo['username']}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 20,
                              ),
                              child: Text(
                                '${userInfo['numberofvideos']} Videos',
                                style: TextStyle(
                                  color: Color(0xff2f2f2f),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            color: Color(0xff2f2f2f),
                            elevation: 0,
                            shape: Border.all(
                              width: 2,
                              color: Colors.amber,
                              style: BorderStyle.solid,
                            ),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    userInfo['liked'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Liked',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    userInfo['followers'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    userInfo['following'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top -
                            65) /
                        2,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(48),
                          child: AppBar(
                            backgroundColor: Color(0xff2f2f2f),
                            elevation: 0,
                            bottom: TabBar(
                              indicatorPadding: EdgeInsets.all(0),
                              labelPadding: EdgeInsets.all(0),
                              labelColor: Colors.white,
                              unselectedLabelColor: Color(0xff5D5D5D),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff2f2f2f),
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  color: Color(0xff2f2f2f)),
                              tabs: [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.dashboard),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            HomeScreen(),
                            HomeScreen(),
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
