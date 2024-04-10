class DialysisCentreModel {
  bool? result;
  var message;
  List<DialysisCenter>? dialysisCenter;
  var page;

  DialysisCentreModel(
      {this.result, this.message, this.dialysisCenter, this.page});

  DialysisCentreModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['dialysis_center'] != null) {
      dialysisCenter = <DialysisCenter>[];
      json['dialysis_center'].forEach((v) {
        dialysisCenter!.add(new DialysisCenter.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.dialysisCenter != null) {
      data['dialysis_center'] =
          this.dialysisCenter!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class DialysisCenter {
  var id;
  var name;
  var email;
  var phone;
  var address;
  var totalRatings;
  var avgRatings;
 var priority;
  var status;
  var isDelete;
  var isOpen247;
 var services;
 var isEmergency;
  var updatedAt;
  var createdAt;
 var latitude;
 var longitude;
  var isDialysisCenter;
  var image;

  DialysisCenter(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.avgRatings,
        this.totalRatings,
        this.priority,
        this.status,
        this.isDelete,
        this.isOpen247,
        this.services,
        this.isEmergency,
        this.updatedAt,
        this.createdAt,
        this.latitude,
        this.longitude,
        this.isDialysisCenter,
        this.image});

  DialysisCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    totalRatings = json['total_ratings'];
    avgRatings = json['avg_ratings'];
    priority = json['priority'];
    status = json['status'];
    isDelete = json['is_delete'];
    isOpen247 = json['is_open_247'];
    services = json['services'];
    isEmergency = json['is_emergency'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['services'] = this.services;
    data['is_emergency'] = this.isEmergency;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['total_ratings'] = this.totalRatings=="Null"?"0":this.totalRatings;
    data['avg_ratings'] = this.avgRatings;
    data['is_dialysis_center'] = this.isDialysisCenter;
    data['image'] = this.image;
    return data;
  }
}
