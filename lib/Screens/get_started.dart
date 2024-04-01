import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:together_now_ipd/Models/user_state.dart';
import 'package:together_now_ipd/Screens/login_signup/create_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/LogoText.png',
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                scale: 1.5,
              ),
              const ChoiceButton(
                choice: 'volunteer',
                index: 0,
                buttonText: 'People who want to help',
                horizontalPadding: 11.0,
              ),
              const SizedBox(
                height: 20,
              ),
              const ChoiceButton(
                choice: 'seeker',
                index: 1,
                buttonText: 'People who need help',
              ),
              const SizedBox(
                height: 60,
              ),
              StartedButton(),
            ],
          )),
        ));
  }
}

class ChoiceButton extends StatelessWidget {
  final String buttonText;
  final String choice;
  final int index;
  final double horizontalPadding;
  const ChoiceButton({
    Key? key,
    required this.buttonText,
    required this.choice,
    required this.index,
    this.horizontalPadding = 22.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceStateProvider = Provider.of<ChoiceStateProvider>(context);
    bool isSelected = index == choiceStateProvider.selectedIndex;

    return TextButton(
      onPressed: () {
        choiceStateProvider.selectButton(index, choice);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Palette.borderColor : Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 17.0,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Palette.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}

class StartedButton extends StatefulWidget {
  const StartedButton({Key? key}) : super(key: key);

  @override
  _StartedButtonState createState() => _StartedButtonState();
}

class _StartedButtonState extends State<StartedButton> {
  bool isPressed = false;

  Future<void> _saveChoice(String choice) async {
    // Save choice to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userChoice', choice);
  }

  @override
  void dispose() {
    // Reset the isPressed state to false when the widget is disposed
    super.initState();
    isPressed = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedChoice =
        Provider.of<ChoiceStateProvider>(context).selectedChoice;

    return ElevatedButton(
      onPressed: () => {
        if (selectedChoice != '')
          {
            setState(() {
              isPressed = true;
            }),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateAccount(choice: selectedChoice))).then((_) {
              // This function will be called when navigating back from the CreateAccount screen
              setState(() {
                isPressed = false; // Reset the isPressed state to false
              });
            }),
            _saveChoice(selectedChoice),
          },
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(300, 55),
          backgroundColor:
              isPressed ? Palette.startBorderColor : Colors.transparent,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Palette.startBorderColor, width: 2),
              borderRadius: BorderRadius.circular(10))),
      child: Text(
        'Get Started',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: isPressed ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class Palette {
  static const Color borderColor = Color(0xFF4FC0D0);
  static const Color startBorderColor = Color(0xFFA2FF86);
}
