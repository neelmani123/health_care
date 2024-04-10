class slotsModel {
  bool? result;
  var message;
  List<Slots>? slots;

  slotsModel({this.result, this.message, this.slots});

  slotsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
 var serial;
  var startTime;
  var endTime;

  Slots({this.serial, this.startTime, this.endTime});

  Slots.fromJson(Map<String, dynamic> json) {
    serial = json['serial'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial'] = this.serial;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
