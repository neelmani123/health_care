class HomeModel {
  bool? result;
 var message;
  HomeData? homeData;

  HomeModel({this.result, this.message, this.homeData});

  HomeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    homeData = json['home_data'] != null
        ?  HomeData.fromJson(json['home_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.homeData != null) {
      data['home_data'] = this.homeData!.toJson();
    }
    return data;
  }
}

class HomeData {
  User? user;
  List<Banners>? banners;
  List<BestSelling>? bestSelling;
  List<Blogs>? blogs;

  HomeData({this.user, this.banners, this.bestSelling, this.blogs});

  HomeData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['best_selling'] != null) {
      bestSelling = <BestSelling>[];
      json['best_selling'].forEach((v) {
        bestSelling!.add(new BestSelling.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.bestSelling != null) {
      data['best_selling'] = this.bestSelling!.map((v) => v.toJson()).toList();
    }
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
 var id;
  var name;
  var email;
  var emailVerifiedAt;
  var createdAt;
  var updatedAt;
  var phone;
  var otp;
  var fcmToken;
  var gender;
  var dob;
  var address;
  var stateId;
  var cityId;
  var pincode;
  var image;
  var weight;
  var height;
  var bloodGroup;
  var isHiv;
  var allergies;
  var chronicIllness;
  var dialysisSinceDate;
  var ayushmanCard;
  var mediclaimPolicy;
  var uidNo;
  var otherStateMedicalCard;
  var latitude;
  var longitude;
  var expiredAt;
  var wallet;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.otp,
        this.fcmToken,
        this.gender,
        this.dob,
        this.address,
        this.stateId,
        this.cityId,
        this.pincode,
        this.image,
        this.weight,
        this.height,
        this.bloodGroup,
        this.isHiv,
        this.allergies,
        this.chronicIllness,
        this.dialysisSinceDate,
        this.ayushmanCard,
        this.mediclaimPolicy,
        this.uidNo,
        this.otherStateMedicalCard,
        this.latitude,
        this.longitude,
        this.expiredAt,
        this.wallet});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    otp = json['otp'];
    fcmToken = json['fcm_token'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    image = json['image'];
    weight = json['weight'];
    height = json['height'];
    bloodGroup = json['blood_group'];
    isHiv = json['is_hiv'];
    allergies = json['allergies'];
    chronicIllness = json['chronic_illness'];
    dialysisSinceDate = json['dialysis_since_date'];
    ayushmanCard = json['ayushman_card'];
    mediclaimPolicy = json['mediclaim_policy'];
    uidNo = json['uid_no'];
    otherStateMedicalCard = json['other_state_medical_card'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    expiredAt = json['expired_at'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['otp'] = this.otp;
    data['fcm_token'] = this.fcmToken;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['image'] = this.image;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['blood_group'] = this.bloodGroup;
    data['is_hiv'] = this.isHiv;
    data['allergies'] = this.allergies;
    data['chronic_illness'] = this.chronicIllness;
    data['dialysis_since_date'] = this.dialysisSinceDate;
    data['ayushman_card'] = this.ayushmanCard;
    data['mediclaim_policy'] = this.mediclaimPolicy;
    data['uid_no'] = this.uidNo;
    data['other_state_medical_card'] = this.otherStateMedicalCard;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['expired_at'] = this.expiredAt;
    data['wallet'] = this.wallet;
    return data;
  }
}

class Banners {
 var id;
  var image;
 var status;
  var type;
  var hospitalId;
 var isDelete;
  var createdAt;
  var updatedAt;

  Banners(
      {this.id,
        this.image,
        this.status,
        this.type,
        this.hospitalId,
        this.isDelete,
        this.createdAt,
        this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    type = json['type'];
    hospitalId = json['hospital_id'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['type'] = this.type;
    data['hospital_id'] = this.hospitalId;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BestSelling {
 var id;
  var name;
  var image;
  var mrp;
  var sellingPrice;
 var status;
 var ratings;
 var is_wishlist;
  var createdAt;
  var updatedAt;

  BestSelling(
      {this.id,
        this.name,
        this.image,
        this.mrp,
        this.ratings,
        this.is_wishlist,
        this.sellingPrice,
        this.status,
        this.createdAt,
        this.updatedAt});

  BestSelling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    mrp = json['mrp'];
    is_wishlist=json['is_wishlist'];
    ratings=json['ratings'];
    sellingPrice = json['selling_price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['ratings'] = this.ratings;
    data['is_wishlist'] = this.is_wishlist;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Blogs {
 var id;
  var title;
  var image;
  var description;
 var status;
  var createdAt;
  var updatedAt;

  Blogs(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
