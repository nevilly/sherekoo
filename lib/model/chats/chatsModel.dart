class ChatsModel {
  final String id;
  final String postId;
  final String userId;
  final String date;
  final String body;

  final String username;
  final String avater;

  ChatsModel({
    required this.postId,
    required this.id,
    required this.userId,
    required this.body,
    required this.username,
    required this.date,
    required this.avater,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    return ChatsModel(
      id: json['id'] ?? "",
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      date: json['createdDate'] ?? "",
      body: json['body'] ?? "",
      username: json['username'] ?? "",
      avater: json['avater'] ?? "",
    );
  }
}
