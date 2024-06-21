import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingNotification extends StatelessWidget {
  final double rating;

  const RatingNotification(this.rating);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text('Thank You!'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Thanks for your rating:'.tr()),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          const SizedBox(height: 10),
           Text(
            'Thanks for your rate!'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child:  Text('Close'.tr()),
        ),
      ],
    );
  }
}
