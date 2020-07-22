import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:katto/globalData.dart';

class RequestVerificationScreen extends StatefulWidget {
  @override
  _RequestVerificationScreenState createState() =>
      _RequestVerificationScreenState();
}

class _RequestVerificationScreenState extends State<RequestVerificationScreen> {
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _fullname = '';
  File _pickedImage = null;
  void _saveData() {
    FocusScope.of(context)
        .unfocus(); //it will close the soft keyboard on tapping the log in button
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    }
  }

  void _pickimage() async {
    File _image;
    try {
      _image = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
      setState(() {
        _pickedImage = _image;
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
              ),
            ],
          );
        },
      );
    }
  }

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
          'Request Verification',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: Color(0xff2f2f2f),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apply for Katto Verification',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'A verified badge is check that appears next to an katto accounts name to indicate that the account is the authentic presence of notable public figure, celebrity, global brand or entity it represents.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Submitting a request for verification does not guarantee that your account will be verfied.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      initialValue: userInfo['username'],
                      key: ValueKey('username'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || value.contains(' ')) {
                          return 'Username should not contain \'space\' or be empty ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                    TextFormField(
                      initialValue: userInfo['fullname'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      key: ValueKey('fullname'),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fullname = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Apply for Katto Verification',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add Photo'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _pickimage();
                                  },
                                  child: Text('Camera'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        _pickedImage != null ? 'Change Photo' : 'Choose File',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'We require a government-issued photo ID that shows your name and date of birth(e.g driver\'s license, passport or national identification card) or official business documents(tax fillings, recent utility bill, article of incorporation) in order to review your request',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: _saveData,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffE25E14),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
