import 'package:get/get.dart';

import '../view/homePage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    handleSplash();
    super.onInit();
  }

  Future<void> handleSplash() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAll(() => HomePage());
  }
}
