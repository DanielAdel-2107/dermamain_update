import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Questions.dart';
import 'SelectPart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://adc9-41-46-32-180.ngrok-free.app/predict';

  Future<Map<String, dynamic>> uploadImages(List<File> imageFiles) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    for (var imageFile in imageFiles) {
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return jsonDecode(responseData);
    } else {
      throw Exception('Failed to upload images');
    }
  }
}

class TakeImages extends StatefulWidget {
  const TakeImages({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TakeImages> createState() => _TakeImagesState();
}

class _TakeImagesState extends State<TakeImages> {
  List<File?> images = List.filled(3, null);

  @override
  Widget build(BuildContext context) {
    Future<void> _uploadImagesAndNavigate() async {
      try {
        // Check if there are any null images
        if (images.any((image) => image == null)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Please select all 3 images."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          return; // Exit function if there are null images
        }

        // Filter out null images
        // var result = await ApiService()
        //     .uploadImages(images.map((file) => file!).toList());

        // Navigate to Questions screen with images and predictions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Questions(
              title: 'Questions',
              images: images.map((file) => file!).toList(),
              predictions: [
                {
                  "class": "vascular lesion",
                  "description":
                      "A type of lesion that is caused by abnormal growth or formation of blood vessels.",
                  "probability": 0.9812672138214111
                },
                {
                  "class": "melanocytic nevi",
                  "description":
                      "Commonly known as moles, these are benign proliferations of melanocytes.",
                  "probability": 0.00467408774420619
                },
                {
                  "class": "basal cell carcinoma",
                  "description":
                      "A type of skin cancer that begins in the basal cells.",
                  "probability": 0.0037888556253165007
                }
              ],
              // result['predictions']
            ),
          ),
        );
      } catch (e) {
        print('Error uploading images and navigating to questions: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to upload images."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    Future<void> _pickImage(ImageSource source) async {
      final XFile? returnImage = await ImagePicker().pickImage(source: source);
      if (returnImage == null) return;

      if (images.contains(null)) {
        final int index = images.indexWhere((image) => image == null);
        setState(() {
          images[index] = File(returnImage.path);
        });
      }
    }

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
                    builder: (_) => const SelectPart(title: ''),
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
            left: 66,
            top: 69,
            child: Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xFF454571),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
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
          Positioned(
            left: 138,
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
            left: 150,
            top: 77,
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
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
          Positioned(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.1,
                    left: MediaQuery.of(context).size.width * 0.35,
                    right: MediaQuery.of(context).size.width * 0.35),
                child: Text('Take Photo'.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(63, 59, 108, 1),
                      fontFamily: 'poe',
                      height: 1.0,
                    )),
              ),
            ],
          ),
          Positioned(
            left: 78,
            top: 394,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF454571),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/camera.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Take'.tr(),
                  style: const TextStyle(
                    color: Color(0xFF9F73AB),
                    fontFamily: 'Raleway',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 222,
            top: 394,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF454571),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1),
                          child: Image.asset(
                            'assets/images/upload.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Upload'.tr(),
                  style: const TextStyle(
                    color: Color(0xFF9F73AB),
                    fontFamily: 'Raleway',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 30,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            margin: const EdgeInsets.only(top: 174),
            child: Text(
              'Submit image'.tr(),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9F73AB),
                fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.start,
            ),
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
              onPressed: images.every((image) => image != null)
                  ? () {
                      _uploadImagesAndNavigate();
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("OoOps!!".tr()),
                            content: Text("enter 3 images".tr()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Ok".tr()),
                              ),
                            ],
                          );
                        },
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
          for (int i = 0; i < images.length; i++)
            Positioned(
              left: 29 + i * 114.0,
              top: 230,
              child: Container(
                width: 94,
                height: 94,
                decoration: BoxDecoration(
                  color: const Color(0xFFC2D9D9D9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF454571),
                  ),
                ),
                child: images[i] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          images[i]!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;

    if (images.contains(null)) {
      final int index = images.indexWhere((image) => image == null);
      setState(() {
        images[index] = File(returnImage.path);
      });
    }
  }
}
