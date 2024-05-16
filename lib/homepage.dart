import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:together_now_ipd/Screens/userpage.dart';
import 'package:together_now_ipd/language/choose_language.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error occured!"),
            );
          } else if (snapshot.hasData) {
            return const UserPage();
          } else {
            // return const IntroductionScreens();
            return const SelectLanguageDropdown();
          }
        });
  }
}
