import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:attendo/utils/app_extension.dart';
import 'package:attendo/utils/app_string.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import 'package:attendo/widgets/app_button.dart';
import 'package:attendo/widgets/app_textfield.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            24.height,
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(controller.appImageLogo, height: 100),
            ),
            24.height,
            Text("Welcome back  $hiEmoji", style: Get.textTheme.headlineLarge),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "to", style: Get.textTheme.headlineLarge),
                  TextSpan(
                    text: " Attendo System",
                    style: Get.textTheme.headlineLarge?.copyWith(
                      color: AppColors.kBlue900,
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            Text(
              "Hello there, login to continue",
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.kGrey300,
              ),
            ),
            16.height,
            AppTextField(
              hintText: "Username",
              controller: controller.usernameTC,
            ),
            16.height,
            AppTextField(
              hintText: "Password",
              isPassword: true,
              controller: controller.passTC,
            ),
            34.height,
            Obx(() {
              return AppButton.appButton(
                onPressed: controller.login,
                label: "Log in",
                backgroundColor: AppColors.kBlue900,
                child: controller.isLoading.value
                    ? const Center(
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            color: AppColors.kWhite,
                            strokeWidth: 1.5,
                          ),
                        ),
                      )
                    : null,
              );
            }),
            24.height,
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "Or continue with social account",
                  style: TextStyle(color: AppColors.kGrey300, fontSize: 12),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    indent: 10,
                  ),
                ),
              ],
            ),
            20.height,

            // 👇 Tombol Google
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  "assets/google.png",
                  width: 20,
                  height: 20,
                ),
                label: const Text(
                  "Google",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            120.height,
            Align(
              alignment: Alignment.topCenter,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: Get.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: " Create Organization",
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: AppColors.kBlue900,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.gotoSignUpPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
