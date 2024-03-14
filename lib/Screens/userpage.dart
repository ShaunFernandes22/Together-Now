import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:together_now_ipd/Models/schedule_status.dart';
// import 'package:together_now_ipd/Models/widgets/bottom_navigation.dart';
import 'package:together_now_ipd/Models/widgets/app_bar.dart';
import 'package:together_now_ipd/Screens/home.dart';
import 'package:together_now_ipd/Screens/search_tab.dart';
import 'package:together_now_ipd/Screens/warning.dart';
import 'package:together_now_ipd/Screens/history.dart';
import 'package:together_now_ipd/Screens/profile.dart';
import 'package:together_now_ipd/Screens/chat.dart';
// import 'package:together_now_ipd/Screens/warning.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  // final screens = const [Home(), SearchNavigate(), Warning()];
  final screens = const [
    Home(),
    SearchNavigate(),
    Warning(),
    History(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavDrawer(),
      // appBar: AppBar(
      //   // title: const Text('My App'),
      //   leading: const CustomAppBar(),
      //   // actions: [
      //   //   IconButton(
      //   //     icon: const Icon(Icons.menu),
      //   //     onPressed: () {
      //   //       // Handle menu icon press
      //   //     },
      //   //   ),
      //   // ],
      // ),
      // appBar: const CustomAppBar(),
      // body: Column(
      //   children: [
      //     const CustomAppBar(),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: TextField(
      //             decoration: InputDecoration(
      //               hintText: ' Search...',
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(30.0),
      //               ),
      //               prefixIcon: const Icon(Icons.search),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 200,
      //         ),
      //         const ScheduleStatus(
      //             // hasAppointments: false, //
      //             // onBookAppointment: () {
      //             //   // Handle booking appointment
      //             // },
      //             ),
      //       ],
      //     ),
      //   ],
      // ),
      body: screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatPage()));
        },
        child: const Icon(Icons.add),
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
