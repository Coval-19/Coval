import 'package:coval/home/map_page.dart';
import 'package:coval/home/user_profile.dart';
import 'package:coval/home/welcome_page.dart';
import 'package:flutter/material.dart';

import 'businesses/businesses_list.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    WelcomePage(),
    BusinessesList(),
    MapPage(),
    UserProfile()
  ];

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
              backgroundColor: Color(4278501120),
              icon: Icon(Icons.home),
              title: Text("Home")),
          new BottomNavigationBarItem(
              backgroundColor: Color(4278501120),
              icon: Icon(Icons.search),
              title: Text("Search")),
          new BottomNavigationBarItem(
              backgroundColor: Color(4278501120),
              icon: Icon(Icons.map),
              title: Text("Map")),
          new BottomNavigationBarItem(
              backgroundColor: Color(4278501120),
              icon: Icon(Icons.person),
              title: Text("Profile"))
        ],
      ),
    );
  }
}
