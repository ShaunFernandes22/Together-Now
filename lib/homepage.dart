import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:together_now_ipd/Auth/new.dart';
import 'package:together_now_ipd/Screens/introduction_screen.dart';
// import 'package:together_now_ipd/Auth/login.dart';
import 'package:together_now_ipd/Screens/userpage.dart';
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   void logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (context.mounted) {
//       Navigator.popUntil(context, (route) => route.isFirst);
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const LoginPage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//             padding: const EdgeInsets.all(32),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Signed in as ",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   user.email!,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 const SizedBox(height: 40),
//                 ElevatedButton.icon(
//                     onPressed: () {
//                       logout();
//                     },
//                     icon: const Icon(Icons.arrow_back, size: 32),
//                     label: const Text(
//                       "Sign Out",
//                       style: TextStyle(fontSize: 16),
//                     ))
//               ],
//             )));
//   }
// }

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
            return const IntroductionScreens();
          }
        });
  }
}
