import 'dart:convert';

import 'package:derma/models/meeting_model.dart';
import 'package:derma/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MeetingDoctorScreen extends StatefulWidget {
  final String id;
  const MeetingDoctorScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<MeetingDoctorScreen> createState() => _MeetingDoctorScreenState();
}

class _MeetingDoctorScreenState extends State<MeetingDoctorScreen> {
  bool is_wait = false;
  String hostRoomURL = "";
  String roomUrl = "";
  List<MeetingModel> meetingList = [];
  Future<void> getMeeting(
      BuildContext context,
      ) async {
    is_wait = true;
    setState(() {});
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Meeting/Get Meeting Information?Id=${widget.id}&IsDoctor=true');
    final response = await http.get(
      url,
      // body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonData = jsonDecode(response.body);
      meetingList =
          jsonData.map((item) => MeetingModel.fromJson(item)).toList();
      // print(jsonResponse.toString());
      // hostRoomURL = jsonResponse['hostRoomURL'];
      // roomUrl = jsonResponse['roomUrl'];
      setState(() {});
      // print('Patient ID: $patientId');

      setState(() {
        is_wait = false;
      });
      // if (patientId != null) {
      showToast(msg: "Success Get Meeting", state: ToastStates.SUCCESS);

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
    getMeeting(
      context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "All appointments dates",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(63, 59, 108, 1),
            fontFamily: 'poe',
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
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
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
      body:     is_wait?Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(meetingList.length, (index) {
              return Container(
                width: size.width * 0.95,
                height: 160,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: ()async{
                          await launchUrl(Uri.parse(meetingList[index].patientLink??""));
                        },
                        child: SizedBox(
                          height: 70,
                          child: Text(
                            "Click here to go to your meeting",
                            style: TextStyle(
                              color: Color(0xFF454571),
                              fontFamily: 'Releway',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(159, 115, 171, 1),
                                Color.fromRGBO(159, 115, 171, 1),
                              ],
                            ),
                          ),
                          child:  Text(
                            meetingList[index].doctorId.toString()??"",
                            // 'Dr/Ahmed Ali',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 80,
                        //   height: 25,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     gradient: const LinearGradient(
                        //       colors: [
                        //         Color.fromRGBO(159, 115, 171, 1),
                        //         Color.fromRGBO(159, 115, 171, 1),
                        //       ],
                        //     ),
                        //   ),
                        //   child: const Text(
                        //     '2:30',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //       fontFamily: 'Raleway',
                        //       fontWeight: FontWeight.w700,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          width: 160,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(159, 115, 171, 1),
                                Color.fromRGBO(159, 115, 171, 1),
                              ],
                            ),
                          ),
                          child:  Text(
                            meetingList[index].date??"",
                            //'12/7/2024',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
