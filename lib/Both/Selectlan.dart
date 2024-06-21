import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:derma/Both/pateintordoctor.dart';


class Selectlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/MainBackGround.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Positioned(
            right: 20,
            top: 20,
            child: Text(
              "DermDiag",
              style: TextStyle(
                color: Color.fromRGBO(69, 69, 113, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 20,
            child: Container(
              width: 60,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/LOGO.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: 10,
            child: Container(
              width: 350,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/7.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Center(
                      child: Text(
                        "Select Language",
                        style: TextStyle(
                          color: Color(0xFF9F73AB),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 400),
                  Container(
                    height: 50,
                    width: 350,
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
                        EasyLocalization.of(context)!.setLocale(const Locale('ar'));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>PatiantPage()),
                        );
                      },
                      child: const Text(
                        "اللغة العربية",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: 350,
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
                        EasyLocalization.of(context)!.setLocale(const Locale('en'));

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PatiantPage()),
                        );
                      },
                      child: const Text(
                        "Continue with English",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
