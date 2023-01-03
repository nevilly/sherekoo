// user with Ceremony Viewer Model
import 'package:sherekoo/model/ceremony/crmVwr-model.dart';

class UserCrmVwr {
  String? id,
      username,
      firstname,
      lastname,
      avater,
      phoneNo,
      email,
      gender,
      address,
      meritalStatus,
      role,
      bio,
      whatYouDo,
      followInfo,
      currentFllwId,
      totalFollowers,
      totalFollowing,
      totalLikes,
      totalPost;
  final dynamic isCurrentUser, isCurrentCrmAdmin, isCurrentBsnAdmin;
  CrmViewersModel crmVwrInfo;
  final String isInCrmVwr;

  UserCrmVwr({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.avater,
    this.phoneNo,
    this.email,
    this.gender,
    this.role,
    this.address,
    this.meritalStatus,
    this.bio,
    this.whatYouDo,
    this.currentFllwId,
    this.followInfo,
    this.totalPost,
    this.isCurrentUser,
    this.isCurrentCrmAdmin,
    this.isCurrentBsnAdmin,
    // total
    required this.crmVwrInfo,
    required this.isInCrmVwr,
  });

  factory UserCrmVwr.fromJson(Map<String, dynamic> json) {
    return UserCrmVwr(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      firstname: json['firstname'] ?? "",
      lastname: json['lastname'] ?? "",
      avater: json['avater'] ?? "",
      phoneNo: json['phoneNo'] ?? "",
      email: json['email'] ?? "",
      gender: json['gender'] ?? "",
      address: json['address'] ?? "",
      isCurrentUser: json['isCurrentUser'] ?? "",
      currentFllwId: json['currentFllwId'] ?? "",
      isCurrentCrmAdmin: json['crmAdmin'] ?? '',
      isCurrentBsnAdmin: json['bsnAdmin'] ?? '',
      followInfo: json['followInfo'] ?? '',
      role: json['role'] ?? "",
      meritalStatus: json['merital_status'] ?? "",
      bio: json['bio'] ?? "",
      whatYouDo: json['whatYouDo'] ?? "",
      isInCrmVwr: json['isInCrmVwr'].toString(),
      //total

      crmVwrInfo: CrmViewersModel.fromJson(json['crmViewerInfo']),
    );
  }
}
