import 'package:sherekoo/model/userModel.dart';

class BgMnthRegMembersModel {
  String id;
  String userId;
  String tvShowId;
  String contact;
  String dateBirth;
  String status;
  String createdDate;
  User userInfo;

  BgMnthRegMembersModel({
    required this.id,
    required this.userId,
    required this.tvShowId,
    required this.contact,
    required this.dateBirth,
    required this.status,
    required this.createdDate,
    required this.userInfo,
  });

  factory BgMnthRegMembersModel.fromJson(Map<String, dynamic> json) {
    // print(json['isRegistered']);
    return BgMnthRegMembersModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? "",
      tvShowId: json['tvShowId'] ?? "",
      contact: json['contact'] ?? "",
      dateBirth: json['dateBirth'] ?? "",
      status: json['status'] ?? "",
      createdDate: json['createdDate'] ?? "",
      userInfo: User.fromJson(json['userInfo']),
    );
  }
}
