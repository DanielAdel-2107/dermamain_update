import 'dart:convert';
import 'dart:developer';
import 'package:derma/BookAppointment.dart';
import 'package:derma/api/client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:derma/DetailsDoctor.dart';
import 'package:derma/responsive_layout.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Both/ScanPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Patients/LoginPatient.dart';
import '../Patients/search_screen_patient.dart';
import '../api/service/dio_services.dart';
import 'package:easy_localization/easy_localization.dart';

class Doctor {
  int id;
  final String? name;
  final String? image;
  final double? rate;
  final bool? favorite;
  final String? description;

  Doctor({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.favorite,
    required this.description,
  });
}

class HomeDoctor extends StatefulWidget {
  @override
  _HomeDoctorState createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  final DioServices _dioHelper = DioServices(dioClient: DioClient(Dio()));
  final storage = const FlutterSecureStorage();
  Future<List<Doctor>> getAllDoctors() async {
    String? patientId = await Local(storage).getLoginIdPatient();
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Patients/GetAllDoctors?id=$patientId');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Doctor> doctors = data
          .map((item) => Doctor(
                id: item['id'],
                name: item['name'],
                image: item['image'],
                rate: item['rating'],
                favorite: item['isFavourite'],
                description:
                    item['description'] == null ? "" : item['description'],
              ))
          .toList();
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
    return ResponsiveLayout(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/doct.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 300,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: Localizations.localeOf(context).languageCode == 'en'
                    ? 20
                    : 0,
                right: Localizations.localeOf(context).languageCode == 'ar'
                    ? MediaQuery.sizeOf(context).width * 0.45
                    : 0,
                child: Text(
                  'Welcome'.tr(),
                  style: const TextStyle(
                    color: Color.fromRGBO(69, 69, 113, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: Localizations.localeOf(context).languageCode == 'en'
                    ? 20
                    : 0,
                right: Localizations.localeOf(context).languageCode == 'ar'
                    ? MediaQuery.sizeOf(context).width * 0.45
                    : 0,
                child: Text(
                  'Premium'.tr(),
                  style: const TextStyle(
                    color: Color.fromRGBO(159, 115, 171, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 170,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 330,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(27),
                      border: Border.all(
                        color: const Color.fromRGBO(69, 69, 113, 1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for a doctor'.tr(),
                                border: InputBorder.none,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: Localizations.localeOf(context).languageCode == 'en'
                    ? 20
                    : MediaQuery.sizeOf(context).width * 0.7,
                child: Text(
                  'Top Doctors'.tr(),
                  style: const TextStyle(
                    color: Color.fromRGBO(69, 69, 113, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 280,
                left: 20,
                right: 0,
                child: SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Doctor>>(
                    future: getAllDoctors(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'.tr());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        final doctors = snapshot.data!;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var doctor in doctors)
                              CircleImageCard(
                                colorCode: doctor.favorite == false
                                    ? Colors.grey
                                    : Colors.red,
                                imagePath: doctor.image ?? "",
                                doctorName: doctor.name ?? "name",
                                rating: doctor.rate ?? 1.0,
                                doctor: doctor,
                                onTap: () async {
                                  String? patientId =
                                      await Local(storage).getLoginIdPatient();
                                  if (doctor.favorite == false) {
                                    setState(() {
                                      addFavoriteDoctor(
                                          int.parse(patientId!), doctor.id);
                                      doctor.favorite == true;
                                      Fluttertoast.showToast(
                                          msg: "add_doc".tr(),
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
                                          int.parse(patientId!), doctor.id);
                                      log("remove ${doctor.favorite}".tr());
                                      doctor.favorite == false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "remove_doc".tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            const Color(0xFF454571),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                onPressed: () {
                                  // Add your functionality here
                                },
                              ),
                          ],
                        );
                      }
                      return const Center(
                          child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: CircularProgressIndicator(),
                      ));
                    },
                  ),
                ),
              ),
              Positioned(
                top: 445,
                left: 20,
                right: 20,
                child: Center(
                  child: Container(
                    height: 150,
                    width: 330,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF454571),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/face.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? MediaQuery.sizeOf(context).width * 0.25
                              : 0,
                          right: Localizations.localeOf(context).languageCode ==
                                  'ar'
                              ? MediaQuery.sizeOf(context).width * 0.08
                              : 0,
                          child: Text(
                            "HomeText_doc".tr(),
                            style: const TextStyle(
                              color: Color.fromRGBO(69, 69, 113, 1),
                              fontSize: 14, // Reduced from 16 to 14
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 95,
                          right: MediaQuery.sizeOf(context).width * 0.15,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScanPage()),
                              );
                            },
                            child: SizedBox(
                              width: 192,
                              height: 43,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 170,
                                      height: 43,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFEAEAEA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 176.64,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF454571),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Start'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircleImageCard extends StatelessWidget {
  final String imagePath;
  final String doctorName;
  final Color colorCode;
  final double rating;
  final VoidCallback onPressed;
  final void Function()? onTap;
  final Doctor doctor;

  CircleImageCard({
    required this.imagePath,
    required this.doctorName,
    required this.colorCode,
    required this.rating,
    required this.onPressed,
    required this.onTap,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 100,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                  image: imagePath.isNotEmpty
                      ? NetworkImage(imagePath) as ImageProvider<Object>
                      : const AssetImage("assets/images/doc.png")
                          as ImageProvider<Object>,
                  fit: BoxFit.cover,
                ),
              )),
          const SizedBox(height: 8),
          Text(
            doctorName,
            style: const TextStyle(
              color: Color.fromRGBO(69, 69, 113, 1),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 12,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 8,
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
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookAppointment(
                          doctor: doctor,
                        )),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const DetailsDoctor()),
              // );
            },
            child: Container(
              width: 70,
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
              child: Text(
                'Details'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
