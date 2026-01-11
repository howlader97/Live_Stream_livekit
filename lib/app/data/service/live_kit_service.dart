import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  static const String tokenUrl = "https://livekit-token.remonhowlader869.workers.dev";
  static const String livekitUrl = "wss://liveworld-l78cuzu0.livekit.cloud";

  static Future<Room> connectToRoom({String? roomId}) async {
    // Token fetch
    final url = roomId != null ? "$tokenUrl?room=$roomId" : tokenUrl;
    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) {
      throw Exception("Token fetch failed");
    }

    final token = jsonDecode(res.body)['token'];

    final room = Room();
    await room.connect(livekitUrl, token);

    return room;
  }
}
