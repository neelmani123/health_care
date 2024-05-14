class DoctorDetailsModel {
  bool? result;
  var message;
  Doctors? doctors;

  DoctorDetailsModel({this.result, this.message, this.doctors});

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    doctors =
    json['doctors'] != null ? new Doctors.fromJson(json['doctors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.toJson();
    }
    return data;
  }
}

class Doctors {
  var id;
  var title;
  var is_wishlist;
  var name;
  var email;
  var phone;
  var degree;
  var departmentIds;
  var fees;
  var experience;
  var slotTime;
  var status;
  var isDelete;
  var updatedAt;
  var createdAt;
  var type;
  var hospitalId;
  var days;
  var image;
  var bio;
  var avg_rating;
  var total_rating;
  var endTime;
  var startTime;
  var isOpen247;
  var services;
  var isEmergency;
  var is_surgery;
 var priority;

  Doctors(
      {this.id,
        this.title,
        this.name,
        this.email,
        this.phone,
        this.is_wishlist,
        this.avg_rating,
        this.total_rating,
        this.degree,
        this.departmentIds,
        this.fees,
        this.experience,
        this.isOpen247,
        this.is_surgery,
        this.services,
        this.isEmergency,
        this.slotTime,
        this.status,
        this.isDelete,
        this.updatedAt,
        this.createdAt,
        this.type,
        this.hospitalId,
        this.days,
        this.image,
        this.bio,
        this.endTime,
        this.startTime,
        this.priority});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    title = json['title']??"";
    name = json['name']??"";
    is_wishlist = json['is_wishlist']??"";
    email = json['email']??"";
    phone = json['phone']??"";
    degree = json['degree']??"";
    total_rating = json['total_ratings']??"";
    avg_rating = json['avg_ratings']??"";
    departmentIds = json['department_ids']??"";
    fees = json['fees']??"";
    isOpen247 = json['is_open_247']??"";
    services = json['services']??"";
    isEmergency = json['is_emergency']??"";
    is_surgery = json['is_surgery']??"";
    experience = json['experience']??"";
    slotTime = json['slot_time']??"";
    status = json['status']??"";
    isDelete = json['is_delete']??"";
    updatedAt = json['updated_at']??"";
    createdAt = json['created_at']??"";
    type = json['type']??"";
    hospitalId = json['hospital_id']??"";
    days = json['days']??"";
    image = json['image']??"";
    bio = json['bio']??"";
    endTime = json['end_time']??"";
    startTime = json['start_time']??"";
    priority = json['priority']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['is_wishlist'] = this.is_wishlist;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['degree'] = this.degree;
    data['total_ratings'] = this.total_rating;
    data['avg_ratings'] = this.avg_rating;
    data['is_surgery'] = this.is_surgery;
    data['services'] = this.services;
    data['is_emergency'] = this.isEmergency;
    data['department_ids'] = this.departmentIds;
    data['fees'] = this.fees;
    data['experience'] = this.experience;
    data['slot_time'] = this.slotTime;
    data['status'] = this.status;
    data['is_delete'] = this.isDelete;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    data['hospital_id'] = this.hospitalId;
    data['days'] = this.days;
    data['image'] = this.image;
    data['bio'] = this.bio;
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    data['priority'] = this.priority;
    return data;
  }
}
