import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/app/routes/app_pages.dart';
import 'package:attendo/app/modules/SignUpPage/model/working_days_model.dart';

class ProfilePageController extends GetxController {
  var userName = TextEditingController(text: "demo_user");
  var password = TextEditingController();
  var organizationTC = TextEditingController(text: "Demo Organization");

  var workingDays = <WorkingDaysModel>[].obs;
  var startTime = Rxn<TimeOfDay?>(null);
  var endTime = Rxn<TimeOfDay?>(null);

  @override
  void onInit() {
    workingDays.value = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ]
        .map((e) => WorkingDaysModel(
              label: e,
              code: e.toUpperCase(),
              isSelected: false,
            ))
        .toList();
    super.onInit();
  }

  void gotoLoginPage() {
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  void onWorkingDaysChange(int index) {
    workingDays[index].isSelected = !workingDays[index].isSelected;
    workingDays.refresh();
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}
