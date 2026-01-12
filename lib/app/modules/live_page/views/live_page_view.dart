import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import '../controllers/live_page_controller.dart';
import '../models/live_model.dart';

class LivePageView extends GetView<LivePageController> {
  final LiveModel? live;
  const LivePageView({super.key, this.live});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (controller.isHost) {
          await controller.stopLive();
        } else {
          await controller.leaveLive();
        }
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isHost
              ? "Live Streaming"
              : "Watching ${live?.hostId}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                if (controller.isHost) {
                  await controller.stopLive();
                } else {
                  await controller.leaveLive();
                }
                Get.back();
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.connecting.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.isHost && controller.localVideoTrack != null) {
            // Host video
            return Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoTrackRenderer(controller.localVideoTrack!),
              ),
            );
          }

          if (!controller.isHost && controller.remoteVideoTrack.value != null) {
            // Viewer video
            return Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoTrackRenderer(controller.remoteVideoTrack.value!),
              ),
            );
          }

          // Buttons
          if (controller.isHost) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  final roomId =
                      "room_${DateTime.now().millisecondsSinceEpoch}";
                  controller.startLive(
                    roomId: roomId,
                    hostId: "currentUserId",
                  );
                },
                child: const Text("Go Live"),
              ),
            );
          }

          return const Center(child: Text("Waiting for host video..."));
        }),
      ),
    );
  }
}
