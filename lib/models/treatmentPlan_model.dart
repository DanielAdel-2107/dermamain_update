class TreatmentModel {
  String? name;
  String? quantity;
  String? frequency;

  TreatmentModel({
    this.name,
    this.quantity,
    this.frequency,
  });

  TreatmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    quantity = json["quantity"] ?? '';
    frequency = json["frequency"] ?? '';
  }

  Map<String, dynamic> toMap({int? id}) {
    final Map<String, dynamic> map = {
      "medicineName": name,
      "quantity": quantity,
      "frequency": frequency
    };
    return map;
  }
}
