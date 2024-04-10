import 'package:flutter/material.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';

class BlogsDetails extends StatefulWidget {
  final image,text,description;
  const BlogsDetails({super.key,this.image,this.text,this.description});

  @override
  State<BlogsDetails> createState() => _BlogsDetailsState();
}

class _BlogsDetailsState extends State<BlogsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Blogs'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DesignConfig.space(h: 1.h),
          Container(
            height: 25.h,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.image.toString()),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(6)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: CustomText(
              text: widget.text.toString(),
              color: const Color(0xFF7C7C7C),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: CustomText(
              text: widget.description.toString(),
              color: const Color(0xFF8A8A8A),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
