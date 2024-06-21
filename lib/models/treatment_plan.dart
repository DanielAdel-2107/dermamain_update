class TreatmentPlanModel {

  String? medicineName;
  String? quantity;
  String? frequency;


  TreatmentPlanModel({
    this.medicineName,
    this.quantity,
    this.frequency,
  });

  TreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicineName']??"";
    quantity = json['quantity'] ?? '';
    frequency = json['frequency'] ?? "";
  }

  Map<String, dynamic> toMap({int? id}) {
    final Map<String, dynamic> map = {
      "medicineName": medicineName,
      "quantity": quantity,
      "frequency": frequency,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
