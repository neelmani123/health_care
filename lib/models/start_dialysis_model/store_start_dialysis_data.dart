class StoreStartDialysisData
{

  var appointment_id;
  var machine_no;
  var from_where;
  var vascular_access ;
  var dialyzer ;
  var dialyzer_type ;
  var dialyzer_type_text  ;
  var blood_tubing_set;
  var blood_tubing_set_text ;
  var advice ;
  var injectable ;
  var injectible_select ;
  var remarks ;
  var next_appointment_remarks;
  var sign ;
  var bp;
  var pulse;
  var spo2;
  var duration;
  var heperin_unit;
  var mean_blood_flow ;
  var dialysis_solution;
  var pre_dialysis_weight;
  var post_dialysis_weight;
  var total_uf_goal;
  var conductivity;

  StoreStartDialysisData(this.appointment_id,this.machine_no,this.from_where,this.vascular_access);

  StoreStartDialysisData.fromJson(Map<String,dynamic>json){
    appointment_id=json['appointment_id'] as String;
    machine_no=json['machine_no'] as String;
    from_where=json['from_where'] as String;
    vascular_access=json['vascular_access'] as String;
  }

}