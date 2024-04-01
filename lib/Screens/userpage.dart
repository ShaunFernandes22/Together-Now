import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:together_now_ipd/Models/widgets/app_bar.dart';
import 'package:together_now_ipd/Models/widgets/expandable_fab.dart';
import 'package:together_now_ipd/Screens/home.dart';
import 'package:together_now_ipd/Screens/search_tab.dart';
import 'package:together_now_ipd/Screens/warning.dart';
import 'package:together_now_ipd/Screens/history.dart';
import 'package:together_now_ipd/Screens/profile.dart';
import 'package:together_now_ipd/Screens/chat/chat.dart';
import 'package:provider/provider.dart';
import 'package:together_now_ipd/Models/user_state.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  // final screens = [Home(), SearchNavigate(), Warning(), History(), Profile()];
  late List<Widget> volunteerScreens;
  late List<Widget> seekerScreens;

  Future<void> _loadChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load the saved choice from SharedPreferences
    String? choice = prefs.getString('userChoice') ?? '';
    ChoiceStateProvider choiceProvider = ChoiceStateProvider();
    if (choice == 'volunteer') {
      choiceProvider.selectButton(0, choice);
    } else if (choice == 'seeker') {
      choiceProvider.selectButton(1, choice);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadChoice();
    // Initialize screens for 'volunteer' and 'seeker'
    volunteerScreens = [
      Home(),
      SearchNavigate(title: 'Users'),
      Warning(),
      History(),
      Profile()
    ];
    seekerScreens = [
      Home(),
      SearchNavigate(title: "Volunteer"),
      Warning(),
      History(),
      Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    final choiceStateProvider = Provider.of<ChoiceStateProvider>(context);
    final choice = choiceStateProvider.selectedChoice;
    final screens = choice == 'volunteer' ? volunteerScreens : seekerScreens;
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
