import 'package:attendo/app/routes/app_pages.dart';
import 'package:attendo/utils/app_images.dart';
import 'package:get/get.dart';

class SplashScreenPageController extends GetxController {
  //TODO: Implement SplashScreenPageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkUserIsLogin();
  }

  String get appImageLogo => AppImages.appLogo;

  void checkUserIsLogin() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Get.offAndToNamed(Routes.Login_Page);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
