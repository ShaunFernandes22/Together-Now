import 'package:flutter/material.dart';
// import 'package:together_now_ipd/Screens/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:together_now_ipd/Models/user_state.dart';
import 'package:together_now_ipd/homepage.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await DefaultFirebaseOptions().getKeys();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChoiceStateProvider()),
      ],
      child: const MaterialApp(
        title: 'Together Now',
        // theme: ThemeData.dark().copyWith(
        //     // primaryColor: Colors.blueGrey[900],
        //     // scaffoldBackgroundColor: Colors.blueGrey[900],
        //     ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
