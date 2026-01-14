class LiveModel {
  final String id;
  final String roomId;
  final String hostId;
  final String hostName; // ✅ এই লাইন যোগ করুন
  final String title;
  final String description;
  final int startedAt;
  final int viewerCount;
  final bool isActive;
  final Map<String, dynamic>? likes;
  final Map<String, dynamic>? comments;

  LiveModel({
    required this.id,
    required this.roomId,
    required this.hostId,
    required this.hostName, // ✅ parameter-এ যোগ করুন
    this.title = "Live Stream",
    this.description = "",
    required this.startedAt,
    this.viewerCount = 0,
    this.isActive = true,
    this.likes,
    this.comments,
  });

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      id: json['id'] ?? '',
      roomId: json['roomId'] ?? '',
      hostId: json['hostId'] ?? '',
      hostName: json['hostName'] ?? 'User', // ✅ fromJson-এ যোগ করুন
      title: json['title'] ?? 'Live Stream',
      description: json['description'] ?? '',
      startedAt: json['startedAt'] ?? DateTime.now().millisecondsSinceEpoch,
      viewerCount: json['viewerCount'] ?? 0,
      isActive: json['isActive'] ?? true,
      likes: json['likes'] != null
          ? Map<String, dynamic>.from(json['likes'])
          : null,
      comments: json['comments'] != null
          ? Map<String, dynamic>.from(json['comments'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'hostId': hostId,
      'hostName': hostName, // ✅ toJson-এ যোগ করুন
      'title': title,
      'description': description,
      'startedAt': startedAt,
      'viewerCount': viewerCount,
      'isActive': isActive,
      'likes': likes ?? {},
      'comments': comments ?? {},
    };
  }

  // Helper methods
  DateTime get startedDateTime => DateTime.fromMillisecondsSinceEpoch(startedAt);
  Duration get duration => DateTime.now().difference(startedDateTime);

  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  int get likeCount => likes?.length ?? 0;
  int get commentCount => comments?.length ?? 0;
}