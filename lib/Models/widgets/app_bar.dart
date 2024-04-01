import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_now_ipd/Models/my_notifications.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle notification icon tap
              Scaffold.of(context).openDrawer();
            },
          ),
          Image.asset(
            'assets/splash_icon.png',
            width: 120,
            height: 120,
          ),
          GestureDetector(
            child: const CircleAvatar(
              child: Icon(Icons.account_circle, size: 40, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 50.0),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Handle notifications option
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CustomNotificationScreen(),
                    ));
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Handle sign out option
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            )
          ],
        ),
      );
}
