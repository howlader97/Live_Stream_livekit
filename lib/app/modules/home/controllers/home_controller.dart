import 'dart:async';

import 'package:get/get.dart';
import 'package:live_stream/app/modules/live_page/models/live_model.dart';
import 'package:live_stream/app/modules/live_page/views/live_page_view.dart';

import '../../../data/service/cloud_flare_service.dart';
import '../../live_page/controllers/live_page_controller.dart';

class HomeController extends GetxController {

  // var isLoading = false.obs;
  // var hasError = false.obs;
  // var errorMessage = ''.obs;
  //
  // var liveList = <LiveModel>[].obs;
  //
  // @override
  // void onInit() {
  //   fetchLiveList();
  //   Timer.periodic(Duration(seconds: 10), (timer) {
  //     if (!isLoading.value) {/**/
  //       fetchLiveList();
  //     }
  //   });
  //   super.onInit();
  // }
  //
  // Future<void> fetchLiveList() async {
  //   if (isLoading.value) return;
  //
  //   isLoading.value = true;
  //   hasError.value = false;
  //
  //   try {
  //     var response = await CloudflareService.getLiveList();
  //     liveList.value = response;
  //   } catch (e) {
  //     hasError.value = true;
  //     errorMessage.value = e.toString();
  //     print('Error fetching live list: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // void joinLive(LiveModel live) {
  //   final controller = Get.put(LivePageController());
  //   controller.setLive(live);
  //
  //   Get.to(() => LivePageView(live: live));
  // }
}
