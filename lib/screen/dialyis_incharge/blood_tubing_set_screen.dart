import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import 'advice_screen.dart';

class BloodTubingSetScreen extends StatefulWidget {
  const BloodTubingSetScreen({super.key});

  @override
  State<BloodTubingSetScreen> createState() => _BloodTubingSetScreenState();
}

class _BloodTubingSetScreenState extends State<BloodTubingSetScreen> {
  @override
  List<String> dialyzerText = [
    "Fresinivs medical care",
    'Nipro',
    'Dora',
    'Vital',
    'B.Braun'
  ];
  final TextEditingController enter = TextEditingController();
  var selectedDailyzerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Blood Tubing Set'),
      bottomSheet: InkWell(
        onTap: () {
          if(enter.text.isEmpty)
          {
            Fluttertoast.showToast(msg: 'Please enter specify...');
          }
          else
          {
            startDialysisApiCall();
          }

        },
        child: Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Next', color: AppColors.whiteColor,),
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

  Widget dialyzerWidget() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: dialyzerText.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0,
          mainAxisExtent: 35, // spacing between rows
          crossAxisSpacing: 3.0, // spacing between columns
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedDailyzerIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectedDailyzerIndex == index
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFBBBBBB),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 1
                    )
                  ]
              ),
              child: CustomText(text: dialyzerText[index].toString(),
                color: selectedDailyzerIndex == index
                    ? AppColors.whiteColor
                    : AppColors.greyColor,),
            ),
          );
        });
  }

  var httpServices = HttpClientServices();

  void startDialysisApiCall() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await httpServices.startDialysisApi(
        appointment_id: prefs.get('appointment_id').toString(),
        blood_tubing_set: dialyzerText[selectedDailyzerIndex].toString(),
        blood_tubing_set_text: enter.text.toString());
    if (res!.result == true) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdviceScreen()));
      });
    }
  }

}
