import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../models/dialysis_product_model/dialysis_product_model.dart';
import 'dialysis_product_details_screen.dart';
class DialysisProductScreen extends StatefulWidget {
  const DialysisProductScreen({super.key});

  @override
  State<DialysisProductScreen> createState() => _DialysisProductScreenState();
}

class _DialysisProductScreenState extends State<DialysisProductScreen> {
  List<Products> products=[];
  final HttpServices httpServices=HttpServices();

  Future productApi()async{
    var res=await httpServices.productApi();
    if(res!.result==true)
      {
        setState(() {
          products=res.products!;
        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    productApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Dialysis Product',
      ),
      body: Column(
        children: [
          DesignConfig.space(h: 2.h),
          Expanded(child: dialysisProductData()),
        ],
      ),
    );
  }

  Widget dialysisProductData() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(DialysisProductDetailsScreen(products: products[index],));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.px),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.5),
                        blurRadius: 1,
                        blurStyle: BlurStyle.outer)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                           image: DecorationImage(image: NetworkImage(products[index].image.toString()),fit: BoxFit.cover)),
                      )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: products[index].name.toString(),color: const Color(0xFF3C3C3C),fontSize: 15,fontWeight: FontWeight.w400,),
                          DesignConfig.space(h: 1.h),
                          Row(
                            children: [
                              DesignConfig.space(w: 1.w),
                              CustomText(text: '\u{20B9}',color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                              DesignConfig.space(w: 0.5.w),
                              CustomText(text: products[index].sellingPrice.toString()+" /-",color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                              DesignConfig.space(w: 1.w),
                              CustomText(text: products[index].mrp.toString()+" /-",color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,linethrough: TextDecoration.lineThrough),
                            ],
                          ),
                          DesignConfig.space(h: 0.5.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              DesignConfig.space(w: 1.w),
                              Expanded(child: CustomText(text: products[index].description.toString(),color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,maxLine: 2,)),

                            ],
                          ),
                        ],
                      )),
                  const Expanded(child: Padding(
                    padding:  EdgeInsets.only(top: 25),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios,color: Color(0xFF666666),size: 14,),
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }
}
