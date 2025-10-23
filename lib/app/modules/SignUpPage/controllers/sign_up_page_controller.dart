import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/app/routes/app_pages.dart';
import 'package:attendo/utils/app_images.dart';
import 'package:attendo/utils/helper_funtion.dart';
import 'package:attendo/app/modules/SignUpPage/model/working_days_model.dart';

class SignUpPageController extends GetxController {
  String get appImageLogo => AppImages.appLogo;

  // 🔹 Text Controllers
  final usernameTC = TextEditingController();
  final passTC = TextEditingController();
  final fullNameTC = TextEditingController();
  final organizationTC = TextEditingController();
  final paidLeaveTC = TextEditingController();
  final casualSickTC = TextEditingController();
  final wfhTC = TextEditingController();

  // 🔹 Reactive Variables
  final isAgreeChecked = false.obs;
  final workingDays = <WorkingDaysModel>[].obs;
  final startTime = Rxn<TimeOfDay>(); // ✅ perbaikan di sini
  final endTime = Rxn<TimeOfDay>();   // ✅ perbaikan di sini
  final isSaveLoading = false.obs;
  var isEmployeeSignup = false.obs;


  final formKey = GlobalKey<FormState>();

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

  void onWorkingDaysChange(int index) {
    workingDays[index].isSelected = !workingDays[index].isSelected;
    workingDays.refresh();
  }

  // 🔹 Fungsi untuk buka time picker
  void openTimePickerdialog(bool isStart, BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStart) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }

  // 🔹 Format tampilan jam
  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  // 🔹 Navigasi ke login
  void gotoLoginPage() {
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  // 🔹 Logika register
  Future<void> signUp() async {
    if (isSaveLoading.value) return;

    if (formKey.currentState?.validate() != true) {
      showErrorSnack("Harap isi semua kolom dengan benar");
      return;
    }

    if (!isEmployeeSignup.value) {
    if (startTime.value == null ||
        endTime.value == null ||
        workingDays.where((e) => e.isSelected).isEmpty) {
      showErrorSnack("Pilih jam kerja dan hari kerja terlebih dahulu");
      return; 
    }
  }

    isSaveLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    showSuccessSnack("Akun berhasil dibuat!");
    Get.offAllNamed(Routes.LOGIN_PAGE);
    isSaveLoading.value = false;
  }

  @override
  void onClose() {
    usernameTC.dispose();
    passTC.dispose();
    fullNameTC.dispose();
    organizationTC.dispose();
    paidLeaveTC.dispose();
    casualSickTC.dispose();
    wfhTC.dispose();
    super.onClose();
  }
}
