import 'dart:convert';
import 'dart:developer';
import 'package:derma/Patients/LoginPatient.dart';
import 'package:derma/Patients/String_text.dart';
import 'package:derma/models/treatmentPlan_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddPlanPage extends StatefulWidget {
  @override
  _AddPlanPageState createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  final TextEditingController treatmentNameController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    //getTreatmentPlan();
    //addMedicines();
  }

  Future<void> addMedicines(int patientId, int doctorId, String medicine,
      String quantity, String frequency) async {
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Doctors/AddMedicines?doctorId=$doctorId&patientId=$patientId');
    final Map<String, dynamic> data = {
      "medicineName": medicine,
      "quantity": quantity,
      "frequency": frequency
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Treatment'.tr()),
            content: Text('Treatment Added Successfully'.tr()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'.tr()),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final jsonResponse = jsonDecode(response.body);
          log(jsonResponse.toString());
          return AlertDialog(
            title: const Text('Failed'),
            content: const Text('Failed To Add Treatment'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<TreatmentModel>> getTreatmentPlan(int doctorId) async {
    String? patientId = await Local(storage).getLoginIdPatient();
    final url = Uri.parse(
        'http://dermdiag.somee.com/api/Patients/GetTreatmentPlan?doctorId=$doctorId&patientId=$patientId');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<TreatmentModel> doctors =
          jsonData.map((item) => TreatmentModel.fromJson(item)).toList();
      return doctors;
    } else {
      print(response.statusCode);
      throw Exception(
          'Failed to get Treatment list. Status code: ${response.statusCode}');
    }
  }

  final List<String> items = [
    Medication_1,
    Medication_2,
    Medication_3,
    Medication_4,
    Medication_5,
    Medication_6,
    Medication_7,
    Medication_8,
    Medication_9,
    Medication_10
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => Questions(title: ''),
                //   ),
                // );
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
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 1, left: 110),
                child: Text(
                  'Add treatment plan'.tr(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(63, 59, 108, 1),
                      fontFamily: 'Releway',
                      height: 1.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, bottom: 20),
            child: Text(
              'How many medications do you want to add?'.tr(),
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                color: Color(0xFF454571),
                height: 1.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 315,
              height: 40,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Number of medications'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xB8454571),
                      ),
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item.tr(),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xB8454571),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 6, right: 14),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Color(0xB8454571),
                      iconDisabledColor: Color(0xB8454571),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(1, -10),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 12, right: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildMedicationCards(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMedicationCards() {
    if (selectedValue == null) {
      return [];
    }
    int medications = int.tryParse(selectedValue!.split(' ')[0]) ?? 0;
    List<Widget> cards = [];
    for (int i = 1; i <= medications; i++) {
      cards.add(
        MedicationCard(),
      );
      // Add a divider between cards
      if (i < medications) {
        cards.add(const Divider());
      }
    }
    return cards;
  }
}

class MedicationCard extends StatefulWidget {
  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  String? option1Selected;
  String? option2Selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 7),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF454571).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter medication name'.tr(),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              ),
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF454571),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Releway'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 22),
                  width: 10,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButton2<String>(
                    value: option1Selected,
                    hint: Text(
                      'How many times per day?'.tr(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xB8454571),
                      ),
                    ),
                    items: [Times_1, Times_2, Times_3, Times_4]
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xB8454571),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        option1Selected = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 1),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Color(0xB8454571),
                      iconDisabledColor: Color(0xB8454571),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(1, -10),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.only(left: 12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 22, left: 24),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButton2<String>(
                    value: option2Selected,
                    hint: Text(
                      'For how many days?'.tr(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xB8454571),
                      ),
                    ),
                    items: [
                      Day_1,
                      Day_2,
                      Day_3,
                      Day_4,
                      Day_5,
                      Day_6,
                      'For 1 Week',
                      'For 2 Weeks',
                      'For 3 Weeks',
                      'For 1 Month'
                    ]
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xB8454571),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        option2Selected = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 2),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Color(0xB8454571),
                      iconDisabledColor: Color(0xB8454571),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(1, -10),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 4, right: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
