import '../user/userModel.dart';

class ReplyModel {
  final String id;
  final String postId;
  final String chatId;
  final String userId;
  final String date;
  String? body;

  final User userInfo;

  ReplyModel({
    required this.postId,
    required this.id,
    required this.userId,
    required this.body,
    required this.userInfo,
    required this.chatId,
    required this.date,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      id: json['id'] ?? "",
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      date: json['createdDate'] ?? "",
      body: json['body'] ?? "",
      chatId: json['chatId'] ?? "",
      userInfo: User.fromJson(json['userInfo']),
    );
  }
}
