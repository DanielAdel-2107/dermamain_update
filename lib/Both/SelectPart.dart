import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:derma/Both/TakeImages.dart';
import 'package:derma/Doctors/root_page.dart';
import 'package:easy_localization/easy_localization.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(63, 59, 108, 1)),
//       ),
//       home: const SelectPart(title: 'Body Part Selector'),
//     );
//   }
// }

class SelectPart extends StatefulWidget {
  const SelectPart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SelectPart> createState() => _SelectPartState();
}

class _SelectPartState extends State<SelectPart> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RootPage(),
                  ),
                );
              },
              icon: Icon(
                Localizations.localeOf(context).languageCode == 'en'
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 67,
            top: 85,
            child: Container(
              width: 243,
              height: 3,
              decoration: const BoxDecoration(
                color: Color(0x8A919191),
              ),
            ),
          ),
          Positioned(
            left: 138,
            top: 69,
            child: Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xFFB9B9B9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            left: 79,
            top: 77,
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Raleway',
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: 66,
            top: 69,
            child: Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xFF454571),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            left: 79,
            top: 77,
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Raleway',
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: 209,
            top: 69,
            child: Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xFFB9B9B9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            left: 150,
            top: 77,
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF454571),
                fontFamily: 'Raleway',
                height: 1.0,
              ),
            ),
          ),
          const Positioned(
            left: 221,
            top: 77,
            child: Text(
              '3',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF454571),
                fontFamily: 'Raleway',
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            left: 279,
            top: 69,
            child: Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xFFB9B9B9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            left: 291,
            top: 77,
            child: Text(
              '4',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF454571),
                fontFamily: 'Raleway',
                height: 1.0,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0.1),
                child: Text(
                  'Select area'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(63, 59, 108, 1),
                    fontFamily: 'poe',
                    height: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Transform.scale(
                    scale: 0.65,
                    child: BodyPartSelectorTurnable(
                      bodyParts: _bodyParts,
                      onSelectionUpdated: (p) => setState(() => _bodyParts = p),
                      labelData: RotationStageLabelData(
                        front: 'Front'.tr(),
                        left: 'Left'.tr(),
                        right: 'Right'.tr(),
                        back: 'Back'.tr(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 38,
            width: 310,
            margin: const EdgeInsets.only(top: 645, left: 38, right: 38),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(63, 59, 108, 1),
                  Color.fromRGBO(63, 59, 108, 1),
                ],
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TakeImages(title: ''),
                  ),
                );
              },
              child: Text(
                "Continue".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'poe',
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
