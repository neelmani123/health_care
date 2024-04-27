class PatientDetailsModel {
  bool? result;
  var message;
  PatientUserData? userData;
  List<Null>? previousRecord;

  PatientDetailsModel(
      {this.result, this.message, this.userData, this.previousRecord});

  PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    userData = json['user_data'] != null
        ? new PatientUserData.fromJson(json['user_data'])
        : null;
    // if (json['previous_record'] != null) {
    //   previousRecord = <Null>[];
    //   json['previous_record'].forEach((v) {
    //     previousRecord!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    // if (this.previousRecord != null) {
    //   data['previous_record'] =
    //       this.previousRecord!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class PatientUserData {
  var id;
  var name;
  var email;
  var emailVerifiedAt;
  var password;
  var rememberToken;
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
  var isDelete;
  var patientId;

  PatientUserData(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
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
        this.wallet,
        this.isDelete,
        this.patientId});

  PatientUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
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
    isDelete = json['is_delete'];
    patientId = json['patient_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
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
    data['is_delete'] = this.isDelete;
    data['patient_id'] = this.patientId;
    return data;
  }
}
