import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/screen/blogs_screen/blogs_screen.dart';
import 'package:health_care/screen/profile_screen/profile_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_colors.dart';
import '../../common/app_images.dart';
import '../home_screen/home_screen.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> key = GlobalKey();

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static final List<Widget> pages=<Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const BlogScreen(navigatePage: ''),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // titleSpacing: 20,
        leading: Container(),
        leadingWidth: 0,
        title:  Image.asset(AppImages.jagjivanIcon,width: 130,),
        actions: [
          SvgPicture.asset("assets/svg/bell.svg"),
          DesignConfig.space(w: 2.h),
          SvgPicture.asset(AppImages.walletIcon),
          DesignConfig.space(w: 2.h),

        ],
      ),
      key: key,
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Color(0xFF151921),
          selectedLabelStyle: TextStyle(
              fontSize: 12.px,
              fontWeight: FontWeight.w800,
              color: Color(0xFF151921)),
          unselectedLabelStyle: TextStyle(
              fontSize: 12.px,
              fontWeight: FontWeight.w600,
              color: Color(0xFF151921)),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.homeIcon,
                  color: selectedIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.greyColor1),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.medicalRecordIcon,
                    color: selectedIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.greyColor1),
                label: 'Medical\nrecords'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.blogIcon,
                    color: selectedIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.greyColor1),
                label: 'BLOGS'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.productsIcon,
                    color: selectedIndex == 3
                        ? AppColors.primaryColor
                        : AppColors.greyColor1),
                label: 'PRODUCTS'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.profile,
                    color: selectedIndex == 4
                        ? AppColors.primaryColor
                        : AppColors.greyColor1),
                label: 'PROFILE'),
          ]),
      body: pages[selectedIndex],

    );
  }
}
