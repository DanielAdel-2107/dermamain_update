import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:derma/Patients/EditproPatient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'LoginPatient.dart';



class AccountPagePatient extends StatelessWidget {
  final Local _localStorage2 = Local(const FlutterSecureStorage());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(69, 69, 113, 1),
          title:  Text(
            'My Account'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/doctor.png'),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Nourhan Ebrahim',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(69, 69, 113, 1)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePatient(localStorage2: _localStorage2)),
                    );
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(69, 69, 113, 1)),
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Edit Profile'.tr(), style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.contacts, color: Color.fromRGBO(69, 69, 113, 1)),
                    const SizedBox(width: 8),
                    Text('E-call contacts'.tr(), style: const TextStyle(color: Color.fromRGBO(69, 69, 113, 1))),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delete, color: Color.fromRGBO(69, 69, 113, 1)),
                    const SizedBox(width: 8),
                    Text('Delete Account'.tr(), style: const TextStyle(color: Color.fromRGBO(69, 69, 113, 1))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),

                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.history,color: Color.fromRGBO(69, 69, 113, 1)),
                    const SizedBox(width: 8),
                    Text('Patient History'.tr(), style: const TextStyle(color: Color.fromRGBO(69, 69, 113, 1),),
                    )],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language, color: Color.fromRGBO(69, 69, 113, 1)),
                    const SizedBox(width: 8),
                    Text('Language'.tr(), style: const TextStyle(color: Color.fromRGBO(69, 69, 113, 1))),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Center(
                child:ElevatedButton(
                  onPressed: () async {

                    await _localStorage2.deleteAll();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPatient()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(69, 69, 113, 1))),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(69, 69, 113, 1)),
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Logout'.tr(), style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
