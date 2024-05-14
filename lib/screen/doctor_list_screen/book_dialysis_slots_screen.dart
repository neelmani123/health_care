import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_ui.dart';
import '../../models/doctor_list_model/slots_model.dart';
import 'book_appointment_summary_screen.dart';
import 'package:get/get.dart';

class BookDialysisslotsScreen extends StatefulWidget {
  final id, type, image, bio, name;

  const BookDialysisslotsScreen(
      {super.key, this.id, this.type, this.image, this.name, this.bio});

  @override
  State<BookDialysisslotsScreen> createState() =>
      _BookDialysisslotsScreenState();
}

class _BookDialysisslotsScreenState extends State<BookDialysisslotsScreen> {
  final HttpServices httpServices = HttpServices();
  List<Slots> slots = [];
  var formatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  String todayDate = '';

  void slotsApi(String date) async {
    var res = await httpServices.slotsApi(
        hospitalId: widget.id.toString(),
        type: widget.type.toString(),
        date: date);
    if (res!.result == true) {
      setState(() {
        slots = res.slots!;
        selectSlots =
            "${slots.first.startTime.toString() + "-" + slots.first.endTime.toString()}";
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  void boolAppointmentApi() async {
    var res = await httpServices.boolAppointmentApi(
        type: widget.type,
        date: todayDate.toString(),
        hospitalId: widget.id,
        slots: selectSlots);
    if (res!.result == true) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    todayDate = formatter.format(selectedDate).toString();
    slotsApi(formatter.format(selectedDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CustomUi.primaryButton('Book Now', () {
          if (selectSlots == '') {
            Fluttertoast.showToast(msg: "please select slots..");
          } else {
            Get.to(BookAppointmnetSummaryScreen(
              name: widget.name,
              bio: widget.bio,
              date: todayDate.toString(),
              image: widget.name,
              type: widget.type,
              id: widget.id,
              selectSlots: selectSlots.toString(),
            ));
          }
        }, 11, AppColors.primaryColor, AppColors.whiteColor, 14, false),
      ),
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Book dialysis appointment',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            hospitalDetails(),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: CustomText(
                text: 'Select Date',
                fontSize: 15,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
            EventTableCalender(),
            DesignConfig.space(h: 1.h),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: CustomText(
                text: 'Select Time',
                fontSize: 15,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
            DesignConfig.space(h: 1.h),
            slotsWidget(),
            DesignConfig.space(h: 6.h),
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
          Row(
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
                        image: DecorationImage(
                            image: NetworkImage(widget.image.toString()))),
                  )),
              DesignConfig.space(w: 5.w),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: widget.name.toString(),
                            color: const Color(0xFF3C3C3C),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          const Icon(Icons.heart_broken),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.bio.toString().length>=100?CustomUi.htmlText(widget.bio.toString().substring(0,100)+"..."):CustomUi.htmlText(widget.bio.toString()),
                      ),

                    ],
                  )),
            ],
          ),
          DesignConfig.space(h: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: '4.0',
                    color: const Color(0xFF3C3C3C),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  DesignConfig.space(w: 1.w),
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                      size: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 5.h,
                alignment: Alignment.bottomRight,
                width: MediaQuery.of(context).size.width / 1.4,
                padding: EdgeInsets.only(left: 20.w),
                child: CustomUi.primaryButton('Contact', () {}, 11,
                    AppColors.primaryColor, AppColors.whiteColor, 14, false),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget EventTableCalender() {
    return Container(
     //height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.greyColor.withOpacity(0.5),
            blurStyle: BlurStyle.outer,
            blurRadius: 1)
      ], borderRadius: BorderRadius.circular(10)),
      child: TableCalendar(

        onPageChanged: (date) {
          selectedDate = date;
          todayDate = formatter.format(selectedDate);

        },
        headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
       selectedDayPredicate: (day)=>isSameDay(day,selectedDate),
        onDaySelected: (date, events) {
          setState(() {
            selectedDate = events;
            slotsApi(formatter.format(date).toString());
            debugPrint('onday selected--$selectedDate');
            // _selectedEvents = events;
          });
        },

        firstDay: DateTime(2022, 1, 1),
        lastDay: DateTime(2030, 12, 31),
        focusedDay: selectedDate,
        // calendarController: _calenderController,
      ),
    );
  }

  int select = 0;
  var selectSlots;

  Widget slotsWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ListView.builder(
          itemCount: slots.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  select = index;
                  selectSlots =
                      "${slots[index].startTime.toString() + "-" + slots[index].endTime.toString()}";
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10, right: 2),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                    color: select == index
                        ? AppColors.primaryColor
                        : AppColors.whiteColor),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                    text: slots[index].startTime.toString() +
                        "-" +
                        slots[index].endTime.toString(),
                    color: select == index
                        ? AppColors.whiteColor
                        : AppColors.blackColor),
              ),
            );
          }),
    );
  }
}
