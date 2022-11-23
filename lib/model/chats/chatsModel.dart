import '../likesModel.dart';
import '../userModel.dart';

class ChatsModel {
  final String id;
  final String postId;
  final String userId;
  final String date;
  String? body;
      
  final String chatInitiator;

  final User userInfo;
   Likes likeInfo;

  ChatsModel({
    required this.postId,
    required this.id,
    required this.userId,
    required this.body,
    required this.userInfo,
    required this.likeInfo,
    required this.date,
    required this.chatInitiator,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    return ChatsModel(
      id: json['id'] ?? "",
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      date: json['createdDate'] ?? "",
      body: json['body'] ?? "",
      chatInitiator: json['chatInitiator'].toString(),
      userInfo: User.fromJson(json['userInfo']),
      likeInfo: Likes.fromJson(json['likeInfo']),
    );
  }
}
