import 'package:flutter/material.dart';

class BtmNavigationBar extends StatefulWidget {
  final Function onTap;
  final int selectedScreenIndex;
  BtmNavigationBar({this.onTap, this.selectedScreenIndex});
  @override
  _BtmNavigationBarState createState() => _BtmNavigationBarState();
}

class _BtmNavigationBarState extends State<BtmNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Color(0xff2F2F2F),
      selectedItemColor: Color(0xffDDA00A),
      currentIndex: widget.selectedScreenIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: SizedBox.shrink(),
          backgroundColor: Color(0xff2F2F2F),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: SizedBox.shrink(),
          backgroundColor: Color(0xff2F2F2F),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box,
            size: 35,
            color: Color(0xffDDA00A),
          ),
          title: SizedBox.shrink(),
          backgroundColor: Color(0xff2f2f2f),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: SizedBox.shrink(),
          backgroundColor: Color(0xff2F2F2F),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: SizedBox.shrink(),
          backgroundColor: Color(0xff2F2F2F),
        ),
      ],
    );
  }
}
