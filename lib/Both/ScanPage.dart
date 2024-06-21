import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:derma/Both/SelectPart.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(

              child: Lottie.asset('assets/animation/todo.json'),

          ),
          Container(
            height: 42,
            width: 310,
            margin: const EdgeInsets.only(bottom: 100,left: 38,right: 35,top: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
                    builder: (_) => const SelectPart(title: ''),
                  ),
                );
              },
              child:  Text(
                "Start".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
