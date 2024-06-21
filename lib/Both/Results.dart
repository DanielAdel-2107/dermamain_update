import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:derma/Both/Questions.dart';

class Results extends StatefulWidget {
  const Results({
    Key? key,
    required this.title,
    required this.images,
    required this.predictions,
  }) : super(key: key);

  final String title;
  final List<File> images; // List of images received from TakeImages
  final List<dynamic> predictions; // Response/predictions received from API

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Questions(
                        title: 'Questions', // Example title
                        images: widget.images, // Pass the images to Questions
                        predictions:
                            widget.predictions, // Pass predictions to Questions
                      ),
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
              Text(
                'result',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle drawer opening logic here
                },
                icon: Icon(
                  Icons
                      .menu, // Adjust icon as needed (e.g., Icons.menu for drawer)
                  size: 20,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(4),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Circles and numbers with increased border width
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Personalize', // Text outside of the positioned widgets
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue, // Adjusted color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Positioned widgets for circles and numbers
                  Stack(
                    children: [
                      Container(
                        width: 243,
                        height: 6, // Increased border width
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                          border: Border.all(
                            color: Color(0x8A919191), // Border color
                            width: 6, // Border width
                          ),
                        ),
                      ),
                      Positioned(
                        left: 66,
                        top: 69,
                        child: Container(
                          width: 31,
                          height: 31,
                          decoration: BoxDecoration(
                            color: Color(0xFF454571),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
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
                          decoration: BoxDecoration(
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
                          decoration: BoxDecoration(
                            color: Color(0xFF454571),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 150,
                        top: 77,
                        child: Text(
                          '2.0%', // Adjusted format to include percentage
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            height: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 221,
                        top: 77,
                        child: Text(
                          '3.0%', // Adjusted format to include percentage
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
                          decoration: BoxDecoration(
                            color: Color(0xFFB9B9B9),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 291,
                        top: 77,
                        child: Text(
                          '4.0%', // Adjusted format to include percentage
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF454571),
                            fontFamily: 'Raleway',
                            height: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Display three images in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(widget.images[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Your personalized skin analysis result',
              style: TextStyle(
                fontSize: 18, // Adjusted font size
                color: Colors.blue, // Adjusted color
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Container for personalized skin analysis result
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20), // Adjusted padding
              constraints: BoxConstraints(
                maxHeight: 200, // Adjusted maximum height for scrollability
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2, // Border width
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    for (int i = 0; i < widget.predictions.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${widget.predictions[i]}%', // Display prediction
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 38,
              width: 310,
              margin: const EdgeInsets.only(top: 20),
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
                  // Implement navigation or action on button press
                },
                child: Text(
                  "Choose a doctor".tr(),
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
      ),
    );
  }
}
