import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/custom_text.dart';


class DialysisIncharge extends StatefulWidget {
  const DialysisIncharge({super.key});

  @override
  State<DialysisIncharge> createState() => _DialysisInchargeState();
}

class _DialysisInchargeState extends State<DialysisIncharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Consultant lncharge'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SvgPicture.asset('assets/svg/consultIncharge.svg',alignment: Alignment.center,)),
              DesignConfig.space(h: 30),
              CustomText(text: 'Please select',color: Color(0xFFA1A1A1),fontWeight: FontWeight.w400,fontSize: 13,),
              DesignConfig.space(h: 10),
              consultantDrop()
            ],
          ),
        ),
      ),
    );
  }

List<String> dropItem=["Ravi Kumar","Ravi Kumar","Ravi Kumar"];
  String dropValue="Ravi kumar";

  Widget consultantDrop()
  {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFDBDBDB),width: 1)
      ),
      child: DropdownButton<String>(
        onChanged: (val){
          setState(() {
            dropValue=val.toString();
          });
        },
        value: dropValue,
        items: dropItem.map((e){
          return DropdownMenuItem<String>(value: e,child: CustomText(text:e.toString()),);
        }).toList(),
      ),
    );
  }
}
