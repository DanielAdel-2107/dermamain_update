import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../Doctors/HomeDoctor.dart';
import 'LoginPatient.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final storage = const FlutterSecureStorage();
  Future<List<Doctor>>? doctorsFuture;

  Future<List<Doctor>> searchDoctors(String searchText) async {
    String? patientId = await Local(storage).getLoginIdPatient();

    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Patients/SearchDoctors?DoctorName=$searchText&P_Id=$patientId');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );
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
        description: item['description']==null?"":item['description'],
              ))
          .toList();
      print(doctors);
      return doctors;
    } else {
      throw Exception(
          'Failed to search doctors. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back)),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.01),
                        child: SearchBar(
                          hintText: "search about doctor".tr(),
                          //onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          onSubmitted: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                doctorsFuture = null;
                              });
                            } else {
                              setState(() {
                                doctorsFuture = searchDoctors(value);
                              });
                            }
                          },
                          trailing: const [
                            Icon(
                              Icons.search,
                            )
                          ],
                          surfaceTintColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.bodyMedium),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02)),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 10,
                child: doctorsFuture == null
                    ?  Center(
                        child: Text("Search".tr()),
                      )
                    : FutureBuilder<List<Doctor>>(
                        future: doctorsFuture,
                        builder: (context, snp) {
                          print(snp.error);
                          if (snp.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: CircularProgressIndicator(),
                            ));
                          } else if (snp.hasError) {
                            return  Center(
                              child: Text("SomeThing go wrong".tr()),
                            );
                          } else if (snp.connectionState ==
                              ConnectionState.done) {
                            if (snp.data == null || snp.data!.isEmpty) {
                              return  Center(
                                child: Text("No Results Founded".tr()),
                              );
                            }
                            return GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              children: snp.data!
                                  .map(
                                    (e) => CircleImageCard(
                                      imagePath: e.image ?? "",
                                      doctorName: e.name ?? "name",
                                      rating: e.rate ?? 1.0,
                                      doctor: e,
                                      onPressed: () {
                                        // Add your functionality here
                                      },
                                      colorCode: e.favorite != null
                                          ? Colors.red
                                          : Colors.black,
                                      onTap: () {e.favorite != e.favorite;},
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                          return  Center(
                            child: Text("Search".tr()),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
