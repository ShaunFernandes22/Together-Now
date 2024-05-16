import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:together_now_ipd/Screens/get_started.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: IntroductionScreen(
          animationDuration: 400,
          safeAreaList: const [true, true, true, true],
          // scrollPhysics: const NeverScrollableScrollPhysics(),
          globalBackgroundColor: Colors.black,
          pages: [
            PageViewModel(
              title: '',
              bodyWidget: buildBodyWidget(
                  context, AppLocalizations.of(context)!.onboard1_text, width),
              image: buildImage("assets/Onboarding1.png", width),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '',
              bodyWidget: buildBodyWidget(
                  context, AppLocalizations.of(context)!.onboard2_text, width),
              image: buildImage("assets/Onboarding2.png", width),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '',
              bodyWidget: buildBodyWidget(
                  context, AppLocalizations.of(context)!.onboard3_text, width),
              image: buildImage("assets/Onboarding1.png", width),
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () => onDone(context),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          skip: Text(AppLocalizations.of(context)!.skip,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18)),
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
          done: Text(AppLocalizations.of(context)!.next,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18)),
          dotsDecorator: getDotsDecorator(),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  // Widget to add the image on screen
  Widget buildImage(String imagePath, double width) {
    return Container(
      width: width,
      height: 380, // Adjusted height
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill, // Changed to contain to maintain aspect ratio
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  // Custom body widget with Flexible/Expanded to handle text size
  Widget buildBodyWidget(BuildContext context, String text, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: width * 0.8, // Adjusted width
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // Method to customize the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imageFlex: 3,
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.topCenter,
      titlePadding: EdgeInsets.all(0),
      pageColor: Colors.black,
      bodyFlex: 2,
      bodyPadding: EdgeInsets.all(12.0),
      bodyAlignment: Alignment.topCenter,
      bodyTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      activeColor: Colors.white,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}

void onDone(context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const GetStarted()),
  );
}
