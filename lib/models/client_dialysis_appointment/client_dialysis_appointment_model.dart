class ClientDialysisAppointmentModel {
  bool? result;
  var message;
  List<Appointments>? appointments;
  var page;

  ClientDialysisAppointmentModel(
      {this.result, this.message, this.appointments, this.page});

  ClientDialysisAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  var appointmentStatus;
  var updatedBy;
  var status;
  var createdAt;
  var updatedAt;
  var isChange;
  var hospitalName;
  var doctorName;
  var lastDialysisDate;
  var image;
  var userName;
  var isExpanded;

  Appointments(
      {this.id,
        this.hospitalId,
        this.doctorId,
        this.userId,
        this.type,
        this.slotTime,
        this.date,
        this.prescription,
        this.appointmentStatus,
        this.updatedBy,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isChange,
        this.hospitalName,
        this.doctorName,
        this.lastDialysisDate,
        this.image,
        this.userName});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    type = json['type'];
    slotTime = json['slot_time'];
    date = json['date'];
    prescription = json['prescription'];
    appointmentStatus = json['appointment_status'];
    updatedBy = json['updated_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isChange = json['is_change'];
    hospitalName = json['hospital_name'];
    doctorName = json['doctor_name'];
    lastDialysisDate = json['last_dialysis_date'];
    image = json['image'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['slot_time'] = this.slotTime;
    data['date'] = this.date;
    data['prescription'] = this.prescription;
    data['appointment_status'] = this.appointmentStatus;
    data['updated_by'] = this.updatedBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_change'] = this.isChange;
    data['hospital_name'] = this.hospitalName;
    data['doctor_name'] = this.doctorName;
    data['last_dialysis_date'] = this.lastDialysisDate;
    data['image'] = this.image;
    data['user_name'] = this.userName;
    return data;
  }
}
