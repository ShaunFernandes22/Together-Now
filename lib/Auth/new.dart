import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = "", password = "";
  bool hidden = true;
  String? name;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
        key: formKey,
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 210, 214, 208),
                    Color.fromARGB(255, 191, 214, 162),
                  ]),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: SingleChildScrollView(
                  child: Column(children: [
                    Center(
                      child: Image.asset(
                        'assets/splash_icon.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: const Text(
                          "Together Now.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 26, 36, 21),
                              fontSize: 50.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: "productSansReg"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Text(
                      "Welcome to the community.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "productSansReg"),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(padding: EdgeInsets.all(60.0)),
                    Container(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(13),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                      fontFamily: "productSansReg"),
                                  errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "productSansReg"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide.none)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) {
                                if (email != null &&
                                    !EmailValidator.validate(email)) {
                                  return 'Please enter a Valid Email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              onSaved: (value) {
                                email = value!;
                              },
                            ),
                            const Padding(padding: EdgeInsets.all(10.0)),
                            TextFormField(
                              obscureText: hidden,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontFamily: "productSansReg"),
                                errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "productSansReg"),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      hidden = !hidden;
                                    });
                                  },
                                  child: Icon(
                                    !hidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide.none),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                } else if (value.length < 6) {
                                  return "Enter minimum six characters";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              onSaved: (value) {
                                password = value!;
                              },
                            ),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (30.0 / 804),
                            ),
                            SizedBox(
                                width: 135.0,
                                height: 40.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(255, 94, 126, 96),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ))),
                                  onPressed: () async {},
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontFamily: "productSansReg"),
                                  ),
                                )),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (30.0 / 804),
                            ),
                            GestureDetector(
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "productSansReg"),
                              ),
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         const ForgotPassWord()));
                              },
                            ),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (150.0 / 804),
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      "Haven't yet made an account? Click here to ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "productSansReg"),
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const SignUp()));
                                          },
                                        text: "Sign Up.",
                                        style: const TextStyle(
                                            fontFamily: "productSansReg",
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color.fromARGB(
                                                255, 116, 159, 110)))
                                  ]),
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
