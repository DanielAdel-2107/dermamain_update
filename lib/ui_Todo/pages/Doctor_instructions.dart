import 'dart:convert';

import 'package:derma/Patients/LoginPatient.dart';
import 'package:derma/Patients/String_text.dart';
import 'package:derma/Patients/yourtask.dart';
import 'package:derma/models/treatment_plan.dart';
import 'package:derma/toast.dart';
import 'package:derma/ui_Todo/services/notification_services.dart';
import 'package:derma/ui_Todo/services/task.controller.dart';
import 'package:derma/ui_Todo/services/task.dart';
import 'package:derma/ui_Todo/widgets/task_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:derma/ui_Todo/pages/Treatment%20plan.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class Doctor_instructions extends StatefulWidget {
  const Doctor_instructions({super.key});

  @override
  State<Doctor_instructions> createState() => _Doctor_instructionsState();
}

class _Doctor_instructionsState extends State<Doctor_instructions> {
  List<Task> filterTaskList = [];
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  bool is_wait = false;
  List<TreatmentPlanModel> treatmentPlanList = [];

  Future<void> getTreatmentPlan(
    BuildContext context,
  ) async {
    String? patientId = await Local(FlutterSecureStorage()).getLoginIdPatient();
    is_wait = true;
    setState(() {});
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Patients/GetTreatmentPlan?doctorId=2&patientId=${patientId}');
    print(url);
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
      treatmentPlanList =
          jsonData.map((item) => TreatmentPlanModel.fromJson(item)).toList();
      print(treatmentPlanList[0].medicineName);
      print(treatmentPlanList[0].frequency);
      print(treatmentPlanList[0].quantity);
      setState(() {});
      // print('Patient ID: $patientId');

      setState(() {
        is_wait = false;
      });
      // if (patientId != null) {
      showToast(msg: "Success Get TreatmentPlan", state: ToastStates.SUCCESS);

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
    super.initState();
    getTreatmentPlan(context);
    filterTaskList = _taskController.taskList;

    notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
    // notifyHelper.requestAndroidPermissions();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF454571),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .2,
                child: Column(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 20,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Text(
                            lookForYourTreatmentPlansAndTasks,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Releway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 20,
                    )),
                  ],
                ),
              ),
              Container(
                height: size.height * .8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        treatmentPlan,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF9F73AB),
                            fontFamily: 'Releway',
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Treatmentplan(
                                    treatmentPlanList: treatmentPlanList,
                                  ),
                                ));
                          },
                          child: Text(
                            seeAll,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9F73AB),
                              fontFamily: 'Releway',
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                        itemCount: treatmentPlanList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width * 0.9,
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.03),
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
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      treatmentPlanList[index].quantity ?? "",
                                      // "3 Times",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF454571),
                                        fontFamily: 'Releway',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Per day",
                                      style: TextStyle(
                                        color: Color(0xFF454571),
                                        fontFamily: 'Releway',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: size.height * 0.1,
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: Text(
                                        treatmentPlanList[index].medicineName ??
                                            "",
                                        // "panadol extra",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF454571),
                                          fontFamily: 'Releway',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: Text(
                                        treatmentPlanList[index].frequency ??
                                            "",
                                        // "For 10 Days",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF454571),
                                          fontFamily: 'Releway',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    // child:SingleChildScrollView(
                    //   scrollDirection: Axis.vertical,
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Column(
                    //     children: List.generate(10, (index) {
                    //       return Container(
                    //         width: size.width * 0.9,
                    //         height: 70,
                    //         margin: const EdgeInsets.only(bottom: 20),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(size.width * 0.03),
                    //           color: Colors.white,
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               spreadRadius: 2,
                    //               blurRadius: 4,
                    //               offset: const Offset(0, 4),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             const SizedBox(width: 20),
                    //             const Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "3 Times",
                    //                   style: TextStyle(
                    //                     fontSize: 20,
                    //                     color: Color(0xFF454571),
                    //                     fontFamily: 'Releway',
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   "Per day",
                    //                   style: TextStyle(
                    //                     color: Color(0xFF454571),
                    //                     fontFamily: 'Releway',
                    //                     fontSize: 15,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(width: 10),
                    //             Container(
                    //               height: size.height * 0.1,
                    //               width: 2,
                    //               color: Colors.grey.shade300,
                    //             ),
                    //             const SizedBox(width: 10),
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 SizedBox(
                    //                   width: size.width * 0.6,
                    //                   child: const Text(
                    //                     "panadol extra",
                    //                     maxLines: 4,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                       fontSize: 20,
                    //                       color: Color(0xFF454571),
                    //                       fontFamily: 'Releway',
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: size.width * 0.6,
                    //                   child: const Text(
                    //                     "For 10 Days",
                    //                     maxLines: 4,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                       fontSize: 15,
                    //                       color: Color(0xFF454571),
                    //                       fontFamily: 'Releway',
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        yourTasks,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF9F73AB),
                            fontFamily: 'Releway',
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ));
                          },
                          child: Text(
                            seeAllAndAdd,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9F73AB),
                              fontFamily: 'Releway',
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Container(
                    height: size.height * 0.26,
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: filterTaskList.length,
                        itemBuilder: (_, index) {
                          Task task =
                              filterTaskList[filterTaskList.length - 1 - index];

                          DateTime date =
                              _parseDateTime(task.startTime.toString());
                          var myTime = DateFormat.Hm().format(date);

                          var remind = DateFormat.Hm().format(
                              date.subtract(Duration(minutes: task.remind!)));

                          int mainTaskNotificationId = task.id!.toInt();
                          int reminderNotificationId =
                              mainTaskNotificationId + 1;

                          if (task.repeat == "Daily") {
                            if (task.remind! > 4) {
                              notifyHelper.remindNotification(
                                int.parse(
                                    remind.toString().split(":")[0]), //hour
                                int.parse(
                                    remind.toString().split(":")[1]), //minute
                                task,
                              );
                              notifyHelper
                                  .cancelNotification(reminderNotificationId);
                            }
                            notifyHelper.scheduledNotification(
                              int.parse(myTime.toString().split(":")[0]), //hour
                              int.parse(
                                  myTime.toString().split(":")[1]), //minute
                              task,
                            );
                            notifyHelper
                                .cancelNotification(reminderNotificationId);

                            if (DateTime.now().hour == 23 &&
                                DateTime.now().minute == 59) {
                              _taskController.markTaskAsCompleted(
                                  task.id!, false);
                            }

                            return Container(
                              width: size.width * 0.4,
                              height: size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task,
                                ),
                              ),
                            );
                          } else if (task.date ==
                              DateFormat('MM/dd/yyyy').format(_selectedDate)) {
                            if (task.remind! > 0) {
                              notifyHelper.remindNotification(
                                int.parse(
                                    remind.toString().split(":")[0]), //hour
                                int.parse(
                                    remind.toString().split(":")[1]), //minute
                                task,
                              );
                              notifyHelper
                                  .cancelNotification(reminderNotificationId);
                            }
                            notifyHelper.scheduledNotification(
                              int.parse(myTime.toString().split(":")[0]), //hour
                              int.parse(
                                  myTime.toString().split(":")[1]), //minute
                              task,
                            );
                            notifyHelper
                                .cancelNotification(reminderNotificationId);

                            return Container(
                              width: size.width * 0.4,
                              height: size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task,
                                ),
                              ),
                            );
                          } else if (task.repeat == "Weekly" &&
                              DateFormat('EEEE').format(_selectedDate) ==
                                  DateFormat('EEEE').format(DateTime.now())) {
                            return Container(
                              width: size.width * 0.4,
                              height: size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task,
                                ),
                              ),
                            );
                          } else if (task.repeat == "Monthly" &&
                              DateFormat('dd').format(_selectedDate) ==
                                  DateFormat('dd').format(DateTime.now())) {
                            return Container(
                              width: size.width * 0.4,
                              height: size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: size.width * 0.4,
                              height: size.height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  // _showBottomSheet(context, task);
                                },
                              ),
                            );
                          }
                        },
                      );
                    }),
                    // child: SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Row(
                    //     children: List.generate(10, (index) {
                    //       return Container(
                    //         width: size.width * 0.4,
                    //         height: size.height * 0.2,
                    //         margin: const EdgeInsets.only(right: 10),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(size.width * 0.03),
                    //           color: Colors.white,
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.3),
                    //               blurRadius: 6,
                    //               offset: const Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: const Padding(
                    //           padding: EdgeInsets.all(10.0),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 "DermDiag",
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                   color: Color(0xFF454571),
                    //                   fontFamily: 'Releway',
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               SizedBox(height: 5),
                    //               Text(
                    //                 "will be done soon",
                    //                 style: TextStyle(
                    //                   color: Color(0xFF454571),
                    //                   fontFamily: 'Releway',
                    //                   fontSize: 15,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _parseDateTime(String timeString) {
    List<String> components = timeString.split(' ');
    List<String> timeComponents = components[0].split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    if (components.length > 1) {
      String period = components[1];
      if (period.toLowerCase() == 'pm' && hour < 12) {
        hour += 12;
      } else if (period.toLowerCase() == 'am' && hour == 12) {
        hour = 0;
      }
    }

    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }
}
