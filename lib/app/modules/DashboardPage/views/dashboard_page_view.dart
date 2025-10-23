import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/utils/theme/app_colors.dart';

import '../controllers/dashboard_page_controller.dart';

class DashboardPageView extends GetView<DashboardPageController> {
  const DashboardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardPageController>(
      id: "rootUI",
      init: controller,
      builder: (_) {
        return Scaffold(
          // Ganti warna latar belakang scaffold biar lembut biru keabu
          backgroundColor: AppColors.kWhite,
          extendBody: true, 
          

          body: Obx(() {
            return IndexedStack(
              index: controller.currentIndex.value,
              children: controller.pages,
            );
          }),

          floatingActionButton: Obx(() => FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: controller.onFloatTap,
                backgroundColor: AppColors.kBlue900,
                child: Icon(
                  Icons.people_alt_outlined,
                  color: controller.currentIndex.value == 4
                      ? AppColors.white
                      : AppColors.white,
                ),
              )),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
                icons: const [
                  Icons.home_filled,
                  Icons.calendar_month_rounded,
                  Icons.card_travel_rounded,
                  Icons.person_3_outlined,
                ],
                notchMargin: 7,
                activeIndex: controller.currentIndex.value,
                splashRadius: 2,
                inactiveColor: AppColors.kBlack900.withOpacity(.8),
                leftCornerRadius: 35,
                rightCornerRadius: 35,
                activeColor: AppColors.kBlue900,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.defaultEdge,
                onTap: controller.onBottomNavTap,
              )),
        );
      },
    );
  }
}
