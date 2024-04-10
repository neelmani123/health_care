import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../models/dialysis_product_model/dialysis_product_model.dart';

class DialysisProductDetailsScreen extends StatefulWidget {
  Products products;
   DialysisProductDetailsScreen({super.key,required this.products});

  @override
  State<DialysisProductDetailsScreen> createState() => _DialysisProductDetailsScreenState();
}

class _DialysisProductDetailsScreenState extends State<DialysisProductDetailsScreen> {
  final textController=TextEditingController();
  final HttpServices httpServices=HttpServices();

  void productEnquiryApi()async{
    var res=await httpServices.productEnquiryApi(productId: widget.products.id.toString(), remarks: textController.text.toString());
    if(res!.result==true)
      {
        setState(() {
          Fluttertoast.showToast(msg: res.message.toString());
          textController.clear();
        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, widget.products.name.toString()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            hospitalDetails(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: CustomText(text: 'Enquiry now',fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.blackColor,)
            ),
            DesignConfig.space(h: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: CustomUi.editBox('Enquiry now', textController, TextInputType.text),
            ),
            DesignConfig.space(h: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: CustomUi.primaryButton('Submit', (){
                if(textController.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Enter enquiry...');
                  }
                else{
                  productEnquiryApi();
                }

              }, 10, AppColors.primaryColor, AppColors.whiteColor, 14, false),
            ),
            DesignConfig.space(h: 1.h),
          ],
        ),
      ),
    );
  }


  Widget hospitalDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(17.px), boxShadow: [
        BoxShadow(
            color: AppColors.blackColor.withOpacity(0.5),
            blurRadius: 1,
            blurStyle: BlurStyle.outer)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(widget.products.image.toString()),fit: BoxFit.cover)),
          ),
          DesignConfig.space(h: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomText(
              text: widget.products.name.toString(),
              color: const Color(0xFF3C3C3C),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          DesignConfig.space(h: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                DesignConfig.space(w: 1.w),
                CustomText(text: '\u{20B9}',color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                DesignConfig.space(w: 0.5.w),
                CustomText(text: widget.products.sellingPrice.toString()+" /-",color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                DesignConfig.space(w: 1.w),
                CustomText(text: widget.products.mrp.toString()+" /-",color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,linethrough: TextDecoration.lineThrough),
              ],
            ),
          ),
          DesignConfig.space(h: 1.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomText(
              text: widget.products.description.toString(),
              color: AppColors.greyColor.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),

        ],
      ),
    );
  }
}
