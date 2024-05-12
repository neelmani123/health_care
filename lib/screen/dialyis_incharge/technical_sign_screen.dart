import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_signature/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../models/start_dialysis_model/start_dialysis_model.dart';
import 'bp_pluse_spo_screen.dart';

class TechnicalSignScreen extends StatefulWidget {
  StartDialysisAppointment appointment;
   TechnicalSignScreen({super.key,required this.appointment});

  @override
  State<TechnicalSignScreen> createState() => _TechnicalSignScreenState();
}

class _TechnicalSignScreenState extends State<TechnicalSignScreen> {
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Technician Sign'),
      bottomSheet:InkWell(
        onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (_)=>BpPlusSpoScreen(appointment: widget.appointment,)));
        },
        child: Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 30,left: 20,right: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Next',color: AppColors.whiteColor,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignConfig.space(h: 10),
            Center(
              child: SvgPicture.asset('assets/svg/technicalsign.svg'),
            ),
            DesignConfig.space(h: 40),
            CustomText(text: 'Please Sign'),
            DesignConfig.space(h: 20),
            Listener(
              onPointerDown: (_) {
                setState(() {
                  isHovering = true;
                });
              },
              onPointerUp: (_) {
                setState(() {
                  isHovering = false;
                });
              },
              child: getSignatureView(),
            ),

          ],
        ),
      ),
    );
  }

  ValueNotifier<String?> svg = ValueNotifier<String?>(null);

  ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);
  bool isHovering = false;

  ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  Widget getSignatureView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Customer Signature"),
        SizedBox(
          height: 10,
        ),
        Center(
          child: AspectRatio(
            aspectRatio: 2.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  constraints: BoxConstraints.expand(),
                  child: HandSignature(
                    control: control,
                    type: SignatureDrawType.shape,
                  ),
                ),
                CustomPaint(
                  painter: DebugSignaturePainterCP(
                    control: control,
                    cp: false,
                    cpStart: false,
                    cpEnd: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            CupertinoButton(
              onPressed: () {
                control.clear();
                svg.value = null;
                rawImage.value = null;
                rawImageFit.value = null;
              },
              child: Text('clear'),
            ),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
  String _signaturePath = "";


  _saveSignature() async {
    final signatureData = rawImage.value;
    if (signatureData == null) {
      // No signature data available
      return;
    }
    final uint8List = signatureData.buffer.asUint8List();

    final appDir = await getApplicationDocumentsDirectory();
    final imageName = 'signature_image.png';
    final imagePath = '${appDir.path}/$imageName';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(uint8List);

    // Get the URI of the saved image file
    final imageUri = imageFile.uri;
    _signaturePath = getFilePathFromUri(imageUri);

    print("asdasda" + _signaturePath);
  }

  String getFilePathFromUri(Uri fileUri) {
    final file = File.fromUri(fileUri);
    final filePath = file.path;
    return filePath;
  }


  var httpServices = HttpClientServices();

  void startDialysisApiCall() async {
    var prefs = await SharedPreferences.getInstance();
    await _saveSignature();
    var res = await httpServices.startDialysisApi(
      appointment_id: prefs.get('appointment_id').toString(),
      next_appointment_remarks: enter.text.toString(),
    );
    if (res!.result == true) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>BpPlusSpoScreen(appointment: res.appointment!,)));

      });
    }
  }



}
