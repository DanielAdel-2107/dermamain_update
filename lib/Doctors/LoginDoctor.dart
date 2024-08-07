import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:derma/Doctors/SignupDoctor.dart';
import '../Patients/RootPatient.dart';

class LoginDoctor extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  final LocalStorage localStorage = LocalStorage(const FlutterSecureStorage());

  Future<void> _loginDoctor(BuildContext context) async {
    final url = Uri.parse('http://dermdiag.somee.com/api/Doctors/LoginDoctor');
    final response = await http.post(
      url,
      body: json.encode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final doctorId = jsonResponse['id'];
      final doctorName = jsonResponse['name'];
      print('Doctor ID: $doctorId');
      print('Doctor Name: $doctorName');
      await localStorage.addLoginId(doctorId.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RootPatient()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'.tr()),
            content: Text('Invalid email or password'.tr()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'.tr()),
              ),
            ],
          );
        },
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
                  const SizedBox(height: 150),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        "Welcome back!".tr(),
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
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF9F73AB)),
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
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email,
                                        color: Color.fromRGBO(98, 79, 130, 1)),
                                    hintText: "Email".tr(),
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(98, 79, 130, 1)),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email'.tr();
                                    } else if (!value
                                        .contains('@gmail.com'.tr())) {
                                      return 'Please enter a valid Gmail address'
                                          .tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF9F73AB)),
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
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Color.fromRGBO(98, 79, 130, 1)),
                                    hintText: "Password".tr(),
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(98, 79, 130, 1)),
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(Icons.visibility,
                                        color: Color.fromRGBO(98, 79, 130, 1)),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password'.tr();
                                    } else if (!RegExp(
                                            r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                        .hasMatch(value)) {
                                      return 'Password must contain at least 1 letter and 1 number'
                                          .tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
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
                              _loginDoctor(context);
                            },
                            child: Text(
                              "LOGIN".tr(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?".tr(),
                              style: const TextStyle(
                                  color: Color.fromRGBO(63, 59, 108, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpDoctor()),
                                );
                              },
                              child: Text(
                                "Sign Up".tr(),
                                style: const TextStyle(
                                    color: Color(0xFF9F73AB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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

class LocalStorage {
  final FlutterSecureStorage _storage;

  LocalStorage(this._storage);

  Future<String?> getLoginId() async {
    return await _storage.read(key: 'id');
  }

  Future<void> addLoginId(String id) async {
    await _storage.write(key: 'id', value: id);
  }

  Future<void> saveProfileDataDoctor(Map<String, String> data) async {
    for (var key in data.keys) {
      await _storage.write(key: key, value: data[key]);
    }
  }

  Future<Map<String, String>> getProfileDataDoctor() async {
    var keys = [
      'name',
      'email',
      'phone',
      'address',
      'description',
      'image',
      'password'
    ];
    Map<String, String> data = {};
    for (var key in keys) {
      var value = await _storage.read(key: key);
      if (value != null) {
        data[key] = value;
      }
    }
    return data;
  }

  Future<String?> getEmailDoctor() async {
    return await _storage.read(key: 'email');
  }

  Future<String?> getPasswordDoctor() async {
    return await _storage.read(key: 'password');
  }

  Future<String?> getLogindoctorName() async {
    return await _storage.read(key: 'name');
  }

  Future<void> addLogindoctorName(String name) async {
    await _storage.write(key: 'name', value: name);
  }
}
