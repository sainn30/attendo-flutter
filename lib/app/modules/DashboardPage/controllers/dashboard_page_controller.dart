import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/app/modules/AllEmployesPage/bindings/all_employes_page_binding.dart';
import 'package:attendo/app/modules/AllEmployesPage/views/all_employes_page_view.dart';
import 'package:attendo/app/modules/HolidayPage/bindings/holiday_page_binding.dart';
import 'package:attendo/app/modules/HolidayPage/views/holiday_page_view.dart';
import 'package:attendo/app/modules/HomePage/bindings/home_page_binding.dart';
import 'package:attendo/app/modules/HomePage/views/home_page_view.dart';
import 'package:attendo/app/modules/LeavePage/bindings/leave_page_binding.dart';
import 'package:attendo/app/modules/LeavePage/views/leave_page_view.dart';
import 'package:attendo/app/modules/ProfilePage/bindings/profile_page_binding.dart';
import 'package:attendo/app/modules/ProfilePage/views/profile_page_view.dart';
import 'package:attendo/utils/helper_funtion.dart';

class DashboardPageController extends GetxController {
  List<Widget> pages = [];
  var currentIndex = 0.obs;

  Map<int, bool> canPageLoad = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false, // all team leave
  };

  @override
  void onInit() {
    super.onInit();
    canPageLoad[currentIndex.value] = true;
    HomePageBinding().dependencies();
    pages = [
      const HomePageView(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
    ];
  }

  onBottomNavTap(int newIndex) {
    if (newIndex == currentIndex.value) return;
    if (!(canPageLoad[newIndex]!)) {
      canPageLoad[newIndex] = true;

      if (newIndex == 1) {
        pages.removeAt(newIndex);
        LeavePageBinding().dependencies();
        pages.insert(newIndex, const LeavePageView());
      }
      if (newIndex == 2) {
        pages.removeAt(newIndex);
        HolidayPageBinding().dependencies();
        pages.insert(newIndex, const HolidayPageView());
      }
      if (newIndex == 3) {
        pages.removeAt(newIndex);
        ProfilePageBinding().dependencies();
        pages.insert(newIndex, const ProfilePageView());
      }
    }
    currentIndex.value = newIndex;
  }

  void onFloatTap() {
    if (!(canPageLoad[4]!)) {
      pages.removeAt(4);
      AllEmployesPageBinding().dependencies();
      pages.insert(4, const AllEmployesPageView());
    }
    currentIndex.value = 4;
  }

  // Hapus API logic — ganti dengan contoh alert sederhana biar UI tetap interaktif
  void checkUserIsApproved() {
    showSuccessSnack("Contoh: Cek status user (dummy UI, tanpa API).");
  }

  @override
  void onClose() {
    super.onClose();
  }
}
