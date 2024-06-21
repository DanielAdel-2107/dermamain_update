import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'AccountPageDoctor.dart';
import 'LoginDoctor.dart';

class EditProfileDoctor extends StatefulWidget {
  final LocalStorage localStorage;

  EditProfileDoctor({required this.localStorage});

  @override
  _EditProfileDoctorState createState() => _EditProfileDoctorState();
}

class _EditProfileDoctorState extends State<EditProfileDoctor> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;
  XFile? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    Map<String, String> profileData = await widget.localStorage.getProfileDataDoctor();
    setState(() {
      nameController.text = profileData['name'] ?? '';
      emailController.text = profileData['email'] ?? '';
      passwordController.text = profileData['password'] ?? '';
      phoneController.text = profileData['phone'] ?? '';
      addressController.text = profileData['address'] ?? '';
      descriptionController.text = profileData['description'] ?? '';
      if (profileData['image'] != null) {
        _image = XFile(profileData['image']!);
      }
    });
  }

  Future<void> selectProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> saveProfile() async {
    String? doctorId = await widget.localStorage.getLoginId();
    final url = Uri.parse('http://dermdiag.somee.com/api/Doctors/EditProfileDoctor?doctorId=$doctorId');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': doctorId,
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'fees': 0,
        'description': descriptionController.text,
        'image': _image != null ? base64Encode(await File(_image!.path).readAsBytes()) : '',
      }),
    );


    if (response.statusCode == 200) {
      print('Profile updated successfully'.tr());
      await widget.localStorage.saveProfileDataDoctor({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'description': descriptionController.text,
        'image': _image != null ? _image!.path : '',
      });


      Map<String, String> storedData = await widget.localStorage.getProfileDataDoctor();
      print('Stored Data: $storedData');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountPageDoctor()),
      );
    } else {
      print('Failed to update profile. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(69, 69, 113, 1),
        title:  Text(
          'Edit Profile'.tr(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPageDoctor()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    backgroundImage: _image != null ? FileImage(File(_image!.path)) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: selectProfileImage,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: nameController,
              decoration:  InputDecoration(
                labelText: 'Name'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration:  InputDecoration(
                labelText: 'Email'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              decoration:  InputDecoration(
                labelText: 'Password'.tr(),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: phoneController,
              decoration:  InputDecoration(
                labelText: 'Phone'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: addressController,
              decoration:  InputDecoration(
                labelText: 'Address'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: descriptionController,
              decoration:  InputDecoration(
                labelText: 'Description'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(69, 69, 113, 1)),
                  ),
                  child:  Text('Cancel'.tr(), style: const TextStyle(color: Colors.white)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: saveProfile,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(69, 69, 113, 1)),
                  ),
                  child:  Text('Save'.tr(), style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
