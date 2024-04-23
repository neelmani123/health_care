 import 'dart:convert';
 import 'dart:io';
 import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
 import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    generateQrApi();
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
          Card(
              elevation: 5,
              shape:  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: QrImageView(
                // embeddedImageStyle: QrEmbeddedImageStyle(
                //   size: Size(50, 50)
                // ),
                // embeddedImage: AssetImage('assets/images/camera.png'),
                padding: const EdgeInsets.all(10),
                data: user.toString(),
                version: QrVersions.auto,
                size: 200,
                gapless: false,
              )),
          Visibility(
            visible: scanWidget,
            child: Expanded(
              flex: 4,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child:  CustomUi.primaryButton('Scan', (){
                setState(() {
                  scanWidget=true;
                });
              }, 10, AppColors.primaryColor, AppColors.whiteColor, 12, false),
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




