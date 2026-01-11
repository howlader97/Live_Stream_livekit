import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:live_stream/app/modules/live_page/models/live_model.dart';

class CloudflareService {
  static const String baseUrl = "https://livekit-token.remonhowlader869.workers.dev";

  static Future<List<LiveModel>> getLiveList() async {
    final res = await http.get(Uri.parse("$baseUrl/live"));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => LiveModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<void> addLive({required String roomId, required String hostId}) async {
    await http.post(
      Uri.parse("$baseUrl/live"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "roomId": roomId,
        "hostId": hostId,
        "startedAt": DateTime.now().millisecondsSinceEpoch
      }),
    );
  }

  static Future<void> removeLive(String roomId) async {
    await http.delete(Uri.parse("$baseUrl/live/$roomId"));
  }
}
