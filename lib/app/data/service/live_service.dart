import 'dart:convert';

import 'package:http/http.dart' as http;

class LiveService {
  static Future<dynamic> liveServiceRequest(String url,
      Map<String, dynamic>body) {
    try {
      final response = http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      return response;
    }catch(e){
      throw "Request error is $e";
    }
  }
}