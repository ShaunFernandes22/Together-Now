import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Import any other necessary Firebase packages, such as firebase_auth if needed.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(() as Widget);
}

class Warning extends StatelessWidget {
  Warning({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safety App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafetyPage(),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are you sure you want to send an alert?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                handleAlert();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isSOSPressed = false;
                });
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  void handleAlert() {
    // Your logic to send a signal to the backend
    // print("Sending alert to backend");
    sendPostRequest(context);
  }

  final apiUrl = Uri.parse(
      'https://5bb8-2401-4900-1c94-6969-cc28-3204-a9b-f0f4.ngrok-free.app/send-sms/');
  Future<void> sendPostRequest(BuildContext context) async {
    var response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"number": "+919819971058"}));}

    // convert json obj
    // return {"status": "Message sent successfully", "message_id": message.sid}

    if (response.statusCode == 201) {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("Post created successfully!"),
      // ));
      print("Success");
    } else {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("Failed to create post!"),
      // ));
      print("Fail");
    }
    // (response);
  }
  // if (response.statusCode == 201) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text("Post created successfully!"),
  //   ));
  // } else {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text("Failed to create post!"),
  //   ));
  // }


class SafetyPage extends StatefulWidget {
  const SafetyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SafetyPageState createState() => _SafetyPageState();
}

class _SafetyPageState extends State<SafetyPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isRegistering = false;

  void registerPhoneNumber() async {
    setState(() {
      _isRegistering = true;
    });
    // Here you would usually add some validation for the phone number
    final String phoneNumber = _phoneController.text;

    // Add the phone number to Firebase - example uses Firestore
    await FirebaseFirestore.instance.collection('phoneNumbers').add({
      'number': phoneNumber,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Now, you can call your API to send an SMS to the phoneNumber
    // Replace this print statement with your API call
    print('An SMS will be sent to $phoneNumber');

    setState(() {
      _isRegistering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: Colors.grey,
                padding: const EdgeInsets.all(80),
              ),
              child: const Text('SOS', style: TextStyle(fontSize: 24, color: Colors.white)),
              onPressed: () {
                // Your SOS functionality here
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
              ),
              child: const Text('Inform Kin'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Enter phone number',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          if (_isRegistering)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              onPressed: registerPhoneNumber,
                              child: const Text('Register & Send SMS'),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // ... other buttons ...
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
