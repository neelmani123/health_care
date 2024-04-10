class SignupSettingsModel {
  bool? result;
  var message;
  List<Allergies>? allergies;
  List<ChronicIllness>? chronicIllness;

  SignupSettingsModel(
      {this.result, this.message, this.allergies, this.chronicIllness});

  SignupSettingsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['allergies'] != null) {
      allergies = <Allergies>[];
      json['allergies'].forEach((v) {
        allergies!.add(new Allergies.fromJson(v));
      });
    }
    if (json['chronic_illness'] != null) {
      chronicIllness = <ChronicIllness>[];
      json['chronic_illness'].forEach((v) {
        chronicIllness!.add(new ChronicIllness.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.allergies != null) {
      data['allergies'] = this.allergies!.map((v) => v.toJson()).toList();
    }
    if (this.chronicIllness != null) {
      data['chronic_illness'] =
          this.chronicIllness!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allergies {
  var id;
  var name;
  var createdAt;
  var updatedAt;
  bool? isSelected;

  Allergies({this.id, this.name, this.createdAt, this.updatedAt,required this.isSelected});

  Allergies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ChronicIllness {
  var id;
  var name;
  var createdAt;
  var updatedAt;

  ChronicIllness({this.id, this.name, this.createdAt, this.updatedAt});

  ChronicIllness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
