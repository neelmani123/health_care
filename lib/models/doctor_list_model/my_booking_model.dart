class MyBookingModel {
  bool? result;
  var message;
  List<Appointments>? appointments;
  int? page;

  MyBookingModel({this.result, this.message, this.appointments, this.page});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.appointments != null) {
      data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class Appointments {
  var id;
  var hospitalId;
 var doctorId;
  var userId;
  var type;
  var slotTime;
  var date;
 var prescription;
  var status;
  var createdAt;
  var updatedAt;
  var hospitalName;
  var image;
  String? doctorName;
  var lastDialysis;

  Appointments(
      {this.id,
        this.hospitalId,
        this.doctorId,
        this.userId,
        this.image,
        this.type,
        this.lastDialysis,
        this.slotTime,
        this.date,
        this.prescription,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.hospitalName,
        this.doctorName});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    image = json['image'];
    lastDialysis = json['last_dialysis_date'];
    type = json['type'];
    slotTime = json['slot_time'];
    date = json['date'];
    prescription = json['prescription'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospitalName = json['hospital_name'];
    doctorName = json['doctor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['image'] = this.image;
    data['last_dialysis_date'] = this.lastDialysis;
    data['slot_time'] = this.slotTime;
    data['date'] = this.date;
    data['prescription'] = this.prescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['hospital_name'] = this.hospitalName;
    data['doctor_name'] = this.doctorName;
    return data;
  }
}
