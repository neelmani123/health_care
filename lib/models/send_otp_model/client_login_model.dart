class ClientLoginModel {
  bool? success;
  var message;
  var token;
  User? user;
  var isSignup;

  ClientLoginModel(
      {this.success, this.message, this.token, this.user, this.isSignup});

  ClientLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isSignup = json['is_signup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['is_signup'] = this.isSignup;
    return data;
  }
}

class User {
  var id;
  var name;
  var username;
  var email;
  var roleId;
  var phone;
  var address;
  var remberToken;
  var status;
  var createdAt;
  var updatedAt;
  var image;
  var stateId;
  var forgotToken;
  var remarks;
  var isDelete;
  var addedBy;
  var isApprove;
  var deviceToken;
  var loginTime;
  var isLogout;
  var cityId;
  var passwordValue;
  var mpin;
  var businessName;
  var subscriptionStart;
  var subscriptionEnd;
  var referalCode;
  var subscriptionId;
  var gst;
  var shopAddress;
  var shopImage;
  var invPrefix;
  var signName;
  var invoiceImage;
  var signImage;
  var ifscCode;
  var acNo;
  var bankName;
  var isFree;
  var googleId;
  var upiId;
  var qrCode;
  var termsCond;
  var referenceContact;
  var branch;
  var hospitalId;
  var otp;
  var expiredAt;
  var fcmToken;

  User(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.roleId,
        this.phone,
        this.address,
        this.remberToken,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.stateId,
        this.forgotToken,
        this.remarks,
        this.isDelete,
        this.addedBy,
        this.isApprove,
        this.deviceToken,
        this.loginTime,
        this.isLogout,
        this.cityId,
        this.passwordValue,
        this.mpin,
        this.businessName,
        this.subscriptionStart,
        this.subscriptionEnd,
        this.referalCode,
        this.subscriptionId,
        this.gst,
        this.shopAddress,
        this.shopImage,
        this.invPrefix,
        this.signName,
        this.invoiceImage,
        this.signImage,
        this.ifscCode,
        this.acNo,
        this.bankName,
        this.isFree,
        this.googleId,
        this.upiId,
        this.qrCode,
        this.termsCond,
        this.referenceContact,
        this.branch,
        this.hospitalId,
        this.otp,
        this.expiredAt,
        this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    roleId = json['role_id'];
    phone = json['phone'];
    address = json['address'];
    remberToken = json['rember_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    stateId = json['state_id'];
    forgotToken = json['forgot_token'];
    remarks = json['remarks'];
    isDelete = json['is_delete'];
    addedBy = json['added_by'];
    isApprove = json['is_approve'];
    deviceToken = json['device_token'];
    loginTime = json['login_time'];
    isLogout = json['is_logout'];
    cityId = json['city_id'];
    passwordValue = json['password_value'];
    mpin = json['mpin'];
    businessName = json['business_name'];
    subscriptionStart = json['subscription_start'];
    subscriptionEnd = json['subscription_end'];
    referalCode = json['referal_code'];
    subscriptionId = json['subscription_id'];
    gst = json['gst'];
    shopAddress = json['shop_address'];
    shopImage = json['shop_image'];
    invPrefix = json['inv_prefix'];
    signName = json['sign_name'];
    invoiceImage = json['invoice_image'];
    signImage = json['sign_image'];
    ifscCode = json['ifsc_code'];
    acNo = json['ac_no'];
    bankName = json['bank_name'];
    isFree = json['is_free'];
    googleId = json['google_id'];
    upiId = json['upi_id'];
    qrCode = json['qr_code'];
    termsCond = json['terms_cond'];
    referenceContact = json['reference_contact'];
    branch = json['branch'];
    hospitalId = json['hospital_id'];
    otp = json['otp'];
    expiredAt = json['expired_at'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['rember_token'] = this.remberToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['state_id'] = this.stateId;
    data['forgot_token'] = this.forgotToken;
    data['remarks'] = this.remarks;
    data['is_delete'] = this.isDelete;
    data['added_by'] = this.addedBy;
    data['is_approve'] = this.isApprove;
    data['device_token'] = this.deviceToken;
    data['login_time'] = this.loginTime;
    data['is_logout'] = this.isLogout;
    data['city_id'] = this.cityId;
    data['password_value'] = this.passwordValue;
    data['mpin'] = this.mpin;
    data['business_name'] = this.businessName;
    data['subscription_start'] = this.subscriptionStart;
    data['subscription_end'] = this.subscriptionEnd;
    data['referal_code'] = this.referalCode;
    data['subscription_id'] = this.subscriptionId;
    data['gst'] = this.gst;
    data['shop_address'] = this.shopAddress;
    data['shop_image'] = this.shopImage;
    data['inv_prefix'] = this.invPrefix;
    data['sign_name'] = this.signName;
    data['invoice_image'] = this.invoiceImage;
    data['sign_image'] = this.signImage;
    data['ifsc_code'] = this.ifscCode;
    data['ac_no'] = this.acNo;
    data['bank_name'] = this.bankName;
    data['is_free'] = this.isFree;
    data['google_id'] = this.googleId;
    data['upi_id'] = this.upiId;
    data['qr_code'] = this.qrCode;
    data['terms_cond'] = this.termsCond;
    data['reference_contact'] = this.referenceContact;
    data['branch'] = this.branch;
    data['hospital_id'] = this.hospitalId;
    data['otp'] = this.otp;
    data['expired_at'] = this.expiredAt;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
