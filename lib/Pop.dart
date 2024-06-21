import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RatedByPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Rated By'.tr()),
        backgroundColor: const Color.fromRGBO(69, 69, 113, 1),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace this with the actual number of users
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Patient ${index + 1}'.tr()),
            subtitle: Row(
              children: [
                 Text('Rating: '.tr()),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text('${(index + 1) * 0.5}'), // Example rating
              ],
            ),
            onTap: () {
              // Add functionality to navigate to user's profile or details
              // You can use Navigator.push to navigate to a new page
            },
          );
        },
      ),
    );
  }
}


