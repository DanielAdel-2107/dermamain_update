import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Doctors/SignupDoctor.dart';
import '../Patients/SignupPatient.dart';


class PatiantPage extends StatelessWidget {
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
            top: 200,
            right: 30,
            child: Container(
              width: 350,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/DOP.png'),
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
                    child: Center(
                      child: Text(
                        "Are You?".tr(),
                        style: const TextStyle(
                          color: Color(0xFF9F73AB),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 400), // Adjusted height for buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.only(right: 10),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPatient()),
                            );
                          },
                          child: Text(
                            "Patient".tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      Text(
                        "or".tr(),
                        style: const TextStyle(
                          color: Color(0xFF9F73AB),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.only(left: 10),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpDoctor()),
                            );
                          },
                          child: Text(
                            "Doctor".tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
