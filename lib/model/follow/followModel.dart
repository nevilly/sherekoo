import '../userModel.dart';

class FollowModel {
  final String id;
  final String followerId;
  final String followId;
  final String followBack;
  final String followType;

  final User follosInfo;

  FollowModel({
    required this.id,
    required this.followerId,
    required this.followId,
    required this.follosInfo,
    required this.followBack,
    required this.followType,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      id: json['id'] ?? "",
      followerId: json['followerId'] ?? "",
      followId: json['followId'] ?? "",
      followBack: json['followBack'] ?? "",
      followType: json['followType'] ?? "",
      follosInfo: User.fromJson(json['follosInfo']),
    );
  }
}
