import 'package:flutter/material.dart';

class SearchedUserTile extends StatefulWidget {
  final int videos;
  final String name;
  final String photo;
  SearchedUserTile({this.name, this.photo, this.videos});
  @override
  _SearchedUserTileState createState() => _SearchedUserTileState();
}

class _SearchedUserTileState extends State<SearchedUserTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.photo == null
                    ? AssetImage('assets/user.png')
                    : NetworkImage(
                        widget.photo,
                      ),
              ),
            ),
          ),
          Center(
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
              '${widget.videos} Videos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          )
        ],
      ),
    );
  }
}
