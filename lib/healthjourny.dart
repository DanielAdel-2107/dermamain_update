import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Text("Login".tr(), style: const TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30)),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color.fromRGBO(196, 135, 198, .3)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3))),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username".tr(),
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password".tr(),
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(child: TextButton(onPressed: () {}, child:  Text("Forgot Password?".tr(), style: const TextStyle(color: Color.fromRGBO(196, 135, 198, 1))))),
                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () {},
                    color: const Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child:  Center(
                      child: Text("Login".tr(), style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(child: TextButton(onPressed: () {}, child:  Text("Create Account".tr(), style: const TextStyle(color: Color.fromRGBO(49, 39, 79, .6))))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
