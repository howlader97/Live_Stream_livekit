import 'package:get/get.dart';
import 'package:live_stream/app/modules/live_page/models/live_model.dart';
import 'package:live_stream/app/modules/live_page/views/live_page_view.dart';

import '../../../data/service/cloud_flare_service.dart';
import '../../live_page/controllers/live_page_controller.dart';

class HomeController extends GetxController {
  var liveList = <LiveModel>[].obs;

  @override
  void onInit() {
    fetchLiveList();
    ever(liveList, (_) => fetchLiveList());
    super.onInit();
  }

  void fetchLiveList() async {
    var response = await CloudflareService.getLiveList();
    liveList.value = response;
  }

  void joinLive(LiveModel live) {
    final controller = Get.put(LivePageController());
    controller.setLive(live);

    Get.to(() => LivePageView(live: live));
  }
}
