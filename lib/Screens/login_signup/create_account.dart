import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:together_now_ipd/homepage.dart';
import 'package:together_now_ipd/Auth/login.dart';
import 'package:together_now_ipd/Auth/signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAccount extends StatefulWidget {
  // const CreateAccount({super.key});
  final String choice;
  const CreateAccount({required this.choice, Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState(choice: choice);
}

class _CreateAccountState extends State<CreateAccount> {
  final String choice;
  _CreateAccountState({required this.choice});

  @override
  Widget build(BuildContext context) {
    String welcomeMessage = '';

    // Determine the welcome message based on the value of choice
    if (choice == 'volunteer') {
      // welcomeMessage = 'Welcome volunteers';
      welcomeMessage = AppLocalizations.of(context)!.welcome_volunteers;
    } else if (choice == 'seeker') {
      // welcomeMessage = 'Welcome users.';
      welcomeMessage = AppLocalizations.of(context)!.welcome_users;
    }
    print(welcomeMessage);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          "Together Now",
                          style: TextStyle(
                              fontFamily: "productSansReg",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          welcomeMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        )),
                  ],
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/HelpSenior.png'))),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: MaterialButton(
                          color: Colors.yellow,
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          body: StreamBuilder<User?>(
                                              stream: FirebaseAuth.instance
                                                  .authStateChanges(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return const HomePage();
                                                } else {
                                                  return const LoginPage();
                                                }
                                              }),
                                        )));
                          },
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          // padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupPage()));
                            },
                            color: Colors.yellow,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
