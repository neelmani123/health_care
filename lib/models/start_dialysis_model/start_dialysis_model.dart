class StartDialysisModel {
  bool? result;
  var message;
  Appointment? appointment;

  StartDialysisModel({this.result, this.message, this.appointment});

  StartDialysisModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = result;
    data['message'] = message;
    if (appointment != null) {
      data['appointment'] = appointment!.toJson();
    }
    return data;
  }
}

class Appointment
{

  var id;
  var hospitalId;
  var doctorId;
  var userId;
  var type;
  var slotTime;
  var date;
  var prescription;
  var appointmentStatus;
  var updatedBy;
  var status;
  var createdAt;
  var updatedAt;
  var isChange;
  var machineNo;
  var fromWhere;
  var vascularAccess;
  var dialyzer;
  var dialyzerType;
  var dialyzerTypeText;
  var bloodTubingSet;
  var bloodTubingSetText;
  var advice;
  var injectable;
  var injectibleSelect;
  var remarks;
  var nextAppointmentRemarks;
  var sign;
  var bp;
  var pulse;
  var spo2;
  var duration;
  var heperinUnit;
  var meanBloodFlow;
  var dialysisSolution;
  var preDialysisWeight;
  var postDialysisWeight;
  var totalUfGoal;
  var conductivity;

  Appointment(
      {this.id,
      this.hospitalId,
      this.doctorId,
      this.userId,
      this.type,
      this.slotTime,
      this.date,
      this.prescription,
      this.appointmentStatus,
      this.updatedBy,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isChange,
      this.machineNo,
      this.fromWhere,
      this.vascularAccess,
      this.dialyzer,
      this.dialyzerType,
      this.dialyzerTypeText,
      this.bloodTubingSet,
      this.bloodTubingSetText,
      this.advice,
      this.injectable,
      this.injectibleSelect,
      this.remarks,
      this.nextAppointmentRemarks,
      this.sign,
      this.bp,
      this.pulse,
      this.spo2,
      this.duration,
      this.heperinUnit,
      this.meanBloodFlow,
      this.dialysisSolution,
      this.preDialysisWeight,
      this.postDialysisWeight,
      this.totalUfGoal,
      this.conductivity});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    type = json['type'];
    slotTime = json['slot_time'];
    date = json['date'];
    prescription = json['prescription'];
    appointmentStatus = json['appointment_status'];
    updatedBy = json['updated_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isChange = json['is_change'];
    machineNo = json['machine_no'];
    fromWhere = json['from_where'];
    vascularAccess = json['vascular_access'];
    dialyzer = json['dialyzer'];
    dialyzerType = json['dialyzer_type'];
    dialyzerTypeText = json['dialyzer_type_text'];
    bloodTubingSet = json['blood_tubing_set'];
    bloodTubingSetText = json['blood_tubing_set_text'];
    advice = json['advice'];
    injectable = json['injectable'];
    injectibleSelect = json['injectible_select'];
    remarks = json['remarks'];
    nextAppointmentRemarks = json['next_appointment_remarks'];
    sign = json['sign'];
    bp = json['bp'];
    pulse = json['pulse'];
    spo2 = json['spo2'];
    duration = json['duration'];
    heperinUnit = json['heperin_unit'];
    meanBloodFlow = json['mean_blood_flow'];
    dialysisSolution = json['dialysis_solution'];
    preDialysisWeight = json['pre_dialysis_weight'];
    postDialysisWeight = json['post_dialysis_weight'];
    totalUfGoal = json['total_uf_goal'];
    conductivity = json['conductivity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['hospital_id'] = hospitalId;
    data['doctor_id'] = doctorId;
    data['user_id'] = userId;
    data['type'] = type;
    data['slot_time'] = slotTime;
    data['date'] = date;
    data['prescription'] = prescription;
    data['appointment_status'] = appointmentStatus;
    data['updated_by'] = updatedBy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_change'] = isChange;
    data['machine_no'] = machineNo;
    data['from_where'] = fromWhere;
    data['vascular_access'] = vascularAccess;
    data['dialyzer'] = dialyzer;
    data['dialyzer_type'] = dialyzerType;
    data['dialyzer_type_text'] = dialyzerTypeText;
    data['blood_tubing_set'] = bloodTubingSet;
    data['blood_tubing_set_text'] = bloodTubingSetText;
    data['advice'] = advice;
    data['injectable'] = injectable;
    data['injectible_select'] = injectibleSelect;
    data['remarks'] = remarks;
    data['next_appointment_remarks'] = nextAppointmentRemarks;
    data['sign'] = sign;
    data['bp'] = bp;
    data['pulse'] = pulse;
    data['spo2'] = spo2;
    data['duration'] = duration;
    data['heperin_unit'] = heperinUnit;
    data['mean_blood_flow'] = meanBloodFlow;
    data['dialysis_solution'] = dialysisSolution;
    data['pre_dialysis_weight'] = preDialysisWeight;
    data['post_dialysis_weight'] = postDialysisWeight;
    data['total_uf_goal'] = totalUfGoal;
    data['conductivity'] = conductivity;
    return data;
  }
}
