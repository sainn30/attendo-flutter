import 'package:get/get.dart';

class Holiday {
  final String label;
  final DateTime date;

  const Holiday({required this.label, required this.date});
}

class HolidayPageController extends GetxController {
  final RxList<Holiday> holidays = <Holiday>[].obs;

  void addHoliday(String label, DateTime date) {
    holidays.add(Holiday(label: label, date: date));
  }

  void deleteHoliday(int index) {
    holidays.removeAt(index);
  }
}
