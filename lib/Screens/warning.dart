import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Warning extends StatefulWidget {
  const Warning({super.key});

  @override
  State<Warning> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  bool isSOSPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              isSOSPressed = true;
            });
            Future.delayed(const Duration(milliseconds: 200), () {
              showConfirmationDialog();
            });
          },
          child: InkWell(
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSOSPressed ? Colors.white : Colors.red,
                ),
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(
                        color: isSOSPressed ? Colors.red : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              )),
        ),
      ),
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
        body: jsonEncode({"number": "+919819971058"}));

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
}
// }
