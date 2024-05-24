import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String accSID = dotenv.get("ACCOUNT_SID", fallback: "");
String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
String twilioNo = dotenv.get("TWILIO_NO", fallback: "");
String phoneNo = dotenv.get("PHONE_NO", fallback: "");

class Warning extends StatefulWidget {
  const Warning({super.key});

  @override
  State<Warning> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  bool isSOSPressed = false;
  Color backgt = Colors.grey;

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
              shape: const CircleBorder(),
              backgroundColor: backgt,
              padding: const EdgeInsets.all(80),
            ),
            child: const Text('SOS',
                style: TextStyle(fontSize: 24, color: Colors.white)),
            onPressed: () {
              // Your SOS functionality here
              showConfirmationDialog(context);
            },
          ),
        ],
      )),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmation),
          content: Text(AppLocalizations.of(context)!.warning_alert),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  backgt = Colors.red;
                });
                // handleAlert(context);
              },
              child: Text(AppLocalizations.of(context)!.yes),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleAlert(BuildContext context) async {
    final TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: accSID,
      authToken: authToken,
      twilioNumber: twilioNo,
    );

    String kinName = "Varun";
    String locationLandmark =
        "Dwarkadas J. Sanghvi College of Engineering, Vile Parle West, Mumbai Maharashtra 400056, India";
        
    String alertMessage = """
    Dear $kinName, 

    This is an automated alert from TogetherNow, the app your loved one Ramesh is using. They have pressed the SOS button indicating that they might not be feeling safe.
    
    Location: $locationLandmark

    Please reach out to them at your earliest convenience to ensure their safety and well being.

    Thank you,
    TogetherNow Team
    """;

    await twilioFlutter.sendSMS(toNumber: phoneNo, messageBody: alertMessage);
  }
}
