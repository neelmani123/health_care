class UserListModel {
  bool? result;
  var message;
  List<UsersList>? usersList;
  var page;

  UserListModel({this.result, this.message, this.usersList, this.page});

  UserListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['users_list'] != null) {
      usersList = <UsersList>[];
      json['users_list'].forEach((v) {
        usersList!.add(new UsersList.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.usersList != null) {
      data['users_list'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class UsersList {
  var appointmentId;
  var userId;
  var type;
  var doctorId;
  var slotTime;
  var date;
  var prescription;
  var appointmentStatus;
  var userName;
  var userPhone;
  var userImage;
  var patientId;
  var lastDialysisDate;

  UsersList(
      {this.appointmentId,
        this.userId,
        this.type,
        this.doctorId,
        this.slotTime,
        this.date,
        this.prescription,
        this.appointmentStatus,
        this.userName,
        this.userPhone,
        this.userImage,
        this.patientId,
        this.lastDialysisDate});

  UsersList.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    userId = json['user_id'];
    type = json['type'];
    doctorId = json['doctor_id'];
    slotTime = json['slot_time'];
    date = json['date'];
    prescription = json['prescription'];
    appointmentStatus = json['appointment_status'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userImage = json['user_image'];
    patientId = json['patient_id'];
    lastDialysisDate = json['last_dialysis_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['doctor_id'] = this.doctorId;
    data['slot_time'] = this.slotTime;
    data['date'] = this.date;
    data['prescription'] = this.prescription;
    data['appointment_status'] = this.appointmentStatus;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['user_image'] = this.userImage;
    data['patient_id'] = this.patientId;
    data['last_dialysis_date'] = this.lastDialysisDate;
    return data;
  }
}
