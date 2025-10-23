import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/app/routes/app_pages.dart';
import 'package:attendo/utils/app_images.dart';
import 'package:attendo/utils/helper_funtion.dart';
import 'package:attendo/utils/app_extension.dart';
import 'package:attendo/widgets/app_textfield.dart';

class LoginPageController extends GetxController {
  // ambil logo dari folder utils/app_images.dart
  String get appImageLogo => AppImages.appLogo;

  // text controller untuk username & password
  var usernameTC = TextEditingController();
  var passTC = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void gotoSignUpPage() {
    Get.offAllNamed(Routes.SIGN_UP_PAGE);
  }

  void login() async {
  if (isLoading.value) return;
  isLoading.value = true;

  await Future.delayed(const Duration(seconds: 1)); // simulasi loading

  if (usernameTC.text.trim().isEmpty || passTC.text.trim().isEmpty) {
    showErrorSnack("Username dan password tidak boleh kosong");
  } else {
    showSuccessSnack("Login berhasil");
    // Kalau mau, simpan username sementara di memory/controller sebelum pindah
    // final enteredUsername = usernameTC.text.trim();

    Get.offAllNamed(Routes.DASHBOARD_PAGE); // arahkan ke halaman utama
  }

  isLoading.value = false;
}

  void showResetPasswordDialog() {
    String password = "", renterPassword = "";
    Get.defaultDialog(
      title: "Set New Password",
      barrierDismissible: false,
      content: Column(
        children: [
          24.height,
          AppTextField(
            hintText: "Enter new password",
            onChanged: (p) => password = p,
          ),
          24.height,
          AppTextField(
            hintText: "Re-Enter new password",
            onChanged: (p) => renterPassword = p,
          ),
          24.height,
        ],
      ),
      textCancel: "Cancel",
      onCancel: Get.back,
      textConfirm: "Update Password",
      onConfirm: () {
        if (renterPassword.trim().isEmpty || password != renterPassword) {
          showErrorSnack("Password tidak sama");
          return;
        }
        passTC.text = renterPassword;
        Get.back();
        showSuccessSnack("Password berhasil diubah");
      },
    );
  }

  @override
  void onClose() {
    usernameTC.dispose();
    passTC.dispose();
    super.onClose();
  }
}
