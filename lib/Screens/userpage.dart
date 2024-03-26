import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:together_now_ipd/Models/widgets/app_bar.dart';
import 'package:together_now_ipd/Models/widgets/expandable_fab.dart';
import 'package:together_now_ipd/Screens/home.dart';
import 'package:together_now_ipd/Screens/search_tab.dart';
import 'package:together_now_ipd/Screens/warning.dart';
import 'package:together_now_ipd/Screens/history.dart';
import 'package:together_now_ipd/Screens/profile.dart';
import 'package:together_now_ipd/Screens/chat/chat.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  final screens = [Home(), SearchNavigate(), Warning(), History(), Profile()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavDrawer(),
      body: screens[_currentIndex],
      floatingActionButton: MyExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            // onPressed: () => _showAction(context, 0),
            onPressed: () {},
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            // onPressed: () => _showAction(context, 1),
            onPressed: () {},
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            // onPressed: () => _showAction(context, 2),
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(MyIcons.warning), label: 'Warning'),
            BottomNavigationBarItem(
                icon: Icon(MyIcons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    ));
  }
}

class MyIcons {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');
  static const IconData history = IconData(0xe314, fontFamily: 'MaterialIcons');
}
