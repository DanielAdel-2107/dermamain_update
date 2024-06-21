import 'dart:convert';

import 'package:derma/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
class MeetingPatientScreen extends StatefulWidget {
  const MeetingPatientScreen({Key? key}) : super(key: key);

  @override
  State<MeetingPatientScreen> createState() => _MeetingPatientScreenState();
}

class _MeetingPatientScreenState extends State<MeetingPatientScreen> {
  bool is_wait = false;
  String hostRoomURL = "";
  String roomUrl = "";
  Future<void> getMeeting(
      BuildContext context,) async {
    is_wait = true;
    setState(() {});
    final url = Uri.parse('http://dermdiag.somee.com/api/Meeting/CreateMeeting?date=2024-06-30T08%3A02%3A02.039Z');
    final response = await http.get(
      url,
      // body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
       hostRoomURL = jsonResponse['hostRoomURL'];
       roomUrl = jsonResponse['roomUrl'];
       setState(() {});
      // print('Patient ID: $patientId');

      setState(() {
        is_wait = false;
      });
      // if (patientId != null) {
      showToast(
          msg: "Success Get Meeting",
          state: ToastStates.SUCCESS);


      // }
    } else {
      showToast(msg: "error try again", state: ToastStates.ERROR);
      setState(() {
        is_wait = false;
      });
    }
    setState(() {
      is_wait = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMeeting(context, );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:is_wait?Center(child: CircularProgressIndicator(),): Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(hostRoomURL)),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(roomUrl)),
              ],
            ),
          ),


        ],),
      ),
    );
  }
}
