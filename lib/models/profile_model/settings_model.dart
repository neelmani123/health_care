class SettingsModel {
  bool? result;
  var message;
  Settings? settings;

  SettingsModel({this.result, this.message, this.settings});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Settings {
  int? id;
  var aboutUs;
  var privacyPolicy;
  var terms;

  Settings({this.id, this.aboutUs, this.privacyPolicy, this.terms});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutUs = json['about_us'];
    privacyPolicy = json['privacy_policy'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about_us'] = this.aboutUs;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms'] = this.terms;
    return data;
  }
}
