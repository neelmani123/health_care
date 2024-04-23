class GenerateQrModel {
  bool? result;
  String? message;
  String? user;

  GenerateQrModel({this.result, this.message, this.user});

  GenerateQrModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['user'] = this.user;
    return data;
  }
}
