import '../userModel.dart';

class CeremonyModel {
  final String cId;
  final String codeNo;
  final String cName;
  final String ceremonyType;
  final String fId;
  final String sId;
  final String cImage;
  final String ceremonyDate;
  final String contact;
  final String admin;
  final String youtubeLink;

  final User userFid; // gender fid

  final User userSid;

  CeremonyModel({
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

  factory CeremonyModel.fromJson(Map<String, dynamic> json) {
    return CeremonyModel(
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
