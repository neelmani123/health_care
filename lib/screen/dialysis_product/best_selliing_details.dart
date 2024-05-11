import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_client_request.dart';
import '../../common/http_request.dart';
import '../../models/dialysis_product_model/dialysis_product_model.dart';
import '../../models/home_model/home_model.dart';

class BestSellingsDetails extends StatefulWidget {
   BestSellingsDetails({super.key,});

  @override
  State<BestSellingsDetails> createState() => _BestSellingsDetailsState();
}

class _BestSellingsDetailsState extends State<BestSellingsDetails> {
  List<Products> products=[];
  final HttpServices httpServices=HttpServices();
  final HttpClientServices httpClientServices = HttpClientServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Best Sellings'),
      body: RefreshIndicator(
        onRefresh: productApi,
        child: Column(
          children: [
            bestSellingsWidget(),
          ],
        ),
      ),
    );
  }


  Future productApi()async{
    var prefs = await SharedPreferences.getInstance();
    var res;
    if (prefs.get('login_type').toString() == "client") {
      res = await httpClientServices.productApi();
    } else {
      res=await httpServices.productApi();
    }
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





  Widget bestSellingsWidget() {
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 2.0, // spacing between rows
              crossAxisSpacing: 2.0, // spacing between columns
              mainAxisExtent: 170),
          itemCount: products.length,
          itemBuilder: (contex, index) {
            var name=
                products[index].name
                .toString();
            if(name.length>=18)
            {
              name=products[index].name
                  .toString().substring(0,18);
            }
            return InkWell(
              onTap: () {
              },
              child:  Container(
                height: 180,
                width: 180,
                margin:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.6),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 4,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DesignConfig.space(h: 1.h),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(products[index].image
                                  .toString()),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    DesignConfig.space(h: 1.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(
                        text: name.toString(),
                        color: const Color(0xFF333333),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DesignConfig.space(h: 0.5.h),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.yellowColor, size: 18),
                            DesignConfig.space(w: 5),
                            CustomText(
                              text:products[index].ratings
                                  .toString(),
                              color: const Color(0xFF333333),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        )),
                    DesignConfig.space(h: 1.h),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 0.5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: CustomText(
                                text: 'Raise a Querry',
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            products[index].is_wishlist == 1
                                ? Image.asset(
                              'assets/images/heart_fill.png',
                              height: 15,
                            )
                                : Image.asset(
                              'assets/images/heart.png',
                              height: 15,
                            )
                          ],
                        )),
                  ],
                ),
              )
            );
          }),
    );
  }
}
