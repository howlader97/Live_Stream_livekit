import 'package:get/get.dart';
import 'package:live_stream/app/modules/live_page/models/live_model.dart';
import 'package:live_stream/app/modules/live_page/views/live_page_view.dart';

import '../../../data/service/cloud_flare_service.dart';


class HomeController extends GetxController {
  var liveList = <LiveModel>[].obs;

  @override
  void onInit() {
    fetchLiveList();
    super.onInit();
  }

  void fetchLiveList() async {
    var response = await CloudflareService.getLiveList();
    liveList.value = response;
  }

  void joinLive(LiveModel live) {
    Get.to(() => LivePageView(live: live));
  }
}
