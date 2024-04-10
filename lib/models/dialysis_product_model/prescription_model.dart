class PrescriptionModel {
  bool? result;
  var message;
  List<Prescriptions>? prescriptions;
  int? page;

  PrescriptionModel({this.result, this.message, this.prescriptions, this.page});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['prescriptions'] != null) {
      prescriptions = <Prescriptions>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(new Prescriptions.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.prescriptions != null) {
      data['prescriptions'] =
          this.prescriptions!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class Prescriptions {
  var id;
  var userId;
  var file;
  var title;
  var fileType;
  var type;
 var text;
 var doctorId;
  var status;
  var createdAt;
  var updatedAt;

  Prescriptions(
      {this.id,
        this.userId,
        this.file,
        this.title,
        this.fileType,
        this.type,
        this.text,
        this.doctorId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Prescriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    file = json['file'];
    title = json['title'];
    fileType = json['file_type'];
    type = json['type'];
    text = json['text'];
    doctorId = json['doctor_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['file'] = this.file;
    data['title'] = this.title;
    data['file_type'] = this.fileType;
    data['type'] = this.type;
    data['text'] = this.text;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
