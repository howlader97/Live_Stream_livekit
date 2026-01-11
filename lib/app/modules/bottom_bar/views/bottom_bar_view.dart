import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: controller.screens[controller.selectIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectIndex.value,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap:controller.changeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam_rounded),
              label: "live",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "message"),
          ],
        ),
      );
    });
  }
}
