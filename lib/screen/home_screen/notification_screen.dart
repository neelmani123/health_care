import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_client_request.dart';
import 'package:health_care/common/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification_model/notification_list_model.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  List<NotificationList> notificationData=[];
  final HttpClientServices clientRequest=HttpClientServices();
  final HttpServices httpServices=HttpServices();
  bool loading=true;

  void notificationApi()async{
    var prefs=await SharedPreferences.getInstance();
    var res;
    if(prefs.get('login_type').toString()=="client"){
      res=await clientRequest.notificationApi();
      if(res!.result==true)
        {
          setState(() {
            notificationData=res.notificationList;
            loading=false;
          });

        }
    }
    else
      {
        res=await httpServices.notificationApi();
        if(res!.result==true)
          {
            setState(() {
              notificationData=res.notificationList;
              loading=false;
            });
          }
      }

  }


  @override
  void initState() {
    // TODO: implement initState
    notificationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Notification'),
      body: (loading)?Center(child: CircularProgressIndicator(),):notificationData.isEmpty?Center(child: CustomText(text: 'No data found...'),):Column(
        children: [
          notifiicationWidget(),
        ],
      ),
    );
  }




  Widget notifiicationWidget(){
    return Expanded(
      child: ListView.builder(
        itemCount: notificationData.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return Container(
          height: 50,
          padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.25),
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer
                )
              ]
            ),
          child:  IntrinsicHeight(
            child: Row(
              children: [
                Icon(Icons.person),
                VerticalDivider(
                  color: AppColors.greyColor.withOpacity(0.2),
                  thickness: 1,
                ),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: notificationData[index].title.toString(),fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.blackColor,),
                    CustomText(text: notificationData[index].description.toString(),fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.greyColor.withOpacity(0.5),maxLine: 2,),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/svg/notiround.svg'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
