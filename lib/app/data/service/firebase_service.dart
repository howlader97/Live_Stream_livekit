import 'package:firebase_database/firebase_database.dart';
import 'package:live_stream/app/modules/live_page/models/live_model.dart';
import 'package:live_stream/app/modules/live_page/models/comment_model.dart';

class FirebaseService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Create or get user
  static Future<Map<String, dynamic>> getOrCreateUser() async {
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final userName = 'User${userId.substring(0, 5)}';

    return {
      'id': userId,
      'name': userName,
      'isAnonymous': true,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
  }


  // Add live to Firebase
  static Future<void> addLive({
    required String roomId,
    required String hostId,
    required String hostName,
    String title = "Live Stream",
  }) async {
    try {
      await _database.child('lives').child(roomId).set({
        'roomId': roomId,
        'hostId': hostId,
        'hostName': hostName,
        'title': title,
        'description': '',
        'startedAt': DateTime.now().millisecondsSinceEpoch,
        'viewerCount': 0,
        'isActive': true,
        'likes': {},
        'comments': {},
      });
      print('✅ Live added to Firebase: $roomId');
    } catch (e) {
      print('❌ Error adding live: $e');
      rethrow;
    }
  }

  // Remove live
  static Future<void> removeLive(String roomId) async {
    try {
      await _database.child('lives').child(roomId).remove();
      print('✅ Live removed: $roomId');
    } catch (e) {
      print('❌ Error removing live: $e');
    }
  }

  // Get all active lives
  static Stream<List<LiveModel>> getActiveLives() {
    return _database.child('lives')
        .orderByChild('isActive')
        .equalTo(true)
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return [];

      final Map<dynamic, dynamic> data = event.snapshot.value as Map;
      final List<LiveModel> lives = [];

      data.forEach((key, value) {
        try {
          final live = LiveModel.fromJson({
            'id': key,
            'hostName': value['hostName'] ?? 'User', // ✅ এখানে যোগ করুন
            ...Map<String, dynamic>.from(value),
          });
          lives.add(live);
        } catch (e) {
          print('❌ Error parsing live: $e');
        }
      });

      return lives;
    });
  }


  // Update viewer count
  static Future<void> updateViewerCount(String roomId, int count) async {
    try {
      await _database.child('lives').child(roomId).update({
        'viewerCount': count,
      });
    } catch (e) {
      print('❌ Error updating viewer count: $e');
    }
  }

  // Like system
  static Future<void> likeLive({
    required String roomId,
    required String userId,
    required String userName,
  }) async {
    try {
      await _database.child('lives').child(roomId).child('likes').child(userId).set({
        'userId': userId,
        'userName': userName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      print('❌ Error liking: $e');
    }
  }

  static Future<void> unlikeLive({
    required String roomId,
    required String userId,
  }) async {
    try {
      await _database.child('lives').child(roomId).child('likes').child(userId).remove();
    } catch (e) {
      print('❌ Error unliking: $e');
    }
  }

  // Comments
  static Future<void> addComment({
    required String roomId,
    required String userId,
    required String userName,
    required String text,
  }) async {
    try {
      final commentId = _database.child('comments').push().key;
      await _database.child('lives').child(roomId).child('comments').child(commentId!).set({
        'id': commentId,
        'userId': userId,
        'userName': userName,
        'text': text,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      print('❌ Error adding comment: $e');
    }
  }

  static Stream<List<CommentModel>> getComments(String roomId) {
    return _database.child('lives').child(roomId).child('comments')
        .orderByChild('timestamp')
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return [];

      final Map<dynamic, dynamic> data = event.snapshot.value as Map;
      final List<CommentModel> comments = [];

      data.forEach((key, value) {
        try {
          comments.add(CommentModel.fromJson({
            'id': key,
            ...Map<String, dynamic>.from(value),
          }));
        } catch (e) {
          print('❌ Error parsing comment: $e');
        }
      });

      comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return comments;
    });
  }

  // 🔥 Like count stream (RTDB)
  static Stream<int> getLikes(String roomId) {
    return _database
        .child('lives')
        .child(roomId)
        .child('likes')
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return 0;

      final Map<dynamic, dynamic> data =
      event.snapshot.value as Map<dynamic, dynamic>;
      return data.length;
    });
  }

// ❤️ Check if user liked this live
  static Stream<bool> isLikedByUser(String roomId, String userId) {
    return _database
        .child('lives')
        .child(roomId)
        .child('likes')
        .child(userId)
        .onValue
        .map((event) => event.snapshot.exists);
  }

}