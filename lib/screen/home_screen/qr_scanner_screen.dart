 import 'dart:convert';
 import 'dart:io';
 import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/home_screen/qrCOdeScanScreen.dart';
import 'package:permission_handler/permission_handler.dart';
 import 'package:flutter/material.dart';
 import '../../common/pref_manager.dart';
 import '../../models/profile_model/profile_model.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
 import 'package:health_care/common/app_bar.dart';
 import 'package:health_care/common/app_colors.dart';
 import 'package:health_care/common/http_request.dart';

 import 'package:qr_flutter/qr_flutter.dart';

class QrScreenScreen extends StatefulWidget {
  const QrScreenScreen({super.key});

  @override
  State<QrScreenScreen> createState() => _QrScreenScreenState();
}

class _QrScreenScreenState extends State<QrScreenScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final HttpServices  httpServices=HttpServices();
  var user='';

  void generateQrApi()async{
    var res=await httpServices.generateQrApi();
    if(res!.result==true)
      {
        setState(() {
          user=res.user!;
        });
      }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  ProfileUser profileUser=ProfileUser();
  getUserData()async{
    await PrefManager.getprofileData().then((value) => {
      setState((){
        profileUser=value.user!;
      })
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    generateQrApi();
    getUserData();
    super.initState();
  }
  bool scanWidget=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Qr Code'),
      body: Column(
        children: [
          DesignConfig.space(h: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(profileUser.image.toString()),
              ),
              DesignConfig.space(w: 10),
              CustomText(text: profileUser.name.toString(),fontWeight: FontWeight.w500,fontSize: 16,)
            ],
          ),
          DesignConfig.space(h: 10),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration:    BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor3.withOpacity(0.5),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 3
                )
              ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  QrImageView(
                    // embeddedImageStyle: QrEmbeddedImageStyle(
                    //   size: Size(50, 50)
                    // ),
                    // embeddedImage: AssetImage('assets/images/camera.png'),
                    padding: const EdgeInsets.all(10),
                    data: user.toString(),
                    version: QrVersions.auto,
                    size: 250,
                    gapless: false,
                  ),
                  DesignConfig.space(h: 2),
                  CustomText(text: 'Scan To See My Appointment Details',fontSize: 12,color: AppColors.greyColor4,)
                ],
              )),
          // Visibility(
          //   visible: scanWidget,
          //   child: Expanded(
          //     flex: 3,
          //     child: QRView(
          //       key: qrKey,
          //       onQRViewCreated: _onQRViewCreated,
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:  CustomUi.primaryButton('Scan', (){
                  setState(() {
                 //   scanWidget=true;
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>QRCodeScanScreen()));
                  });
                }, 10, AppColors.primaryColor, AppColors.whiteColor, 12, false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data
      Fluttertoast.showToast(msg: scanData.code.toString());
      print("Qr Code Scanner Data=====>"+scanData.code.toString());
    });
  }




}




