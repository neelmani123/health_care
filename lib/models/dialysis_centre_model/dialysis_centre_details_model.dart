class DialysisCentreDetailsModel {
  bool? result;
  var message;
  DialysisCenter? dialysisCenter;

  DialysisCentreDetailsModel({this.result, this.message, this.dialysisCenter});

  DialysisCentreDetailsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    dialysisCenter = json['dialysis_center'] != null
        ? new DialysisCenter.fromJson(json['dialysis_center'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.dialysisCenter != null) {
      data['dialysis_center'] = this.dialysisCenter!.toJson();
    }
    return data;
  }
}

class DialysisCenter {
  var id;
  var name;
  var email;
  var phone;
  var address;
  var priority;
  var status;
  var isDelete;
  var isOpen247;
  var services;
  var isEmergency;
  var updatedAt;
  var createdAt;
  var latitude;
  var description;
  var longitude;
  var isDialysisCenter;
  var image;
  var totalRatings;
  var avgRatings;

  DialysisCenter(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.priority,
        this.status,
        this.isDelete,
        this.isOpen247,
        this.description,
        this.services,
        this.isEmergency,
        this.updatedAt,
        this.createdAt,
        this.latitude,
        this.longitude,
        this.isDialysisCenter,
        this.totalRatings,
        this.avgRatings,
        this.image});

  DialysisCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    priority = json['priority'];
    status = json['status'];
    isDelete = json['is_delete'];
    isOpen247 = json['is_open_247'];
    description = json['description'];
    services = json['services'];
    isEmergency = json['is_emergency'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    totalRatings = json['total_ratings'];
    avgRatings = json['avg_ratings'];
    isDialysisCenter = json['is_dialysis_center'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['is_delete'] = this.isDelete;
    data['is_open_247'] = this.isOpen247;
    data['description'] = description;
    data['services'] = this.services;
    data['is_emergency'] = this.isEmergency;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_dialysis_center'] = this.isDialysisCenter;
    data['image'] = this.image;
    data['total_ratings'] = this.totalRatings;
    data['avg_ratings'] = this.avgRatings;
    return data;
  }
}
