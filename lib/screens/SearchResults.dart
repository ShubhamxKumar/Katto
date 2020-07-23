import 'package:flutter/material.dart';
import 'package:katto/screens/HomeScreen.dart';
import 'package:katto/screens/SearchedUsers.dart';

class SearchedResults extends StatefulWidget {
  final String value;
  SearchedResults({this.value});
  @override
  _SearchedResultsState createState() => _SearchedResultsState();
}

class _SearchedResultsState extends State<SearchedResults> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2f2f2f),
          title: Text(
            'Searched Results',
            style: TextStyle(
              color: Color(0xffDDA00A),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffDDA00A),
            ),
            onPressed: () {},
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: AppBar(
                  backgroundColor: Color(0xff2f2f2f),
                  elevation: 0,
                  bottom: TabBar(
                    indicatorPadding: EdgeInsets.all(0),
                    labelPadding: EdgeInsets.all(0),
                    labelColor: Color(0xffDDA00A),
                    unselectedLabelColor: Color(0xff5D5D5D),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Color(0xffDDA00A),
                        ),
                      ),
                      color: Color(0xff2f2f2f),
                    ),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Users'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Videos'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Sounds'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  SearchedUsers(
                    value: widget.value,
                  ),
                  HomeScreen(),
                  HomeScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
