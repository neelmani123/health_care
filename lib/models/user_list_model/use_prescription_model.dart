class UsePrescriptionListModel {
  bool? result;
  var message;
  List<UsePrescriptions>? prescriptions;
  var page;

  UsePrescriptionListModel(
      {this.result, this.message, this.prescriptions, this.page});

  UsePrescriptionListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['prescriptions'] != null) {
      prescriptions = <UsePrescriptions>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(new UsePrescriptions.fromJson(v));
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

class UsePrescriptions {
  var id;
  var userId;
  var file;
  var title;
  var fileType;
  var type;
  var text;
  var doctorId;
  var hospitalId;
  var addedBy;
  var status;
  var createdAt;
  var updatedAt;

  UsePrescriptions(
      {this.id,
        this.userId,
        this.file,
        this.title,
        this.fileType,
        this.type,
        this.text,
        this.doctorId,
        this.hospitalId,
        this.addedBy,
        this.status,
        this.createdAt,
        this.updatedAt});

  UsePrescriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    file = json['file'];
    title = json['title'];
    fileType = json['file_type'];
    type = json['type'];
    text = json['text'];
    doctorId = json['doctor_id'];
    hospitalId = json['hospital_id'];
    addedBy = json['added_by'];
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
    data['hospital_id'] = this.hospitalId;
    data['added_by'] = this.addedBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
