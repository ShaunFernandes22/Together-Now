import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_now_ipd/Auth/signup.dart';
import 'package:together_now_ipd/homepage.dart';
import 'package:together_now_ipd/Models/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      log("Please fill all the details!");
      Utils.showErrorDialog(context, "Please fill all the details!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (context.mounted) {
          Utils.showSignInSnackbar(context, true);
        }

        if (userCredential.user != null) {
          if (context.mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomePage()));
          }
        }
      } on FirebaseException catch (ex) {
        log(ex.code.toString());
        if (context.mounted) {
          Utils.showErrorDialog(context, ex.code.toString());
          Utils.showSignInSnackbar(context, false);
        }
      }
    }
  }

  // void showErrorDialog(String errorMessage) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Error'),
  //       content: Text(errorMessage),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void showSignInSnackbar(bool success) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(success ? 'Sign in successful!' : 'Sign in failed.'),
  //       backgroundColor: success ? Colors.green : Colors.red,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Image.asset(
                            'assets/splash_icon.png', // Replace with the path to your logo
                            width: 200, // Adjust the width as needed
                            height: 200, // Adjust the height as needed
                          ),
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: makeInput(
                                  label: "Email", controller: emailController)),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: makeInput(
                                  label: "Password",
                                  obscureText: true,
                                  controller: passwordController)),
                        ],
                      ),
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
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
                                signIn();
                              },
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        )),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ));
                              },
                              child: const Text(
                                " Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
