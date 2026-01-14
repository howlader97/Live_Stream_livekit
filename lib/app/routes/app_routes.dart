part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LIVE_PAGE = _Paths.LIVE_PAGE;
  static const BOTTOM_BAR = _Paths.BOTTOM_BAR;
  static const MESSAGE = _Paths.MESSAGE;
  static const START_LIVE = _Paths.START_LIVE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LIVE_PAGE = '/live-page';
  static const BOTTOM_BAR = '/bottom-bar';
  static const MESSAGE = '/message';
  static const START_LIVE = '/start-live';
}
