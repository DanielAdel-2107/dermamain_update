class PatientDoctorModel {
  int? id;
  String? name;
  String? image;
  double? rate;
  bool? favorite;

  PatientDoctorModel({
    this.id,
    this.name,
    this.image,
    this.rate,
    this.favorite,
  });

  PatientDoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ?? '';
    rate = json['rating'] ?? 0.0;
    favorite = json['isFavourite'] ?? '';
  }

  Map<String, dynamic> toMap({int? id}) {
    final Map<String, dynamic> map = {
      "name": name,
      "image": image,
      "rating": rate,
      "isFavourite": favorite
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
