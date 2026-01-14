import 'package:get/get.dart';
import 'package:live_stream/app/modules/home/views/home_view.dart';
import 'package:live_stream/app/modules/live_page/views/live_page_view.dart';
import 'package:live_stream/app/modules/message/views/message_view.dart';
import 'package:live_stream/app/modules/start_live/views/start_live_view.dart';

class BottomBarController extends GetxController {
  var selectIndex = 0.obs;
  final screens = [
    const HomeView(),
    const StartLiveView(),
    const MessageView(),
  ];

  void changeIndex(int index) {
    selectIndex.value = index;
  }
}
