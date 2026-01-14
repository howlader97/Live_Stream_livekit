import 'package:get/get.dart';
import 'package:live_stream/app/modules/live_page/controllers/live_page_controller.dart';

import '../../home/controllers/home_controller.dart';
import '../../start_live/controllers/start_live_controller.dart';
import '../controllers/bottom_bar_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(
      () => BottomBarController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<StartLiveController>(
          () => StartLiveController(),
    );
    Get.lazyPut<LivePageController>(
          () => LivePageController(),
    );
  }
}
