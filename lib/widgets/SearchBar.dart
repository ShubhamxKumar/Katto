import 'package:flutter/material.dart';
import 'package:katto/screens/SearchResults.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchval = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xff2f2f2f),
      ),
      height: appbar.preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchval,
              cursorColor: Colors.black.withOpacity(.5),
              style: TextStyle(
                color: Colors.black.withOpacity(.5),
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(40),
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black.withOpacity(.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (_searchval.text == '') {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter a value.'),
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
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchedResults(
                      value: _searchval.text.trim(),
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Search',
              style: TextStyle(
                color: Color(0xffDDA00A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
