import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:attendo/utils/app_extension.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import 'package:attendo/widgets/app_button.dart';
import 'package:attendo/widgets/app_textfield.dart';
import '../controllers/holiday_page_controller.dart';

class HolidayPageView extends StatelessWidget {
  const HolidayPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HolidayPageController(), permanent: true);

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: const Text('Holidays'),
        elevation: 0.5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60), // 🔹 naik sedikit
        child: _buildAddHolidayButton(context, controller),
      ),
      body: Obx(() {
        final holidays = controller.holidays;

        return ListView.builder(
          itemCount: holidays.length + 1, // +1 buat card default
          padding: const EdgeInsets.only(bottom: 80),
          itemBuilder: (context, index) {
            if (index == 0) {
              // Card default selalu muncul
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kGrey300.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.kBlue900,
                      size: 30,
                    ),
                    16.width,
                    Expanded(
                      child: Text(
                        "Default Holiday — belum ada data tambahan.",
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: AppColors.kBlue900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Card libur dari controller
              final holiday = holidays[index - 1];
              return _buildHolidayItem(controller, index - 1);
            }
          },
        );
      }),
    );
  }

  Widget _buildAddHolidayButton(
    BuildContext context,
    HolidayPageController controller,
  ) {
    DateTime? selectedDate;
    final labelController = TextEditingController();

    return FloatingActionButton(
      backgroundColor: AppColors.kBlue900,
      onPressed: () {
        Get.defaultDialog(
          title: "Add Holiday",
          titlePadding: const EdgeInsets.only(top: 16),
          radius: 12,
          backgroundColor: AppColors.kWhite, // 🔹 Putih bersih
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(hintText: "Label", controller: labelController),
              20.height,
              StatefulBuilder(
                builder: (context, re) {
                  return AppButton.appOulineButtonRow(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                        initialDate: selectedDate ?? DateTime.now(),
                      );
                      if (date != null) {
                        selectedDate = date;
                        re(() {});
                      }
                    },
                    label: selectedDate == null
                        ? "Select Date"
                        : DateFormat("dd/MM/yyyy").format(selectedDate!),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.kBlue600,
                    ),
                  );
                },
              ),
              24.height,
              Align(
                alignment: Alignment.centerRight,
                child: AppButton.appButton(
                  label: "Add",
                  onPressed: () {
                    if (selectedDate != null &&
                        labelController.text.isNotEmpty) {
                      controller.addHoliday(
                        labelController.text,
                        selectedDate!,
                      );
                      Get.back();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill label and date",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildHolidayItem(HolidayPageController controller, int index) {
    final holiday = controller.holidays[index];
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kGrey300.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.kBlack900,
            size: 30,
          ),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("EEEE, dd MMM yyyy").format(holiday.date),
                  style: Get.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                8.height,
                Text(holiday.label, style: Get.textTheme.bodyMedium),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.deleteHoliday(index),
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
