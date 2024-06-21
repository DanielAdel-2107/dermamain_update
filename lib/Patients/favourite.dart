import 'dart:convert';
import 'dart:developer';
import 'package:derma/Patients/LoginPatient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/client/dio_client.dart';
import 'package:http/http.dart' as http;
import '../api/service/dio_services.dart';
import '../models/patient_doctor_model.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<String> items = List.generate(10, (index) => "Dr/Seif Ali Mohamed");
  final DioServices _dioHelper = DioServices(dioClient: DioClient(Dio()));
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getFavoriteDoctors();
  }

  Future<List<PatientDoctorModel>> getFavoriteDoctors() async {
    String? patientId = await Local(storage).getLoginIdPatient();
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Patients/GetFavoriteDoctors?id=$patientId');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<PatientDoctorModel> doctors =
          jsonData.map((item) => PatientDoctorModel.fromJson(item)).toList();
      return doctors;
    } else {
      print(response.statusCode);
      throw Exception(
          'Failed to get doctors list. Status code: ${response.statusCode}');
    }
  }

  addFavoriteDoctor(int patientId, int doctorId) async {
    try {
      await _dioHelper.addFavoriteDoctor(patientId, doctorId);
    } catch (e) {
      log(e.toString());
    }
  }

  removeFavoriteDoctors(int patientId, int doctorId) async {
    try {
      await _dioHelper.removeFavoriteDoctors(patientId, doctorId);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text(
                "Favorite Doctors".tr(),
                style: const TextStyle(
                  fontFamily: 'poe',
                  color: Color(0xFF454571),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(),
        automaticallyImplyLeading: false,
        toolbarHeight: 35,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<List<PatientDoctorModel>>(
              future: getFavoriteDoctors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final doctors = snapshot.data!;
                  return doctors.isNotEmpty
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (var doctor in doctors)
                              DoctorCard(
                                doctorName: doctor.name ?? "",
                                onDelete: () async {
                                  String? patientId =
                                      await Local(storage).getLoginIdPatient();
                                  setState(() {
                                      removeFavoriteDoctors(
                                          int.parse(patientId!), doctor.id!);
                                      log("remove ${doctor.favorite}");
                                      doctor.favorite == false;
                                    });
                                    Fluttertoast.showToast(
                                        msg:
                                            "doctor removed from favorites successfully".tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            const Color(0xFF454571),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                },
                                onTap: () async {
                                  String? patientId =
                                      await Local(storage).getLoginIdPatient();
                                  if (doctor.favorite == false) {
                                    setState(() {
                                      addFavoriteDoctor(
                                          int.parse(patientId!), doctor.id!);
                                      doctor.favorite == true;
                                      Fluttertoast.showToast(
                                          msg:
                                              "doctor added to favorites successfully".tr(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              const Color(0xFF454571),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  } else if (doctor.favorite == true) {
                                    setState(() {
                                      removeFavoriteDoctors(
                                          int.parse(patientId!), doctor.id!);
                                      log("remove ${doctor.favorite}");
                                      doctor.favorite == false;
                                    });
                                    Fluttertoast.showToast(
                                        msg:
                                            "doctor removed from favorites successfully".tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            const Color(0xFF454571),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                colorCode: doctor.favorite == false
                                    ? Colors.grey
                                    : Colors.red,
                              ),
                          ],
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text("No Favorite doctors found",
                              style: TextStyle(color: Colors.teal,fontSize: 24),
                            )),
                          ],
                        );
                }
                return const Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final VoidCallback onDelete;
  final void Function()? onTap;
  final Color colorCode;

  DoctorCard({
    required this.doctorName,
    required this.onDelete,
    required this.onTap,
    required this.colorCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/doctor.png'),
            ),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'poe',
                  ),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 4.5,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: const EdgeInsets.only(top: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 22,
                      width: 16,
                    ),
                    Positioned(
                      top: 25,
                      child: InkWell(
                        onTap: onTap,
                        child: Icon(
                          Icons.favorite,
                          color: colorCode,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MySample()),
                    // );
                  },
                  child: Container(
                    width: 130,
                    height: 24,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9F73AB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child:  Text(
                      'Details'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.black26,
              iconSize: 25,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:  Text("Confirmation".tr()),
                      content:  Text(
                          "Are you sure you want to delete this doctor from your favorites list?".tr()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDelete();
                          },
                          child:  Text("Confirm".tr()),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:  Text("Cancel".tr()),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

