import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care/common/custom_ui.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import 'dialyzer_type_screen.dart';


class DialyzerScreen extends StatefulWidget {
  const DialyzerScreen({super.key});

  @override
  State<DialyzerScreen> createState() => _DialyzerScreenState();
}

class _DialyzerScreenState extends State<DialyzerScreen> {


  List<String> dialyzerText=["Fresinivs medical care",'Nipro','Dora','Vital','B.Braun'];
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Dialyzers'),
      bottomSheet:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>DialyzerTypeScreen()));

        },
        child: Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 30,left: 20,right: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Next',color: AppColors.whiteColor,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              DesignConfig.space(h: 20),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/dialyzers.svg'),
                    CustomText(text: 'Please select')
                  ],
                ),
              ),
              DesignConfig.space(h: 40),
              dialyzerWidget(),
              DesignConfig.space(h: 40),
              CustomText(text: 'Please Specify'),
              DesignConfig.space(h: 20),
              CustomUi.editBox('Enter here', enter, TextInputType.text,)
              
            ],
          ),
        ),
      ),
    );
  }

  Widget dialyzerWidget(){
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
        itemCount: dialyzerText.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0,
          mainAxisExtent: 35,// spacing between rows
          crossAxisSpacing: 3.0, // spacing between columns
        ), itemBuilder: (context,index){
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Color(0xFFBBBBBB),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 1
              )
            ]
        ),
        child:   CustomText(text: dialyzerText[index].toString()),
      );
    });
  }
}
