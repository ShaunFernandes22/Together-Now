import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:together_now_ipd/Screens/introduction_screen.dart';
import 'package:together_now_ipd/constants.dart';
import 'package:together_now_ipd/main.dart';

String _languageCode = 'en';

class SelectLanguageDropdown extends StatefulWidget {
  const SelectLanguageDropdown({super.key});

  @override
  State<SelectLanguageDropdown> createState() => _SelectLanguageDropdownState();
}

class _SelectLanguageDropdownState extends State<SelectLanguageDropdown> {
 
  @override
  void initState() {
    super.initState();
    _languageCode = getLang().toString();
  }

  Future<String> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('languageCode') ?? 'en';
    return languageCode;
  }

  String selectedVal = _languageCode;
  // String selectedVal = 'en';
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[900]!,
              Colors.black,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.choose_a_language,
                            style: TextStyle(
                              fontFamily: "productSansReg",
                              color: Colors.cyan[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20 * (height / deviceHeight),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 250 * (height / deviceHeight),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/translation.jpg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedVal,
                            onChanged: (newValue) async {
                              if (newValue != null) {
                                setState(() {
                                  selectedVal = newValue;
                                });
                                Locale newLocale = Locale(newValue);
                                MyApp.setLocale(context, newLocale);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('languageCode', newValue);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: 'en', child: Text('English')),
                              DropdownMenuItem(
                                  value: 'hi', child: Text('हिंदी')),
                              DropdownMenuItem(
                                  value: 'mr', child: Text('मराठी')),
                            ],
                            style: const TextStyle(
                              fontFamily: "productSansReg",
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12),
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.translate,
                                  color: Colors.grey),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20 * (height / deviceHeight),
                        ),
                        SizedBox(
                          width: width * (135.0 / 300),
                          height: height * (40.0 / 704),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const IntroductionScreens()));
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.cyan[500],
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.proceed,
                              style: const TextStyle(
                                fontFamily: "productSansReg",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
