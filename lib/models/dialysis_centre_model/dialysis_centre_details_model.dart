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
  var dialysisDetails;
  var phone;
  var address;
  var priority;
  var is_wishlist;
  var status;
  var isDelete;
  var isOpen247;
  var services;
  var isEmergency;
  var is_surgery;
  var updatedAt;
  var createdAt;
  var latitude;
  var description;
  var longitude;
  var isDialysisCenter;
  var image;
  var totalRatings;
  var avgRatings;
  var map_html;

  DialysisCenter(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.is_wishlist,
        this.address,
        this.dialysisDetails,
        this.priority,
        this.status,
        this.isDelete,
        this.isOpen247,
        this.is_surgery,
        this.description,
        this.services,
        this.isEmergency,
        this.updatedAt,
        this.createdAt,
        this.map_html,
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
    dialysisDetails = json['dialysisDetails'];
    address = json['address'];
    priority = json['priority'];
    is_wishlist = json['is_wishlist'];
    status = json['status'];
    isDelete = json['is_delete'];
    map_html = json['map_html'];
    isOpen247 = json['is_open_247'];
    description = json['description'];
    services = json['services'];
    isEmergency = json['is_emergency'];
    is_surgery = json['is_surgery'];
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
    data['is_wishlist'] = this.is_wishlist;
    data['email'] = this.email;
    data['dialysisDetails'] = this.dialysisDetails;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['is_delete'] = this.isDelete;
    data['is_open_247'] = this.isOpen247;
    data['map_html'] = this.map_html;
    data['is_surgery'] = this.is_surgery;
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
