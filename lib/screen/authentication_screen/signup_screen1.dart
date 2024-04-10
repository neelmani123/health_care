import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_ui.dart';
import '../../common/http_request.dart';
import '../../models/signup_model/sign_up_model.dart';

class SignUpScrren1 extends StatefulWidget {
  const SignUpScrren1({super.key});

  @override
  State<SignUpScrren1> createState() => _SignUpScrren1State();
}

class _SignUpScrren1State extends State<SignUpScrren1> {
  final weight = TextEditingController();
  final height = TextEditingController();
  final bloodGroup = TextEditingController();
  final dialysisDate = TextEditingController();
  int _radioSelected = 0;
  int _radioSelected1 = 0;
  int _radioSelected2 = 0;
  String? hivValue, hepatitiesValue, hepatitiesValue1;
  List<Allergies> allergies = [];
  List<ChronicIllness> chronicIllness = [];
  final HttpServices httpServices = HttpServices();

  void signupSettingsApi() async {
    var res = await httpServices.signupSettingsApi();
    if (res!.result == true) {
      setState(() {
        allergies = res.allergies!;
        chronicIllness = res.chronicIllness!;
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    signupSettingsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          DesignConfig.appBar(context, double.infinity, 'Fill your details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              editFieldWidget(),
              DesignConfig.space(h: 3.h),
              buttonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  List<int> selectedIndexes = [];

  Widget bottomSheetAllergies(StateSetter setState) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          DesignConfig.space(h: 2.h),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              CustomText(
                  text: 'Fill your details',
                  // color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 15.71.px,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500),
            ],
          ),
          Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                      mainAxisExtent: 40),
                  itemCount: allergies.length,
                  itemBuilder: (contex, index) {
                    var isSelected;
                    isSelected = selectedIndexes.contains(index);
                    return InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedIndexes.remove(index);
                            } else {
                              selectedIndexes.add(index);
                              print("jgchgjdgfjgdfg" +
                                  selectedIndexes[index].toString());
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Color(0xFFBEBEBE),
                                  width: 1)),
                          child: CustomText(
                            text: allergies[index].name.toString(),
                            color: Color(0xFFA1A1A1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ));
                  })),
          DesignConfig.space(h: 3.h),
          buttonWidget(),
        ],
      ),
    );
  }

  Widget bottomSheetchronic() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          DesignConfig.space(h: 2.h),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              CustomText(
                  text: 'Fill your details',
                  // color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 15.71.px,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500),
            ],
          ),
          Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                      mainAxisExtent: 40),
                  itemCount: chronicIllness.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color(0xFFBEBEBE), width: 1)),
                          child: CustomText(
                            text: chronicIllness[index].name.toString(),
                            color: Color(0xFFA1A1A1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ));
                  })),
          buttonWidget(),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return CustomUi.primaryButton('Save', () {}, 12, AppColors.primaryColor,
        AppColors.whiteColor, 14, false);
  }

  Widget editFieldWidget() {
    return Column(
      children: [
        CustomUi.editBox('Your name', weight, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('Gender', height, TextInputType.text),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox('D.O.B', bloodGroup, TextInputType.text),
        DesignConfig.space(h: 2.h),
        hivWidget(),
        DesignConfig.space(h: 2.h),
        hepatitisWidget(),
        DesignConfig.space(h: 2.h),
        hepatitis1Widget(),
        DesignConfig.space(h: 2.h),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                // isScrollControlled: true,
                builder: (builder) {
                  return StatefulBuilder(builder: (BuildContext context,StateSetter setState){
                    return bottomSheetAllergies(setState);
                  });
                } );
          },
          child: Container(
              height: 8.h,
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor5, width: 1),
                  borderRadius: BorderRadius.circular(11)),
              child: Row(
                children: [
                  CustomText(
                    text: 'Allergies',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA1A1A1),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 12, color: Color(0xFFA1A1A1))
                ],
              )),
        ),
        DesignConfig.space(h: 2.h),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                // isScrollControlled: true,
                builder: (builder) => bottomSheetchronic());
          },
          child: Container(
              height: 8.h,
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor5, width: 1),
                  borderRadius: BorderRadius.circular(11)),
              child: Row(
                children: [
                  CustomText(
                    text: 'Chronic illness',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA1A1A1),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 12, color: Color(0xFFA1A1A1))
                ],
              )),
        ),
        DesignConfig.space(h: 2.h),
        CustomUi.editBox(
            'On dialysis since date', dialysisDate, TextInputType.text),
      ],
    );
  }

  Widget hivWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 6.h,
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor5, width: 1),
                borderRadius: BorderRadius.circular(11)),
            child: CustomText(
              text: 'HIV +',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA1A1A1),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: 1,
                groupValue: _radioSelected,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _radioSelected = value!;
                    hivValue = 'yes';
                  });
                },
              ),
              CustomText(
                text: 'YES',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
              Radio(
                value: 2,
                groupValue: _radioSelected,
                activeColor: Colors.pink,
                onChanged: (value) {
                  setState(() {
                    _radioSelected = value!;
                    hivValue = 'no';
                  });
                },
              ),
              CustomText(
                text: 'NO',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget hepatitisWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 6.h,
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor5, width: 1),
                borderRadius: BorderRadius.circular(11)),
            child: CustomText(
              text: 'Hepatitis C',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA1A1A1),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: 1,
                groupValue: _radioSelected1,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _radioSelected1 = value!;
                    hepatitiesValue = 'yes';
                  });
                },
              ),
              CustomText(
                text: 'YES',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
              Radio(
                value: 2,
                groupValue: _radioSelected1,
                activeColor: Colors.pink,
                onChanged: (value) {
                  setState(() {
                    _radioSelected1 = value!;
                    hepatitiesValue = 'no';
                  });
                },
              ),
              CustomText(
                text: 'NO',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget hepatitis1Widget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 6.h,
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor5, width: 1),
                borderRadius: BorderRadius.circular(11)),
            child: CustomText(
              text: 'Hepatitis B',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA1A1A1),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: 1,
                groupValue: _radioSelected2,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _radioSelected2 = value!;
                    hepatitiesValue1 = 'yes';
                  });
                },
              ),
              CustomText(
                text: 'YES',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
              Radio(
                value: 2,
                groupValue: _radioSelected2,
                activeColor: Colors.pink,
                onChanged: (value) {
                  setState(() {
                    _radioSelected2 = value!;
                    hepatitiesValue1 = 'no';
                  });
                },
              ),
              CustomText(
                text: 'NO',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA1A1A1),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Item {
  bool isSelected = false;

  Item({required this.isSelected});
}
