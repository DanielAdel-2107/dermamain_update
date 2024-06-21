class Endpoints {
  Endpoints._();

  static const String baseUrl = "http://dermdiag.somee.com/api/";
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration connectionTimeout = Duration(seconds: 20);

  static const String addFavoriteDoctors = 'Patients/AddFavoriteDoctors';
  static const String getFavoriteDoctors = 'Patients/GetFavoriteDoctors';
  static const String removeFavoriteDoctors = 'Patients/RemoveFavoriteDoctors';
  static const String getTreatmentPlan = 'Patients/GetTreatmentPlan';
  static const String addMedicine = 'Doctors/AddMedicines';
  static const String getAllDoctors = 'Patients/GetAllDoctors';
  
}