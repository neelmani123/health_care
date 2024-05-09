class DialysisSettingsModel {
  bool? result;
  String? message;
  DialysisSettings? settings;

  DialysisSettingsModel({this.result, this.message, this.settings});

  DialysisSettingsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    settings = json['settings'] != null
        ? new DialysisSettings.fromJson(json['settings'])
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

class DialysisSettings {
  Settings? settings;
  List<Machines>? machines;
  List<Dialyzers>? dialyzers;
  List<VascularAccess>? vascularAccess;
  List<DialyzerType>? dialyzerType;
  List<BloodTubingSet>? bloodTubingSet;
  List<Injectables>? injectables;

  DialysisSettings(
      {this.settings,
        this.machines,
        this.dialyzers,
        this.vascularAccess,
        this.dialyzerType,
        this.bloodTubingSet,
        this.injectables});

  DialysisSettings.fromJson(Map<String, dynamic> json) {
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    if (json['machines'] != null) {
      machines = <Machines>[];
      json['machines'].forEach((v) {
        machines!.add(new Machines.fromJson(v));
      });
    }
    if (json['dialyzers'] != null) {
      dialyzers = <Dialyzers>[];
      json['dialyzers'].forEach((v) {
        dialyzers!.add(new Dialyzers.fromJson(v));
      });
    }
    if (json['vascular_access'] != null) {
      vascularAccess = <VascularAccess>[];
      json['vascular_access'].forEach((v) {
        vascularAccess!.add(new VascularAccess.fromJson(v));
      });
    }
    if (json['dialyzer_type'] != null) {
      dialyzerType = <DialyzerType>[];
      json['dialyzer_type'].forEach((v) {
        dialyzerType!.add(new DialyzerType.fromJson(v));
      });
    }
    if (json['blood_tubing_set'] != null) {
      bloodTubingSet = <BloodTubingSet>[];
      json['blood_tubing_set'].forEach((v) {
        bloodTubingSet!.add(new BloodTubingSet.fromJson(v));
      });
    }
    if (json['injectables'] != null) {
      injectables = <Injectables>[];
      json['injectables'].forEach((v) {
        injectables!.add(new Injectables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.machines != null) {
      data['machines'] = this.machines!.map((v) => v.toJson()).toList();
    }
    if (this.dialyzers != null) {
      data['dialyzers'] = this.dialyzers!.map((v) => v.toJson()).toList();
    }
    if (this.vascularAccess != null) {
      data['vascular_access'] =
          this.vascularAccess!.map((v) => v.toJson()).toList();
    }
    if (this.dialyzerType != null) {
      data['dialyzer_type'] =
          this.dialyzerType!.map((v) => v.toJson()).toList();
    }
    if (this.bloodTubingSet != null) {
      data['blood_tubing_set'] =
          this.bloodTubingSet!.map((v) => v.toJson()).toList();
    }
    if (this.injectables != null) {
      data['injectables'] = this.injectables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  int? id;
  String? aboutUs;
  String? privacyPolicy;
  String? terms;

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

class Machines {
  String? key;
  String? value;

  Machines({this.key, this.value});

  Machines.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
class Dialyzers {
  String? key;
  String? value;

  Dialyzers({this.key, this.value});

  Dialyzers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
class VascularAccess {
  String? key;
  String? value;

  VascularAccess({this.key, this.value});

  VascularAccess.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
class DialyzerType {
  String? key;
  String? value;

  DialyzerType({this.key, this.value});

  DialyzerType.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
class BloodTubingSet {
  String? key;
  String? value;

  BloodTubingSet({this.key, this.value});

  BloodTubingSet.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
class Injectables {
  String? key;
  String? value;

  Injectables({this.key, this.value});

  Injectables.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
