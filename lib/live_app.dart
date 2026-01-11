import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_stream/app/data/theme.dart';
import 'package:live_stream/app/routes/app_pages.dart';

class LiveApp extends StatelessWidget {
  const LiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: "Application",
        theme: themeData(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
