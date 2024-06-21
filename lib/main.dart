import 'package:derma/Both/TakeImages.dart';
import 'package:derma/Doctors/AccountPageDoctor.dart';
import 'package:derma/Doctors/LoginDoctor.dart';
import 'package:derma/Doctors/MedicationPage.dart';
import 'package:derma/Doctors/root_page.dart';
import 'package:derma/Patients/LoginPatient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:derma/Both/Selectlan.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'ui_Todo/services/db.helper.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/language', // <-- change the path of the translation files
      fallbackLocale: Locale('ar'),
      startLocale: Locale('en'),
      child: MyApp()));
}

class Constants {
  static var primaryColor = const Color(0xFF454571);

  static var titleOne = "t1".tr();
  static var descriptionOne = "d1".tr();
  static var titleTwo = "t2".tr();
  static var descriptionTwo = "d2".tr();
  static var titleThree = "t3".tr();
  static var descriptionThree = "d3".tr();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: TakeImages(title: 'Result'),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              OnboardingPage(
                backgroundImage: 'assets/images/on1.png',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
                centerImage: 'assets/images/wel_on.png',
              ),
              OnboardingPage(
                backgroundImage: 'assets/images/on2.png',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
                centerImage: 'assets/images/doc_on2.png',
              ),
              OnboardingPage(
                backgroundImage: 'assets/images/on3.png',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
                centerImage: 'assets/images/treat_on3.png',
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.primaryColor,
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex++;
                      if (currentIndex < 3) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Selectlan()),
                      );
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Selectlan()),
                );
              },
              child: Text(
                'Skip'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String description;
  final String centerImage;

  const OnboardingPage({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    required this.centerImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.fill,
          alignment: Alignment.topLeft,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 110),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              centerImage,
              height: 230, // Adjust the height as needed
              width: 750, // Adjust the width as needed
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'poe',
                  color: Color(0xFF454571),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF9F73AB),
                  fontFamily: 'poe',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
