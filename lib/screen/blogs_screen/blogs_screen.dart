import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/screen/blogs_screen/blogs_details.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../models/blogs_model/blogs_model.dart';

class BlogScreen extends StatefulWidget {
  final navigatePage;
  const BlogScreen({super.key,this.navigatePage});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final HttpServices httpServices=HttpServices();
  final HttpClientServices clientRequest=HttpClientServices();
  List<Blogs> blogs=[];
  bool loading=true;

  void blogsApi()async{
    var prefs=await SharedPreferences.getInstance();
    var res;

    if(prefs.get('login_type').toString()=="client")
    {
      res=await clientRequest.blogsApi();
    }
    else
      {
        res=await httpServices.blogsApi();
      }
    if(res!.result==true)
      {
        setState(() {
          blogs=res.blogs!;
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
    // TODO: implement initState
    blogsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.navigatePage==''?null:DesignConfig.appBar(context, double.infinity, 'Blogs'),
      body: (loading)?Center(child: CircularProgressIndicator(),):Column(
        children: [
          DesignConfig.space(h: 1.h),
          searchWidget(),
          DesignConfig.space(h: 2.h),
          blogsWidget(),
        ],
      ),
    );
  }

  Widget searchWidget() {
    return Container(
        height: 7.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 18,
                color: Color(0xFF878B91),
              ),
              border: InputBorder.none,
              hintText: 'Search ',
              hintStyle: TextStyle(
                  color: Color(0xFF818286),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ));
  }

  Widget blogsWidget(){
    return Expanded(child: GridView.builder(
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            mainAxisExtent: 190),
        itemCount: blogs.length,
        itemBuilder: (contex, index) {
          return InkWell(
            onTap: (){
              Get.to(BlogsDetails(image: blogs[index].image.toString(),text: blogs[index].title.toString(),description: blogs[index].description.toString(),));
            },
            child: Container(
            padding: EdgeInsets.only(top: 5,bottom: 10),
              width: 200,
              margin:
              const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25),
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
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(blogs[index].image.toString()),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  DesignConfig.space(h: 1.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: blogs[index].title.toString(),
                      color: const Color(0xFF333333),
                      fontSize: 13,
                      maxLine: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DesignConfig.space(h: 0.5.h),

                  Container(
                    height: MediaQuery.of(context).size.height/7,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: CustomUi.htmlText(blogs[index].description.l),
                  ),
                  DesignConfig.space(h: 1.h),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Read more',
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: const Color(0xFF545454),
                          ),
                          DesignConfig.space(w: 10),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color:  Color(0xFF545454),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
