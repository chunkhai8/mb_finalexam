import 'package:flutter/material.dart';
import 'package:mytutor/favourite.dart';
import 'package:mytutor/profile.dart';
import 'package:mytutor/subjects.dart';
import 'package:mytutor/subscribe.dart';
import 'package:mytutor/tutors.dart';

import 'class def/user.dart';


class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget>tabchildren;
  int _currentIndex = 0;
  String maintitle = "Subjects";

  @override
    void initState() {
      super.initState();
      tabchildren = [
        Subjects(user: widget.user),
        const Tutors(),
        const Subscribe(),
        const Favourite(),
        const Profile(),
      ];
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('My Tutor'),
        // ),
        body:tabchildren[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.lightGreen,
          onTap: onTapTapped,
          currentIndex: _currentIndex,
          selectedIconTheme: const IconThemeData(
            color: Colors.lightGreen,
            opacity: 1.0,
            size: 30.0
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
            opacity: 1.0,
            size: 30.0
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              label: "Subjects",
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label:"Tutors"),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions,),
              label:"Subscribe"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,),
              label:"Favourite"),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp,),
              label:"Profile"),
          ],
        ),
    );
  }

  void onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Subjects";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutors";
      }
      if (_currentIndex == 2) {
        maintitle = "Subscribe";
      }
      if (_currentIndex == 3) {
        maintitle = "Favourite";
      }
      if (_currentIndex == 4) {
        maintitle = "Profile";
      }
    });
  }
}