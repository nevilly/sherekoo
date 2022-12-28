import 'package:sherekoo/model/user/userModel.dart';

class MshengaWarRegisteredMembersModel {
  String id;
  String userId;
  String tvShowId;
  String contact;

  String status;
  String createdDate;
  User userInfo;

  MshengaWarRegisteredMembersModel({
    required this.id,
    required this.userId,
    required this.tvShowId,
    required this.contact,
   
    required this.status,
    required this.createdDate,
    required this.userInfo,
  });

  factory MshengaWarRegisteredMembersModel.fromJson(Map<String, dynamic> json) {
    // print(json['isRegistered']);
    return MshengaWarRegisteredMembersModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? "",
      tvShowId: json['tvShowId'] ?? "",
      contact: json['contact'] ?? "",
  
      status: json['status'] ?? "",
      createdDate: json['createdDate'] ?? "",
      userInfo: User.fromJson(json['userInfo']),
    );
  }
}
