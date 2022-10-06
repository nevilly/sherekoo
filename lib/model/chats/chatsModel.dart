import '../userModel.dart';

class ChatsModel {
  final String id;
  final String postId;
  final String userId;
  final String date;
  final String body;

  final User userInfo;

  ChatsModel({
    required this.postId,
    required this.id,
    required this.userId,
    required this.body,
    required this.userInfo,
    required this.date,
  
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    return ChatsModel(
      id: json['id'] ?? "",
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      date: json['createdDate'] ?? "",
      body: json['body'] ?? "",
      userInfo:User.fromJson(json['userInfo']) ,
      
    );
  }
}
