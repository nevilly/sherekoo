import 'package:sherekoo/model/userModel.dart';

class AdminCrmMdl {
  String cId;
  String codeNo;
  String cName;
  String ceremonyType;
  String fId;
  String sId;
  String cImage;
  String ceremonyDate;
  String contact;
  String admin;

  final User userFid;

  final User userSid;

  String youtubeLink;

  AdminCrmMdl({
    required this.cId,
    required this.codeNo,
    required this.ceremonyType,
    required this.cName,
    required this.fId,
    required this.sId,
    required this.cImage,
    required this.ceremonyDate,
    required this.contact,
    required this.admin,
    required this.userFid,
    required this.userSid,
    required this.youtubeLink,
  });

  factory AdminCrmMdl.fromJson(Map<String, dynamic> json) {
    return AdminCrmMdl(
      cId: json['cId'] ?? '',
      codeNo: json['codeNo'] ?? '',
      cName: json['cName'] ?? '',
      ceremonyType: json['ceremonyType'] ?? '',
      fId: json['fId'] ?? '',
      sId: json['sId'] ?? '',
      cImage: json['cImage'] ?? '',
      ceremonyDate: json['ceremonyDate'] ?? '',
      contact: json['contact'] ?? '',
      admin: json['admin'] ?? '',
      userFid: User.fromJson(json['userFid']),
      userSid: User.fromJson(json['userSid']),
      youtubeLink: json['goLiveId'] ?? '',
    );
  }
}
