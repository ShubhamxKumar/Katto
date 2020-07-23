import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:katto/widgets/SearchedUserTile.dart';

class SearchedUsers extends StatefulWidget {
  final String value;
  SearchedUsers({this.value});
  @override
  _SearchedUsersState createState() => _SearchedUsersState();
}

class _SearchedUsersState extends State<SearchedUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
        body: StreamBuilder(
          builder: (context, sdata) {
            if (sdata.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffDDA00A),
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xff2f2f2f),
                  ),
                  strokeWidth: 5,
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                if (sdata.data.documents[index]['username']
                        .contains(widget.value) ||
                    sdata.data.documents[index]['fullname']
                        .contains(widget.value)) {
                  return SearchedUserTile(
                    name: sdata.data.documents[index]['fullname'],
                    photo: sdata.data.documents[index]['profilePic'],
                    videos: sdata.data.documents[index]['videos'].length,
                  );
                } else {
                  return Container();
                }
              },
              itemCount: sdata.data.documents.length,
            );
          },
          stream: Firestore.instance.collection('Users').snapshots(),
        ),
      ),
    );
  }
}
