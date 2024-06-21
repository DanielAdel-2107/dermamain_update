import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:derma/ratenotification.dart';



class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Review'.tr()),
        backgroundColor: const Color.fromRGBO(69, 69, 113, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                     Text(
                      'Rate your experience:'.tr(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9F73AB),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 40.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
               Center(
                child: Text(
                  'Would you like to add feedback?'.tr(),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9F73AB),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                maxLines: 3,
                decoration:  InputDecoration(
                  hintText: 'Enter your feedback...'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the review dialog
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const RatingNotification(4.5)),
                      );                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),

                    child:  Text('Submit'.tr()),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for cancelling the review
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(69, 69, 113, 1),
                      ),
                    ),
                    child:  Text('Cancel'.tr()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

