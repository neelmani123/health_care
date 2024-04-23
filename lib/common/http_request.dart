import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/models/blogs_model/blogs_model.dart';
import 'package:health_care/models/generate_qr/generate_qr_model.dart';
import 'package:health_care/models/home_model/home_model.dart';
import 'package:health_care/models/profile_model/profile_model.dart';
import 'package:health_care/models/profile_model/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dialysis_centre_model/dialysis_centre_details_model.dart';
import '../models/dialysis_centre_model/dialysis_centre_model.dart';
import '../models/dialysis_product_model/dialysis_product_model.dart';
import '../models/dialysis_product_model/prescription_model.dart';
import '../models/doctor_list_model/doctor_details_model.dart';
import '../models/doctor_list_model/doctor_list_model.dart';
import '../models/doctor_list_model/my_booking_model.dart';
import '../models/doctor_list_model/my_wish_lost_model.dart';
import '../models/doctor_list_model/slots_model.dart';
import '../models/send_otp_model/login_model.dart';
import '../models/send_otp_model/send_otp_model.dart';
import '../models/signup_model/sign_up_model.dart';
import 'api_helper.dart';

class HttpServices {
  ApiBaseHelper helper = ApiBaseHelper();
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

  Future<LoginModel?> loginApi(
      {required String number, required String otp}) async {
    var pref = await SharedPreferences.getInstance();
    Map<String, dynamic> reqBody = {
      "mobile_number": number,
      "otp": otp,
     // 'device_token': pref.get('deviceToken').toString()
    };
    final response = await helper.postApi('login', reqBody);
    try {
      return LoginModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error=========>${e.toString()}");
      }
    }
  }
  
  
  Future<HomeModel?>homeApi()async{
    Map<String, dynamic> reqBody = {};
    
    final response=await helper.postBearerApi('home', reqBody);
    try{
      return HomeModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<ProfileModel?>profileApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.getApi('profile', reqBody);
    try{
      return ProfileModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<SignupSettingsModel?>signupSettingsApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('signup_settings', reqBody);
    try{
      return SignupSettingsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<SettingsModel?>settingsApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('settings', reqBody);
    try{
      return SettingsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<BlogsModel?>blogsApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('blogs', reqBody);
    try{
      return BlogsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<SendOtpModel?>productEnquiryApi({required String productId,required String remarks})async{
    Map<String, dynamic> reqBody = {
      "product_id":productId,"remarks":remarks
    };

    final response=await helper.postBearerApi('product_enquire', reqBody);
    try{
      return SendOtpModel.fromJson(response);
    }
    catch(e)
    {
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

  Future<PrescriptionModel?>prescriptionApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('prescription_list', reqBody);
    try{
      return PrescriptionModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<DialysisCentreModel?>dialysisCentreApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('dialysis_center', reqBody);
    try{
      return DialysisCentreModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  Future<DoctorListModel?>doctorListApi()async{
    Map<String, dynamic> reqBody = {};

    final response=await helper.postBearerApi('doctors_list', reqBody);
    try{
      return DoctorListModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }




  Future<DialysisCentreDetailsModel?>dialysisCentreDetailsApi({required String hospitalId})async{
    Map<String, dynamic> reqBody = {
      "hospital_id":hospitalId.toString()
    };

    final response=await helper.postBearerApi('dialysis_center_details', reqBody);
    try{
      return DialysisCentreDetailsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<DoctorDetailsModel?>doctorDetailsApi({required String hospitalId})async{
    Map<String, dynamic> reqBody = {
      "doctor_id":hospitalId.toString()
    };

    final response=await helper.postBearerApi('doctors_details', reqBody);
    try{
      return DoctorDetailsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<slotsModel?>slotsApi({required String hospitalId,required String type,required String date})async{
    Map<String, dynamic> reqBody = {
      "id":hospitalId,
      "type":type,
      "date":date
    };

    final response=await helper.postBearerApi('get_slots', reqBody);
    try{
      return slotsModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  Future<SendOtpModel?>boolAppointmentApi({required String hospitalId,required String type,required String date,required String slots})async{
    Map<String, dynamic> reqBody = {
      "id":hospitalId,
      "type":type,
      "date":date,
      "slot_time":slots.toString()
    };

    final response=await helper.postBearerApi('book_appointments', reqBody);
    try{
      return SendOtpModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<SendOtpModel?>wishListApi({required String id,required String type})async{
    Map<String, dynamic> reqBody = {
      "id":id,
      "type":type,
    };

    final response=await helper.postBearerApi('wishlist', reqBody);
    try{
      return SendOtpModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<MyBookingModel?>myAppointmentApi({required String status})async{
    Map<String, dynamic> reqBody = {
      "status":status,

    };

    final response=await helper.postBearerApi('my_appointments', reqBody);
    try{
      return MyBookingModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<MyWishListModel?>myWishListApi({required String type})async{
    Map<String, dynamic> reqBody = {
      "type":type,

    };

    final response=await helper.postBearerApi('my_wishlist', reqBody);
    try{
      return MyWishListModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<GenerateQrModel?>generateQrApi()async{
    Map<String, dynamic> reqBody = {


    };

    final response=await helper.postBearerApi('generate_qr', reqBody);
    try{
      return GenerateQrModel.fromJson(response);
    }
    catch(e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
