import 'package:flutter/material.dart';
import 'package:katto/screens/ExploreScreen.dart';
import 'package:katto/screens/HomeScreen.dart';
import 'package:katto/screens/ProfileScreen.dart';
import 'package:katto/screens/SearchResults.dart';
import 'package:katto/screens/SplashScreen.dart';
import 'package:katto/widgets/BottomNavigationBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  int _selectedScreenIndex = 0;
  void _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      ExploreScreen(),
      HomeScreen(),
      HomeScreen(),
      ProfileScreen(),
    ];
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 65,
          child: BtmNavigationBar(
            onTap: _selectedScreen,
            selectedScreenIndex: _selectedScreenIndex,
          ),
        ),
        body: _screens[_selectedScreenIndex],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
