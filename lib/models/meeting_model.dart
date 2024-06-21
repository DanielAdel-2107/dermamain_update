class MeetingModel {
  int? patientId;
  int? doctorId;
  String? date;
  String? patientLink;
  String? doctorLink;

  MeetingModel({
    this.patientId,
    this.doctorId,
    this.date,
    this.patientLink,
    this.doctorLink,
  });

  MeetingModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    doctorId = json['doctorId'];
    date = json['date'] ?? '';
    patientLink = json['patientLink'] ?? '';
    doctorLink = json['doctorLink'] ?? '';
  }

  Map<String, dynamic> toMap({int? id}) {
    final Map<String, dynamic> map = {
      "patientId": patientId,
      "doctorId": doctorId,
      "date": date,
      "patientLink": patientLink,
      "doctorLink": doctorLink
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
