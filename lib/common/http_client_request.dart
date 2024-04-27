import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/api_helper_client.dart';
import 'package:health_care/models/blogs_model/blogs_model.dart';
import 'package:health_care/models/generate_qr/generate_qr_model.dart';
import 'package:health_care/models/home_model/home_model.dart';
import 'package:health_care/models/profile_model/profile_model.dart';
import 'package:health_care/models/profile_model/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/client_dialysis_appointment/client_dialysis_appointment_model.dart';
import '../models/common_model.dart';
import '../models/dialysis_product_model/dialysis_product_model.dart';
import '../models/doctor_list_model/doctor_details_model.dart';
import '../models/doctor_list_model/slots_model.dart';
import '../models/profile_model/client_profile_model.dart';
import '../models/send_otp_model/client_login_model.dart';
import '../models/send_otp_model/send_otp_model.dart';
import '../models/user_list_model/patient_details_model.dart';
import '../models/user_list_model/use_prescription_model.dart';
import '../models/user_list_model/user_list_model.dart';

class HttpClientServices {
  ApiBaseClient helper = ApiBaseClient();

  Future<SendOtpModel?> sendOtpAPi({required String mobileNumber}) async {
    Map<String, dynamic> reqBody = {"mobile_number": mobileNumber};
    final response = await helper.postApi('send_otp', reqBody);
    try {
      return SendOtpModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error=========>${e.toString()}");
      }
    }
  }

  Future<ClientLoginModel?> loginApi(
      {required String number, required String otp}) async {
    var pref = await SharedPreferences.getInstance();
    Map<String, dynamic> reqBody = {
      "mobile_number": number,
      "otp": otp,
      // 'device_token': pref.get('deviceToken').toString()
    };
    final response = await helper.postApi('login', reqBody);
    try {
      return ClientLoginModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error=========>${e.toString()}");
      }
    }
  }

  Future<HomeModel?> homeApi() async {
    Map<String, dynamic> reqBody = {};

    final response = await helper.postBearerApi('home', reqBody);
    try {
      return HomeModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<ClientProfileModel?> profileApi() async {
    Map<String, dynamic> reqBody = {};

    final response = await helper.getApi('profile', reqBody);
    try {
      return ClientProfileModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<SettingsModel?> settingsApi() async {
    Map<String, dynamic> reqBody = {};

    final response = await helper.postBearerApi('settings', reqBody);
    try {
      return SettingsModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<BlogsModel?> blogsApi() async {
    Map<String, dynamic> reqBody = {};

    final response = await helper.postBearerApi('blogs', reqBody);
    try {
      return BlogsModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<DoctorDetailsModel?> doctorDetailsApi(
      {required String hospitalId}) async {
    Map<String, dynamic> reqBody = {"doctor_id": hospitalId.toString()};

    final response = await helper.postBearerApi('doctors_details', reqBody);
    try {
      return DoctorDetailsModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<slotsModel?> slotsApi(
      {required String hospitalId,
      required String type,
      required String date}) async {
    Map<String, dynamic> reqBody = {
      "id": hospitalId,
      "type": type,
      "date": date
    };

    final response = await helper.postBearerApi('get_slots', reqBody);
    try {
      return slotsModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<SendOtpModel?> boolAppointmentApi(
      {required String hospitalId,
      required String type,
      required String date,
      required String slots}) async {
    Map<String, dynamic> reqBody = {
      "id": hospitalId,
      "type": type,
      "date": date,
      "slot_time": slots.toString()
    };

    final response = await helper.postBearerApi('book_appointments', reqBody);
    try {
      return SendOtpModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<GenerateQrModel?> generateQrApi() async {
    Map<String, dynamic> reqBody = {};

    final response = await helper.postBearerApi('generate_qr', reqBody);
    try {
      return GenerateQrModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<ClientDialysisAppointmentModel?> clientAppointmentApi({var status}) async {
    Map<String, dynamic> reqBody = {
      "status":status
    };
    final response = await helper.postBearerApi('hospital_appointments', reqBody);
    try {
      return ClientDialysisAppointmentModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<CommonModel?> clientUpdateAppointmentApi({var appointment_id,var slot_time,var date,var status}) async {
    Map<String, dynamic> reqBody = {
      "appointment_id":appointment_id,"slot_time":slot_time,"date":date,"status":status
    };
    final response = await helper.postBearerApi('update_hospital_appointments', reqBody);
    try {
      return CommonModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<UserListModel?> userListApi() async {
    Map<String, dynamic> reqBody = {

    };
    final response = await helper.postBearerApi('users_list', reqBody);
    try {
      return UserListModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<PatientDetailsModel?> patientDetailsApi({var userId}) async {
    Map<String, dynamic> reqBody = {
      "user_id":userId.toString()
    };
    final response = await helper.postBearerApi('patient_details', reqBody);
    try {
      return PatientDetailsModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<UsePrescriptionListModel?> usePrescriptionListApi({var userId,type}) async {
    Map<String, dynamic> reqBody = {
      "user_id":userId.toString(),
      "type":type.toString()
    };
    final response = await helper.postBearerApi('user_prescription_list', reqBody);
    try {
      return UsePrescriptionListModel.fromJson(response);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  Future<DialysisProductModel?>productApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('products_list', reqBody);
    try{
      return DialysisProductModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
