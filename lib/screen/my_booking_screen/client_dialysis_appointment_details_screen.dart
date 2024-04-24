import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';

class ClientDialysisAppointmentDetailsScreen extends StatefulWidget {
  const ClientDialysisAppointmentDetailsScreen({super.key});

  @override
  State<ClientDialysisAppointmentDetailsScreen> createState() =>
      _ClientDialysisAppointmentDetailsScreenState();
}

class _ClientDialysisAppointmentDetailsScreenState
    extends State<ClientDialysisAppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor3,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                )
              ]),
              child: Column(
                children: [
                  userDetails(),

                  userAddress()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userDetails() {
    return Container(
        margin: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
          BoxShadow(
            color: AppColors.greyColor3,
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          )
        ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Container(
                height: 70,
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryColor,width: 3),
                    image: DecorationImage(
                        image: NetworkImage(''),
                        fit: BoxFit.cover)),
              ),),
              Expanded(
                flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                 Row(
                   children: [
                     CustomText(text: 'Name:',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                     SizedBox(width: 20,),
                     CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                   ],
                 ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CustomText(text: 'Mobile :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                      SizedBox(width: 20,),
                      CustomText(text: '9865321548',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CustomText(text: 'Address :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                      SizedBox(width: 20,),
                      CustomText(text: 'Sector 16 ',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                    ],
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                CustomText(text: 'Allergies :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                SizedBox(width: 20,),
                CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                CustomText(text: 'Chronic illness :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                SizedBox(width: 20,),
                CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget userAddress(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: CustomText(text: 'Address :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                  flex: 2,
                  child: CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                  child: CustomText(text: 'Last Pay :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                  child: CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                  child: CustomText(text: 'Last Pay :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                  flex: 2,
                  child: CustomText(text: 'Rohit kaur(9148)',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
        ],
      ),
    );
  }


}
