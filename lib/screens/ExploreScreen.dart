import 'package:flutter/material.dart';
import 'package:katto/widgets/SearchBar.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      backgroundColor: Color(0xff2f2f2f),
      elevation: 3,
      bottom: PreferredSize(
        child: SearchBar(),
        preferredSize: Size.fromHeight(10),
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
        appBar: appbar,
        body:Container(height: appbar.preferredSize.height,),
      ),
    );
  }
}
