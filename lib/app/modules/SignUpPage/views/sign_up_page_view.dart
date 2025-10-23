import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:attendo/utils/app_extension.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import 'package:attendo/widgets/app_button.dart';
import 'package:attendo/widgets/app_textfield.dart';
import '../controllers/sign_up_page_controller.dart';

class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(controller.appImageLogo, height: 80),
                ),
                24.height,
                Text("Register Account", style: Get.textTheme.headlineLarge),
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
                  "Hello there, register to continue",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.kGrey300,
                  ),
                ),
                32.height,

                // --- First Name ---
                AppTextField(
                  hintText: "Username",
                  controller: controller.fullNameTC,
                  validator: (val) => val!.isEmpty ? "Enter first name" : null,
                ),
                16.height,

                // --- Email Address ---
                AppTextField(
                  hintText: "Email Address",
                  controller: controller.usernameTC,
                  validator: (val) =>
                      val!.isEmpty ? "Enter email address" : null,
                ),
                16.height,

                // --- Password ---
                AppTextField(
                  hintText: "Password",
                  isPassword: true,
                  controller: controller.passTC,
                  validator: (val) => val!.isEmpty ? "Enter password" : null,
                ),
                16.height,

                // --- Confirm Password ---
                AppTextField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  validator: (val) {
                    if (val!.isEmpty) return "Confirm your password";
                    if (val != controller.passTC.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                16.height,

                // 🔹 Toggle Employee Signup
                Row(
                  children: [
                    Obx(() => Switch(
                          value: controller.isEmployeeSignup.value,
                          activeColor: AppColors.kBlue900,
                          onChanged: (val) =>
                              controller.isEmployeeSignup.value = val,
                        )),
                    const SizedBox(width: 8),
                    Text(
                      "Employee Signup",
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                16.height,

                // 🔹 Form Organization / Employee Conditional
                Obx(() {
                  if (controller.isEmployeeSignup.value) {
                    // ✅ Employee Signup: hanya Company ID
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title("Employee Details", Icons.person_outline),
                        16.height,
                        AppTextField(
                          hintText: "Company ID",
                          controller: controller.organizationTC,
                          validator: (val) {
                            if (val?.isEmpty ?? true) {
                              return "Enter Company ID";
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  } else {
                    // 🏢 Organization Signup: full form
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title("Organization Details", Icons.people_alt_outlined),
                        16.height,
                        AppTextField(
                          hintText: "Organization Name",
                          controller: controller.organizationTC,
                          validator: (val) {
                            if (val?.isEmpty ?? true) {
                              return "This field can't be empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        16.height,
                        AppTextField(
                          hintText: "Per Month Paid Leave",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: controller.paidLeaveTC,
                        ),
                        16.height,
                        AppTextField(
                          hintText: "Per Month Sick/Casual Leave",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: controller.casualSickTC,
                        ),
                        16.height,
                        AppTextField(
                          hintText: "Per Month Work From Home",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: controller.wfhTC,
                        ),
                        16.height,
                        Obx(() {
                          return AppButton.appOulineButtonRow(
                            onPressed: () =>
                                controller.openTimePickerdialog(true, context),
                            label: controller.startTime.value == null
                                ? "Select start time"
                                : controller.formatTimeOfDay(
                                    controller.startTime.value!,
                                  ),
                            suffixIcon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.kBlue600,
                            ),
                          );
                        }),
                        16.height,
                        Obx(() {
                          return AppButton.appOulineButtonRow(
                            onPressed: () =>
                                controller.openTimePickerdialog(false, context),
                            label: controller.endTime.value == null
                                ? "Select end time"
                                : controller.formatTimeOfDay(
                                    controller.endTime.value!,
                                  ),
                            suffixIcon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.kBlue600,
                            ),
                          );
                        }),
                        16.height,
                        DecoratedBox(
                          decoration: kBoxDecoration,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Obx(() {
                                return Wrap(
                                  spacing: 10,
                                  runSpacing: 15,
                                  children: List.generate(
                                    controller.workingDays.length,
                                    (index) => ChoiceChip(
                                      label: Text(
                                        controller.workingDays[index].label,
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: controller
                                                  .workingDays[index].isSelected
                                              ? AppColors.kWhite
                                              : AppColors.black,
                                        ),
                                      ),
                                      selected: controller
                                          .workingDays[index].isSelected,
                                      onSelected: (value) => controller
                                          .onWorkingDaysChange(index),
                                    ),
                                  ).toList(),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
                24.height,

                // --- Register Button ---
                Obx(() {
                  return AppButton.appButton(
                    onPressed: controller.signUp,
                    label: "Register",
                    child: controller.isSaveLoading.value
                        ? const Center(
                            child: SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.5,
                              ),
                            ),
                          )
                        : null,
                  );
                }),
                30.height,
                Align(
                  alignment: Alignment.topCenter,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: Get.textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: " Login",
                          style: Get.textTheme.bodySmall?.copyWith(
                            color: AppColors.kBlue900,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.gotoLoginPage,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title(String name, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 20, color: AppColors.kBlue600),
          const SizedBox(width: 10),
          Text(name, style: Get.textTheme.titleLarge),
        ],
      ),
    );
  }
}

// 🔹 BoxDecoration
final kBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade300),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ],
);
