import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGrey50,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),

          // 👤 Profile Header
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.kBlue900,
                child: Icon(Icons.person, color: AppColors.white, size: 40),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Profile",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.kBlue900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.userName.text,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.kGrey300),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_note_rounded,
                  color: AppColors.kBlue900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 🧩 User Info Card
          _buildInfoCard(
            context,
            title: "Username",
            icon: Icons.person_outline_rounded,
            value: controller.userName.text,
          ),

          const SizedBox(height: 12),

          _buildInfoCard(
            context,
            title: "Organization",
            icon: Icons.business_center_outlined,
            value: controller.organizationTC.text,
          ),

          const SizedBox(height: 20),

          // 🕐 Working Time Section
          Text(
            "Working Time",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.kBlue900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: _buildTimeCard(
                    context,
                    "Start Time",
                    controller.startTime.value == null
                        ? "Not Set"
                        : controller.formatTimeOfDay(
                            controller.startTime.value!,
                          ),
                    Icons.access_time,
                    () => _openTimePicker(context, true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTimeCard(
                    context,
                    "End Time",
                    controller.endTime.value == null
                        ? "Not Set"
                        : controller.formatTimeOfDay(controller.endTime.value!),
                    Icons.timelapse_outlined,
                    () => _openTimePicker(context, false),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 24),

          // 📅 Working Days
          Text(
            "Working Days",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.kBlue900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kBlue600.withOpacity(.2)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kBlue600.withOpacity(.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                return Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: List.generate(
                    controller.workingDays.length,
                    (index) => ChoiceChip(
                      label: Text(
                        controller.workingDays[index].label,
                        style: TextStyle(
                          color: controller.workingDays[index].isSelected
                              ? AppColors.white
                              : AppColors.kBlack900,
                        ),
                      ),
                      selected: controller.workingDays[index].isSelected,
                      onSelected: (val) =>
                          controller.onWorkingDaysChange(index),
                      selectedColor: AppColors.kBlue900,
                      backgroundColor: AppColors.kGrey100,
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 28),

          // 🔘 Buttons
          FilledButton.icon(
            onPressed: _showResetPasswordDialog,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.kBlue900,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: const Icon(Icons.lock_reset_rounded),
            label: const Text("Update Password"),
          ),

          const SizedBox(height: 20),

          // 🔴 Logout button (moved slightly upward)
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: FilledButton.icon(
              onPressed: () {
                Get.snackbar("Logout", "You have been logged out!");
                controller.gotoLoginPage(); // pakai fungsi dari controllermu
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.logout_rounded),
              label: const Text("Log Out"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBlue600.withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlue600.withOpacity(.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.kBlue600.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: AppColors.kBlue900),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.kGrey300),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.kBlack900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(
    BuildContext context,
    String title,
    String time,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.kBlue600.withOpacity(.2)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlue600.withOpacity(.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.kBlue600.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(icon, color: AppColors.kBlue900, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.kGrey300),
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.kBlue900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openTimePicker(BuildContext context, bool isStartTime) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      if (isStartTime) {
        controller.startTime.value = selectedTime;
      } else {
        controller.endTime.value = selectedTime;
      }
    }
  }

  void _showResetPasswordDialog() {
    String oldPassWord = "", newPassword = "";
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Set New Password",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlue900,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Old password",
                  filled: true,
                  fillColor: AppColors.kGrey50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                onChanged: (v) => oldPassWord = v,
              ),
              const SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter New password",
                  filled: true,
                  fillColor: AppColors.kGrey50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.lock_reset_rounded),
                ),
                onChanged: (v) => newPassword = v,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: Get.back,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (oldPassWord.isEmpty || newPassword.isEmpty) {
                          Get.snackbar("Error", "Please fill in both fields");
                          return;
                        }
                        Get.back();
                        Get.snackbar(
                          "Success",
                          "Password updated successfully!",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kBlue900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Update"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
