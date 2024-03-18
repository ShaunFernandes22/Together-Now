import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:together_now_ipd/homepage.dart';
import 'package:together_now_ipd/Auth/login.dart';
import 'package:together_now_ipd/Auth/signup.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          "Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          "Automatic identity verification which enables you to verify your identity",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        )),
                  ],
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/splash_icon.png'))),
                    )),
                Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: MaterialButton(
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
                          child: const Text(
                            "Login",
                            style: TextStyle(
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
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
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
