import 'package:derma/Doctors/HomeDoctor.dart';
import 'package:derma/Patients/LoginPatient.dart';
import 'package:derma/Patients/appointmentdone.dart';
import 'package:derma/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Doctors/AccountPageDoctor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookAppointment extends StatelessWidget {
final Doctor doctor ;
  BookAppointment({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Book(doctor: doctor,),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.dark().copyWith(
    //     scaffoldBackgroundColor: Colors.white,
    //   ),
    //   home: Scaffold(
    //     body: Book(),
    //   ),
    // );
  }
}

class Book extends StatefulWidget {
  final Doctor doctor ;

  const Book({super.key, required this.doctor});
  @override
  _BookState createState() => _BookState();
}

bool is_wait = false;

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _BookState extends State<Book> {
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  final DateTime _firstDay = DateTime.utc(2010, 10, 16);
  final DateTime _lastDay = DateTime.utc(2030, 3, 14);

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
  }

  Future<void> bookPatient(
      BuildContext context, Map<String, dynamic> data) async {
    is_wait = true;
    setState(() {});
    final url = Uri.parse('http://dermdiag.somee.com/api/Patients/CreateBook');
    final response = await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
      // final patientId = jsonResponse['id'];
      // print('Patient ID: $patientId');

      setState(() {
        is_wait = false;
      });
      // if (patientId != null) {
      showToast(
          msg: "The appointment has been booked successfully",
          state: ToastStates.SUCCESS);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  AppointmentDone(doctor: widget.doctor,date: date_day, time: date_time,)),
      );
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
   String date_time = "";
   String date_day= "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              width: screenWidth,
              clipBehavior: Clip.antiAlias,
              decoration:  BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle tap
                        },
                        child: Transform.rotate(
                          angle: 3.14,
                          child: Image.asset(
                            "assets/images/next(2).png",
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          "assets/images/next(1).png",
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: ShapeDecoration(
                          color:  Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      Positioned(
                        child://widget.doctor!.image!=""&&widget.doctor!.image!=null? Image.network(widget.doctor!.image??""):
                        Image.asset(
                          "assets/images/doctor.png",
                          width: screenWidth * 0.27,
                          height: screenWidth * 0.27,
                        ),
                      ),
                    ],
                  ),
                  Text(widget.doctor!.image??""),
                  Text(
                      widget.doctor!.name??"",
                    // 'Dr. Steller Kane',
                    style: TextStyle(
                      color: const Color(0xFF454571),
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/chat.png",
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      ),
                      Image.asset(
                        "assets/images/vedio.png",
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      ),
                      Image.asset(
                        "assets/images/location.png",
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: screenWidth * 0.4,
                            child: Text(
                              'About',
                              style: TextStyle(
                                color: const Color(0xFF9F73AB),
                                fontSize: screenWidth * 0.045,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountPageDoctor()),
                            );
                          },
                          child: Text(
                            'See Doctor’s Profile',
                            style: TextStyle(
                              color: const Color(0xFF454571),
                              fontSize: screenWidth * 0.03,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Text(
                      widget.doctor!.description??"",
                      // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: const Color(0xFF454571),
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: screenWidth * 0.85,
                    child: MyCalendarWidget(
                      firstDay: _firstDay,
                      lastDay: _lastDay,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      calendarFormat: _calendarFormat,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9F73AB),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // _selectedDay!.add(Duration(hours: _selectedTime.hour));
                      String date = DateFormat("yyyy-MM-ddTHH:mm:ss").format(
                              DateTime(
                                  _selectedDay.year,
                                  _selectedDay.month,
                                  _selectedDay.day,
                                  _selectedTime.hour,
                                  _selectedTime.minute,
                                  00)) +
                          ".039Z";
                      // print(_selectedDay);
                      print(date);
                      print("_selectedTime.hour");
                      String? patientId = await Local(FlutterSecureStorage())
                          .getLoginIdPatient();

                      setState(() {
                        date_day =  DateFormat("yyyy-MM-dd").format(
                            DateTime(
                                _selectedDay.year,
                                _selectedDay.month,
                                _selectedDay.day,
                              ));
                        date_time ="${_selectedTime.hour} : ${_selectedTime.minute}";
                      });

                      Map<String, dynamic> data = {
                        "doctorID": widget.doctor!.id,
                        "patientID": patientId,
                        "date": date,
                      };
                      print(data);
                      bookPatient(context, data);
                    },
                    child: is_wait
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Book Appointment',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCalendarWidget extends StatefulWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(DateTime) onPageChanged;
  final void Function(CalendarFormat) onFormatChanged;

  const MyCalendarWidget({
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onFormatChanged,
  });

  @override
  _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
}

late TimeOfDay _selectedTime = TimeOfDay.now();

class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: widget.firstDay,
          lastDay: widget.lastDay,
          focusedDay: widget.focusedDay,
          selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
          calendarFormat: widget.calendarFormat,
          onDaySelected: widget.onDaySelected,
          onPageChanged: widget.onPageChanged,
          onFormatChanged: widget.onFormatChanged,
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(
              color: Color(0xFF9F73AB),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text('Select Time: ${_selectedTime.format(context)}'),
        ),
      ],
    );
  }
}
