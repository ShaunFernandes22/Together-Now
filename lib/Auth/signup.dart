import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_now_ipd/Auth/login.dart';
import 'package:together_now_ipd/Models/utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email == "" || password == "" || confirmPassword == "") {
      log("Please fill all the details!");
      Utils.showErrorDialog(context, "Please fill all the details!");
    } else if (password != confirmPassword) {
      log("Passwords do not match!");
      Utils.showErrorDialog(context, "Passwords do not match!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        log("User created!");
        if (context.mounted) {
          Utils.showAccountCreatedSnackbar(context);
        }
        if (userCredential.user != null) {
          if (context.mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        if (context.mounted) {
          Utils.showErrorDialog(context, ex.code.toString());
        }
      }
    }
  }

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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Image.asset(
                  'assets/splash_icon.png',
                  width: 120,
                  height: 120,
                ),
              ),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: const Text(
                        "Create an account, It's free",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 104, 103, 103),
                        ),
                      )),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: makeInput(
                          label: "Full Name", controller: nameController)),
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
                  FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Confirm Password",
                          obscureText: true,
                          controller: confirmPasswordController)),
                ],
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
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
                        createAccount();
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  )),
              FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(" Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                            selectionColor: Colors.grey),
                      ),
                    ],
                  )),
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
