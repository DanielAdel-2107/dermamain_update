import 'dart:convert';
import 'package:derma/Doctors/root_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'LoginDoctor.dart';
import 'package:http/http.dart' as http;

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SignUpDoctor(),
//   ),
// );

class SignUpDoctor extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  Future<void> registertry(BuildContext context) async {
    final url = 'http://dermdiag.somee.com/api/Doctors/RegisterDoctor';
    final Map<String, dynamic> data = {
      'name': fullnameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'gender': genderController.text,
      'address': addressController.text,
      'description': descriptionController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RootPage()),
        );
      } else {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:  Text('Error'.tr()),
            content:  Text('Failed to sign up. Please try again later.'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:  Text('OK'.tr()),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e'.tr());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text('Error'.tr()),
          content:  Text('Failed to sign up. Please check your internet connection and try again.'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text('OK'.tr()),
            ),
          ],
        ),
      );
    }
  }



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
                image: AssetImage('assets/images/BackGround .png'),
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
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 110),
                  Container(
                    margin: const EdgeInsets.only(bottom: 1),
                    child:  Center(
                      child: Text(
                        "Create an account".tr(),
                        style: const TextStyle(
                          color: Color(0xFF9F73AB),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: fullnameController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.person, color: Color.fromRGBO(98, 79, 130, 1)),
                                    hintText: "Full Name".tr(),
                                    hintStyle: const TextStyle(color: Color.fromRGBO(98, 79, 130, 1)),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your full name'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.email),
                                    hintText: "Email".tr(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email'.tr();
                                    } else if (!value.contains('@gmail.com'.tr())) {
                                      return 'Please enter a valid Gmail address'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: phoneController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.phone),
                                    hintText: "Phone Number".tr(),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number'.tr();
                                    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                                      return 'Phone number must contain 11 digits'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: descriptionController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.description, color: Color.fromRGBO(98, 79, 130, 1)),
                                    hintText: "Description".tr(),
                                    hintStyle: const TextStyle(color: Color.fromRGBO(98, 79, 130, 1)),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your description'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: genderController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.people),
                                    hintText: "Gender".tr(),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your gender'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: addressController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.location_on),
                                    hintText: "Clinic address".tr(),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your location'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration:  InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: "Password".tr(),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password'.tr();
                                    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{8,}$').hasMatch(value)) {
                                      return 'Password must contain at least 8 characters, one uppercase letter, at least two digits, and at least one special character'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF9F73AB)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(

                                  decoration:   InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: "Confirm Password".tr(),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password'.tr();
                                    } else if (value != passwordController.text) {
                                      return 'Passwords do not match'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

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
                              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                                registertry(context);
                              }
                            },
                            child:  Text(
                              "Sign Up".tr(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              "Already have an account?".tr(),
                              style: const TextStyle(color: Color.fromRGBO(63, 59, 108, 1), fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginDoctor()),
                                );
                              },


                              child:  Text(
                                "LOGIN".tr(),
                                style: const TextStyle(color: Color(0xFF9F73AB), fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
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
