import 'dart:convert';
import 'dart:io';
import 'package:health_care/screen/authentication_screen/signup_screen1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/models/profile_model/profile_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import '../../common/api_helper.dart';
import '../../common/app_colors.dart';
import '../../common/pref_manager.dart';
import '../../models/signup_model/sign_up_model.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final gender = TextEditingController();
  final dob = TextEditingController();
  final address = TextEditingController();
  final pincode = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final mobile = TextEditingController();
  final emailId = TextEditingController();

  final HttpServices httpServices = HttpServices();
  ProfileUser user = ProfileUser();
  XFile? _imageFiler;
  final ImagePicker _picker = ImagePicker();


  void profileApi() async {
    var res = await httpServices.profileApi();
    if (res!.result == true) {
      setState(() {
        PrefManager.profileDataSave(res);
        user = res.user!;
        nameController.text=res.user!.name.toString();
        gender.text=res.user!.gender.toString();
        dob.text=res.user!.dob.toString();
        address.text=res.user!.address.toString();
        pincode.text=res.user!.pincode.toString();
        state.text=res.user!.stateId.toString();
        city.text=res.user!.cityId.toString();
        emailId.text=res.user!.email.toString();
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }



  Future<String> getToken() async {
    var token = "";
    await PrefManager.getUserData().then((value) => {
          debugPrint("Token------------>${value.token}", wrapWidth: 5000),
         setState(() {
       token = value.token;
         }),
        });
    return token;
  }

  updateProfile() async {
    var token = await getToken();
    print("hfjdhfkdshl"+token);
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    var baseUrl = "${apiBaseHelper.aPPmAINuRL}update_profile";
    var uri = Uri.parse(baseUrl);
    print("hfjdhfkdshl"+baseUrl);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );

    request.headers["authorization"] = "Bearer $token";
    request.fields["name"] = nameController.text.trim().toString();
    request.fields["email"] = emailId.text.trim().toString();
    request.fields["gender"] = gender.text.trim().toString();
    request.fields["dob"] = dob.text.trim().toString();
    request.fields["address"] = address.text.trim().toString();
    request.fields["pincode"] = pincode.text.trim().toString();
    request.fields["state_id"] = state.text.trim().toString();
    request.fields["city_id"] = city.text.trim().toString();
   if(path==null)
     {
       request.fields['image']="";

     }
   else
     {
       print('hjdfhdjhfhd'+path);
       // request.files.add(http.MultipartFile.fromBytes(
       //     'image', File(path).readAsBytesSync(),
       //     filename: path.toString().split('/').last));
     }
    try {
      debugPrint(jsonEncode("REquest=====>"+request.fields.toString()));
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        Get.to(SignUpScrren1());
      } else {
        print("Error========+++>"+response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode}"),
          ),
        );
      }
    } catch (exception) {
      debugPrint("exception:==>$exception");
    }
  }

  Widget bottomSheetSelector() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.camera, color: Colors.red),
                onPressed: () {
                  getImage1(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: const Text(
                  "Camera",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image, color: Colors.red),
                onPressed: () {
                  getImage1(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String path = "";

  void getImage1(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFiler = pickedFile;
      path = _imageFiler!.path;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    profileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          DesignConfig.appBar(context, double.infinity, 'Fill your details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              DesignConfig.space(h: 2.h),
              circleImage(),
              DesignConfig.space(h: 4.h),
              editFieldWidget(),
              DesignConfig.space(h: 3.h),
              buttonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleImage() {
    return Center(
        child: Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: path == ""
              ? NetworkImage(
                      user.image.toString())
                  as ImageProvider
              : FileImage(File(_imageFiler!.path)),
        ),
        Positioned(
            bottom: 0,
            left: 60,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) => bottomSheetSelector());
              },
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor, shape: BoxShape.circle),
                  child: Image.asset(AppImages.editIcon)),
            ))
      ],
    ));
  }

  Widget buttonWidget() {
    return CustomUi.primaryButton('Save', () {
      updateProfile();
    }, 12, AppColors.primaryColor, AppColors.whiteColor, 14, false);
  }

  Widget editFieldWidget() {
    return Column(
      children: [
        CustomUi.editBox('Your name', nameController, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Gender', gender, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('D.O.B', dob, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Address', address, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('PinCode', pincode, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('State', state, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('City', city, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox(
          'Mobile No.',
          mobile,
          TextInputType.number,
        ),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Email id', emailId, TextInputType.emailAddress),
      ],
    );
  }
}
