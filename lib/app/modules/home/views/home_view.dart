import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(() {
      //   if (controller.liveList.isEmpty) {
      //     return Center(child: Text("No one is live"));
      //   }
      //   return GridView.builder(
      //     itemCount: controller.liveList.length,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //     itemBuilder: (context, index) {
      //       var live = controller.liveList[index];
      //       return GestureDetector(
      //         onTap: () => controller.joinLive(live),
      //         child: Card(
      //           child: Center(child: Text("Live by ${live.hostId}")),
      //         ),
      //       );
      //     },
      //   );
      // }),
    );
  }
}


