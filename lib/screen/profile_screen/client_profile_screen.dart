import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/app_strings.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/authentication_screen/identity_screen.dart';
import 'package:health_care/screen/authentication_screen/signup_screen.dart';
import 'package:health_care/screen/cms_screen/cms_screen.dart';
import 'package:health_care/screen/my_booking_screen/my_booking_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/pref_manager.dart';
import '../../models/profile_model/client_profile_model.dart';
import '../../models/profile_model/profile_model.dart';
import '../my_booking_screen/my_wish_list_screen.dart';
import '../user_list/user_list_screen.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  CleintUser user=CleintUser();
  getUserData()async{
    await PrefManager.getClientprofileData().then((value) => {
      setState((){
        user=value.user!;
      })
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            hearderWidget(),
            DesignConfig.space(h: 2.h),
            iconsText(),
            DesignConfig.space(h: 5.h),
            cmsWidget(),
            DesignConfig.space(h: 2.h),
          ],
        ),
      ),
    );
  }

  Widget hearderWidget(){
    return Container(
      //height: 20.h,
      padding: EdgeInsets.only(bottom: 15,left: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blackColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DesignConfig.space(h: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomText(text: AppStrings.myProfile,fontWeight: FontWeight.w500,fontSize: 15,color: AppColors.whiteColor,),
          ),
          DesignConfig.space(h: 2.h),

          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFBFB5FF),
                child: CircleAvatar(
                  radius: 46,
                  backgroundImage: NetworkImage(user.image.toString()),
                ),
              ),
              DesignConfig.space(w: 20),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: user.name==null?"Guest User":user.name.toString(),fontWeight: FontWeight.w700,fontSize: 20,color: AppColors.whiteColor,),

                    CustomText(text: user.email==null?"":user.email,fontWeight: FontWeight.w400,fontSize: 11,color: Color(0xFF828488),),
                    DesignConfig.space(h: 7),
                    CustomText(text: 'Registered Since ${user.registeredAt.toString()}',fontWeight: FontWeight.w400,fontSize: 13,color:AppColors.whiteColor,),
                  ],
                ),
              ),
              IconButton(onPressed: (){
                Get.to(SignUpScreen());
              }, icon:  SvgPicture.asset('assets/images/edit1.svg'),)
              // Padding(
              //   padding: const EdgeInsets.only(right: 20,bottom: 20),
              //   child:
              // )
            ],
          )
        ],
      ),
    );
  }

  Widget iconsText(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
            //  Get.to(MyBookingScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/myBooking.svg'),
                DesignConfig.space(w: 20),
                Expanded(
                    flex: 2,
                    child: CustomText(text: AppStrings.myOrder,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,))
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          InkWell(
            onTap: (){
            //  Get.to(MyWishListScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/icon8.svg'),
                DesignConfig.space(w: 20),
                Expanded(
                    flex: 2,
                    child: CustomText(text: AppStrings.myWishlist,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,))
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          InkWell(
            onTap: (){
              Get.to(UserListScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/icon6.svg'),
                DesignConfig.space(w: 20),
                CustomText(text: AppStrings.clientMyPres,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          InkWell(
            onTap: (){
              Get.to(UserListScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/icon5.svg'),
                DesignConfig.space(w: 20),
                CustomText(text: AppStrings.clientMyLab,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),

          DesignConfig.space(h: 2.h),

          InkWell(
            onTap: (){
              Get.to(UserListScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/icon9.svg'),
                DesignConfig.space(w: 20),
                CustomText(text: AppStrings.clientDoctorCons,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          Row(
            children: [
              SvgPicture.asset('assets/drawer/Icon1.svg'),
              DesignConfig.space(w: 20),
              CustomText(text: AppStrings.yourAddress,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
            ],
          ),

          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          Row(
            children: [
              SvgPicture.asset('assets/drawer/icon2.svg'),
              DesignConfig.space(w: 20),
              CustomText(text: AppStrings.invite,fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
            ],
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
          DesignConfig.space(h: 2.h),
          InkWell(
            onTap: (){
              PrefManager.clearPrefs();
              Get.offAll(const IdentityScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/drawer/icon10.svg'),
                DesignConfig.space(w: 20),
                CustomText(text: AppStrings.logout,fontSize: 17,fontWeight: FontWeight.w700,color: AppColors.blackColor,)
              ],
            ),
          ),
          DesignConfig.space(h: 2.h),
          DesignConfig.divider(Color(0xFFEFEDE9), 0, 0.8),
        ],

      ),
    );
  }


  Widget cmsWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFADEAFF)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                Get.to(CmsProfile(appText: 'about',));
              },
              child: CustomText(text: 'About Us',fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xFF151921),)),
          dottedWidget(),
          InkWell(
              onTap: (){
                Get.to(CmsProfile(appText: 'privacy',));
              },
              child: CustomText(text: 'Privacy Policy',fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xFF151921),)),
          // DesignConfig.space(h: 1.h),
          dottedWidget(),
          // DesignConfig.space(h: 0.5.h),
          InkWell(
              onTap: (){
                Get.to(CmsProfile(appText: 'terms',));
              },
              child: CustomText(text: 'Terms and Conditions',fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xFF151921),)),

        ],
      ),
    );
  }

  Widget dottedWidget(){
    return Divider(
      color: AppColors.blackColor,
      thickness: 1,
    );
  }
}
