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
    return Scaffold(
      appBar: AppBar(
        title: Text(live != null ? "Live by ${live!.hostId}" : "Go Live"),
      ),
        body: Obx(() {
          if (controller.connecting.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Host mode
          if (controller.localVideoTrack != null && live == null) {
            return Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoTrackRenderer(controller.localVideoTrack!),
              ),
            );
          }

          // ✅ Viewer mode (FIXED)
          // Viewer mode
          if (live != null &&
              controller.room != null &&
              controller.room!.remoteParticipants.isNotEmpty) {

            final remoteParticipant =
                controller.room!.remoteParticipants.values.first;

            if (remoteParticipant.videoTrackPublications.isNotEmpty) {
              final publication =
                  remoteParticipant.videoTrackPublications.first;

              final remoteTrack = publication.track;

              if (remoteTrack != null) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoTrackRenderer(remoteTrack),
                  ),
                );
              }
            }
          }


          // Host start button
          if (live == null) {
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

          return const Center(child: Text("No live available"));
        }),

    );
  }
}
