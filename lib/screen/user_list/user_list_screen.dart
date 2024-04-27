import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/http_client_request.dart';
import 'package:health_care/screen/user_list/patient_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../models/user_list_model/user_list_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final HttpClientServices httpClientServices=HttpClientServices();
  List<UsersList> usersList=[];
  bool loading=true;

  void userListApi()async{
    var res=await httpClientServices.userListApi();
    if(res!.result==true)
      {
       setState(() {
         usersList=res.usersList!;
         loading=false;
       });
      }

    else
      {
        Fluttertoast.showToast(msg: res.message.toString());

      }
  }

  @override
  void initState() {
    userListApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'User list'),
      body: Column(
        children: [
          DesignConfig.space(h: 10),
          searchWidget(),
          DesignConfig.space(h: 10),
          Expanded(child: dialysisDataWidget()),

        ],
      ),
    );
  }



  Widget searchWidget() {
    return Container(
        height: 5.h,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F2E9),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: Color(0xFF878B91),
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                  color: Color(0xFF818286),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ));
  }


  Widget dialysisDataWidget() {
    return (loading)?Center(child: CircularProgressIndicator(),):usersList.isEmpty
        ? Center(
      child: CustomText(text: 'No data found..'),
    )
        : ListView.builder(
        itemCount: usersList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(PatentDetailsScreen(userId: usersList[index].userId.toString(),));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.17),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.only(bottom: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      usersList[index].userImage.toString(),
                                    ),
                                    fit: BoxFit.cover)),
                          ),),
                      DesignConfig.space(w: 10),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: usersList[index].userName.toString(),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                              DesignConfig.space(h: 10),
                              Container(
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.5),
                                        width: 1)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/document.svg',
                                      height: 16,
                                    ),
                                    DesignConfig.space(w: 2.w),
                                    CustomText(
                                      text: 'Prescription',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 10,
                                    )
                                  ],
                                ),
                              ),
                              DesignConfig.space(h: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/lastdial.svg',
                                    height: 16,
                                  ),
                                  DesignConfig.space(w: 2.w),
                                  CustomText(
                                    text:
                                    'Last Dialysis(${usersList[index].lastDialysisDate.toString()})',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 10,
                                  )
                                ],
                              ),
                              DesignConfig.space(h: 10),

                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
