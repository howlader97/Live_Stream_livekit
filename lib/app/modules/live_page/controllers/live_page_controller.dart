import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/service/cloud_flare_service.dart';
import '../../../data/service/live_kit_service.dart';
import '../models/live_model.dart';

class LivePageController extends GetxController {
  var connecting = false.obs;
  Room? room;
  LocalVideoTrack? localVideoTrack;

  Future<void> startLive({required String roomId, required String hostId}) async {
    try {
      connecting.value = true;

      await [Permission.camera, Permission.microphone].request();

      room = await LiveKitService.connectToRoom(roomId: roomId);

      await room!.localParticipant?.setCameraEnabled(true);
      await room!.localParticipant?.setMicrophoneEnabled(true);

      // Local video track
      localVideoTrack = room!.localParticipant!.videoTrackPublications.first.track as LocalVideoTrack;

      // Add to Cloudflare live list
      await CloudflareService.addLive(roomId: roomId, hostId: hostId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      connecting.value = false;
    }
  }

  void joinLive(LiveModel live) async {
    try {
      connecting.value = true;

      room = await LiveKitService.connectToRoom(roomId: live.roomId);

      // Viewer mode: camera & mic off
      await room!.localParticipant?.setCameraEnabled(false);
      await room!.localParticipant?.setMicrophoneEnabled(false);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      connecting.value = false;
    }
  }

  void endLive(String roomId) async {
    room?.disconnect();
    await CloudflareService.removeLive(roomId);
  }

  @override
  void onClose() {
    if (room != null) {
      endLive(room!.name!);
    }
    super.onClose();
  }
}
