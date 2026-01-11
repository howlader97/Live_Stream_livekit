import 'package:get/get.dart';

import '../controllers/live_page_controller.dart';

class LivePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LivePageController>(
      () => LivePageController(),
    );
  }
}
