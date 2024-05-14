import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../models/doctor_list_model/my_wish_lost_model.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({super.key});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen>with TickerProviderStateMixin {
  final HttpServices httpServices =HttpServices();
  List<Wishlists> wishlists=[];
  late TabController tabController;
  var type='hospital';


  void wishApi(String id,String type)async{
    var res=await httpServices.wishListApi(type: type,id: id);
    if(res!.result==true)
      {
        setState(() {
          Fluttertoast.showToast(msg: res.message.toString());
          wishListApi(type.toString());

        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
  }
  void wishListApi(String type)async{
    var res=await httpServices.myWishListApi(type: type);
    if(res!.result==true)
      {
        setState(() {
          wishlists=res.wishlists!;
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
    tabController = TabController(length: 3, vsync: this);
    wishListApi('doctor');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'My Wishlist',
      ),
      body: Column(
        children: [
          TabBar(
              onTap: (val){
                if(val==0)
                {
                  setState(() {
                    wishListApi('doctor');
                    type="doctor";
                  });


                }
                else if(val==1)
                {
                  setState(() {
                    wishListApi('hospital');
                    type="hospital";
                  });

                }
                else if(val==2)
                {
                  setState(() {
                    wishListApi('product');
                    type="product";
                  });

                }
              },
              isScrollable: false,
              controller: tabController, tabs: const [
            Tab(
              text: 'Doctor',
            ),
            Tab(
              text: 'Hospital',
            ),
            Tab(
              text: 'Product',
            ),
          ]),
          Expanded(child: wishlists.isEmpty?Center(child: CustomText(text: 'No data found..'),):wishListData())
        ],
      ),
    ));
  }

  Widget wishListData() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: wishlists.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              //Get.to( BookHospitalAppointment(hospitalId: dialysisCenter[index].id.toString(),));
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
                            image: DecorationImage(image: NetworkImage(wishlists[index].image.toString()))),
                      )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: (){

                                  wishApi(wishlists[index].typeId.toString(),type.toString());
                                }, icon: SvgPicture.asset('assets/svg/heart.svg'))
                          ),
                          CustomText(text: wishlists[index].name.toString(),color: const Color(0xFF3C3C3C),fontSize: 15,fontWeight: FontWeight.w400,),
                          DesignConfig.space(h: 1.h),
                          Row(
                            children: [
                            const Icon(Icons.star,size: 10,color: AppColors.yellowColor,),
                              DesignConfig.space(w: 2.w),
                              //CustomText(text: 'Last Dialysis (${appointments[index].lastDialysis.toString()})',fontWeight: FontWeight.w400,color: Color(0xFF7A7A7A),fontSize: 10,)
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
