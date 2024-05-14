import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Notification'),
      body: Column(
        children: [
          notifiicationWidget(),
        ],
      ),
    );
  }




  Widget notifiicationWidget(){
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
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
                  color: AppColors.greyColor.withOpacity(0.5),
                  thickness: 1,
                ),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: 'Payment Successful',fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.blackColor,),
                    CustomText(text: 'You have made a medicine payment',fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.greyColor.withOpacity(0.5),),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.account_balance),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
