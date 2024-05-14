class MyWishListModel {
  bool? result;
  var message;
  List<Wishlists>? wishlists;
 var page;

  MyWishListModel({this.result, this.message, this.wishlists, this.page});

  MyWishListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['wishlists'] != null) {
      wishlists = <Wishlists>[];
      json['wishlists'].forEach((v) {
        wishlists!.add(new Wishlists.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.wishlists != null) {
      data['wishlists'] = this.wishlists!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class Wishlists {
 var id;
  var type;
  var typeId;
  var userId;
  var createdAt;
  var updatedAt;
  var hospitalName;
  var name;
  var doctorName;
  var image;
  var productName;

  Wishlists(
      {this.id,
        this.type,
        this.typeId,
        this.userId,
        this.createdAt,
        this.name,
        this.updatedAt,
        this.image,
        this.hospitalName,
        this.doctorName,
        this.productName});

  Wishlists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    userId = json['user_id'];
    image = json['image'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospitalName = json['hospital_name'];
    doctorName = json['doctor_name'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['hospital_name'] = this.hospitalName;
    data['doctor_name'] = this.doctorName;
    data['product_name'] = this.productName;
    return data;
  }
}
