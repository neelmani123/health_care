import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/models/profile_model/settings_model.dart';


class CmsProfile extends StatefulWidget {
  final appText;
  const CmsProfile({super.key,this.appText});

  @override
  State<CmsProfile> createState() => _CmsProfileState();
}

class _CmsProfileState extends State<CmsProfile> {

  Settings settings=Settings();
  final HttpServices httpServices=HttpServices();
  void settingsApi()async{
    var res=await httpServices.settingsApi();
    if(res!.result==true)
      {
        setState(() {
          settings=res.settings!;
        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    settingsApi();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, textAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(text: description.toString(),fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.greyColor4,)
          ],
        ),
      ),
    );

  }


  var description="";
  String textAppBar(){
    var text="";

    if(widget.appText=='about')
      {
       setState(() {
         text="About Us";
         description=settings.aboutUs.toString();
       });
      }
    else if(widget.appText=='terms')
      {
       setState(() {
         text="Terms & Conditions";
         description=settings.terms.toString();
       });
      }
    else if(widget.appText=='privacy')
    {
     setState(() {
       text="Privacy Policy";
       description=settings.privacyPolicy.toString();
     });
    }
    return text;
  }
}
