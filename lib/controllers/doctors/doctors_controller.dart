
import 'package:derma/api/service/dio_services.dart';
import 'package:derma/models/patient_doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api/client/dio_client.dart';

class DoctorsController extends GetxController {
  bool isGettingDoctors = true;
  List<PatientDoctorModel> doctors = [];
  
  final DioServices _dioHelper = DioServices(dioClient: DioClient(Dio()));
  @override
  onInit() async {
    super.onInit();
  }

  
  getDoctors(int patientId) async {
    try {
      var response = await _dioHelper.getDoctors(patientId);
      if (response.data['data'] != null) {
        response.data['data'].forEach(
          (doctor) => doctors.add(
            PatientDoctorModel.fromJson(doctor),
          ),
        );
      }
      isGettingDoctors = false;
    } catch (e) {
      isGettingDoctors = false;
    }
    update();
  }
   
}
