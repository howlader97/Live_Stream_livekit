import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/service/cloud_flare_service.dart';
import '../../../data/service/live_kit_service.dart';
import '../models/live_model.dart';

class LivePageController extends GetxController {
  var connecting = false.obs;

  Room? room;
  CancelListenFunc? _cancelRoomListener;

  LocalVideoTrack? localVideoTrack;
  final Rx<VideoTrack?> remoteVideoTrack = Rx<VideoTrack?>(null);

  bool get isHost => _live == null;
  LiveModel? _live;

  void setLive(LiveModel? live) {
    _live = live;
  }

  Future<void> startLive({required String roomId, required String hostId}) async {
    try {
      connecting.value = true;

      // Request camera/mic for host
      await [Permission.camera, Permission.microphone].request();

      room = await LiveKitService.connectToRoom(roomId: roomId);

      await room!.localParticipant?.setCameraEnabled(true);
      await room!.localParticipant?.setMicrophoneEnabled(true);

      final pubs = room!.localParticipant!.videoTrackPublications;
      if (pubs.isNotEmpty) {
        localVideoTrack = pubs.first.track as LocalVideoTrack;
      }

      _cancelRoomListener = room!.events.listen(_onRoomEvent);

      // Add live to Cloudflare
      await CloudflareService.addLive(roomId: roomId, hostId: hostId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      connecting.value = false;
    }
  }

  Future<void> joinLive(LiveModel live) async {
    try {
      connecting.value = true;

      room = await LiveKitService.connectToRoom(roomId: live.roomId);

      // Viewer: camera/mic off
      await room!.localParticipant?.setCameraEnabled(false);
      await room!.localParticipant?.setMicrophoneEnabled(false);

      _cancelRoomListener = room!.events.listen(_onRoomEvent);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      connecting.value = false;
    }
  }

  void _onRoomEvent(RoomEvent event) {
    if (event is TrackSubscribedEvent &&
        event.track is VideoTrack &&
        remoteVideoTrack.value == null) {
      remoteVideoTrack.value = event.track as VideoTrack;
    }
  }

  /// Host stop live
  Future<void> stopLive() async {
    if (!isHost) return; // Viewer can't stop host live

    if (room != null) {
      await CloudflareService.removeLive(room!.name!);

      _cancelRoomListener?.call();
      _cancelRoomListener = null;

      await room!.disconnect();

      room = null;
      localVideoTrack = null;
      remoteVideoTrack.value = null;
    }
  }

  /// Viewer leave live
  Future<void> leaveLive() async {
    if (isHost) {
      await stopLive();
      return;
    }

    if (room != null) {
      _cancelRoomListener?.call();
      _cancelRoomListener = null;

      await room!.disconnect();

      room = null;
      remoteVideoTrack.value = null;
    }
  }

  @override
  void onClose() {
    _cancelRoomListener?.call();
    room?.disconnect();
    super.onClose();
  }
}
