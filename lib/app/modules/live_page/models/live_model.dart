class LiveModel {
  final String roomId;
  final String hostId;
  final int startedAt;

  LiveModel({
    required this.roomId,
    required this.hostId,
    required this.startedAt,
  });

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      roomId: json['roomId'],
      hostId: json['hostId'],
      startedAt: json['startedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'roomId': roomId,
    'hostId': hostId,
    'startedAt': startedAt,
  };
}
