import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/authentication_screen/login_screen.dart';
import 'package:health_care/screen/authentication_screen/signup_screen1.dart';
import 'package:health_care/screen/dashboard/dashboard.dart';
import 'package:image_cropper/image_cropper.dart';
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
  final number;
  const SignUpScreen({super.key,this.number});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final hospitalName = TextEditingController();
  final doctorName = TextEditingController();
  final address = TextEditingController();
  final doctorQualification = TextEditingController();
  final doctorDob = TextEditingController();
  final technionName = TextEditingController();
  final mobile = TextEditingController();
  final technionQualificatioin = TextEditingController();
  final numberOfMachines = TextEditingController();
  final operationTimings = TextEditingController();
  final about = TextEditingController();
  final Services = TextEditingController();

  final HttpServices httpServices = HttpServices();
  ProfileUser user = ProfileUser();
  XFile? _imageFiler;
  final ImagePicker _picker = ImagePicker();




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
    if(widget.number!=null)
      {
        mobile.text=widget.number;
      }
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


  Widget buttonWidget() {
    return CustomUi.primaryButton('Save', () {
      updateProfileApi();
    }, 12, AppColors.primaryColor, AppColors.whiteColor, 14, false);
  }

  Widget editFieldWidget() {
    return Column(
      children: [
        CustomUi.editBox('Name of centre', nameController, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Hospital Name', hospitalName, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Mobile', mobile, TextInputType.number),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Address', address, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Doctor name', doctorName, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Doctor Qualification', doctorQualification, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Doctor D.O.B', doctorDob, TextInputType.text),
        DesignConfig.space(h: 2.h),
        InkWell(
          onTap: (){
            showModalBottomSheet(
                context: context,
                // isScrollControlled: true,
                builder: (builder) {
                  return StatefulBuilder(builder: (BuildContext context,StateSetter setState){
                    return bottomSheetSelector();
                  });
                } );
          },
          child: Container(
            height: 50,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor5, width: 1),
                borderRadius: BorderRadius.circular(11)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomText(text: path==""?'Doctor Photo':path.split('/').last,color: AppColors.greyColor.withOpacity(0.5),fontSize: 10)),
                Icon(Icons.upload,color: AppColors.greyColor.withOpacity(0.5),size: 12,)
              ],
            )
          ),
        ),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Technion name', technionName, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Technion Qualification', technionQualificatioin, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Number of Machines', numberOfMachines, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Operational timings', operationTimings, TextInputType.text),
        DesignConfig.space(h: 2.h),
        InkWell(
          onTap: (){
            selectFile();
          },
          child: Container(
            height: 8.h,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor5, width: 1),
                borderRadius: BorderRadius.circular(11)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: selectedImages.isEmpty?'Select multiple images...':selectedImages.length.toString()+" File selected",color: AppColors.greyColor3,),
                const Icon(Icons.upload_rounded,size: 12,color: AppColors.greyColor3,)
              ],
            )
          ),
        ),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox(
          'Services Provided',
          Services,
          TextInputType.text,
        ),
        DesignConfig.space(h: 2.h),
        Container(
          height: 15.h,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10.px),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor5, width: 1),
              borderRadius: BorderRadius.circular(11)),
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'About the clinic/hospital',
                //contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA1A1A1),
                    fontWeight: FontWeight.w400)),
          ),
        )
      ],
    );
  }



  updateProfileApi() async {
    var baseUrl = "https://client.kidneymitr.com/api/v1/register";
    var uri = Uri.parse(baseUrl);
    Map<String, String> headers = {
      "Accept": "application/json",
      // "Authorization": "Bearer " + box.read('token')
    };
    
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    request.fields['phone'] = mobile.text.toString();
    request.fields['name_of_center'] = nameController.text.toString();
    request.fields['name_of_hospital'] = hospitalName.text.toString();
    request.fields['adress'] = address.text.toString();
    request.fields['doctor_name'] = doctorName.text.toString();
    request.fields['doctor_qualification'] =doctorQualification.text.toString();
    request.fields['doctor_dob'] =doctorDob.text.toString();
    request.fields['technitian_name'] =technionName.text.toString();
    request.fields['technitian_qualification'] =technionName.text.toString();
    request.fields['no_of_machines'] =numberOfMachines.text.toString();
    request.fields['operational_timmings'] =operationTimings.text.toString();
    request.fields['service_provided'] =Services.text.toString();
    request.fields['about'] =about.text.toString();
    request.files.add(http.MultipartFile.fromBytes(
        'doctor_image', File(path).readAsBytesSync(),
        filename: path
            .toString()
            .split('/')
            .last));

    for (int i = 0; i < selectedImages.length; i++) {
      var image = selectedImages[i];
      var filename = image.path.split('/').last;
      request.files.addAll([
        http.MultipartFile.fromBytes(
          'clinic_images[]',
          await image.readAsBytes(),
          filename: filename,
        ),
      ]);
    }
    try {
      debugPrint("Request fields:==> ${request.fields}");
      debugPrint("Request file:==> ${request.files}");
      http.Response response = await http.Response.fromStream(
          await request.send());
      debugPrint(
          "************************************************************\n\n\n");
      debugPrint("\t\t\t\t Status Code:--> ${response.statusCode}");
      debugPrint("\t\t\t\t Response Body:--> ${response.body}");
      debugPrint(
          "************************************************************\n\n\n");
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        setState(() {
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(
            SnackBar(content: Text("${jsonDecode(response.body)['message']}")));
        Get.offAll(LoginScreen());
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.statusCode}")));
      }
    } catch (exception) {
      setState(() {
      });
      debugPrint("exception:==>$exception");
    }
  }

  File? selectedImage;
  List<File> selectedImages = [];

  String fileName = "",Filepath = "";
  CroppedFile? _croppedFile;
  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true);
    if (result != null) {
      for (PlatformFile file in result.files) {
       setState(() {
         String filePath = file.path!;
         selectedImages.add(File(file.path.toString()));
         List<String> nameList=[];
       });
        selectedImages.forEach((element) {

        });
      }
    } else {
      // User canceled the picker
    }

    return selectedImages;
  }


}
