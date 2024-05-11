class SendOtpModel {
  bool? result;
  var message;
  var sign_up;

  SendOtpModel({this.result, this.message,this.sign_up});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    sign_up = json['sign_up'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['sign_up'] = this.sign_up;
    return data;
  }
}
