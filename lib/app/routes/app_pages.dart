import 'package:get/get.dart';

import '../modules/bottom_bar/bindings/bottom_bar_binding.dart';
import '../modules/bottom_bar/views/bottom_bar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/live_page/bindings/live_page_binding.dart';
import '../modules/live_page/views/live_page_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOM_BAR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_PAGE,
      page: () =>  LivePageView(),
      binding: LivePageBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
  ];
}
