import '../user/userModel.dart';

class CeremonyModel {
  final  String cId;
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
  final String isCrmAdmin;
  final String isInFuture;
  final String chatNo;
  final String viwersNo;
  final String likeNo;

  final User userFid; // gender fid

  final User userSid;

  CeremonyModel(
    {
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
      required this.isCrmAdmin,
      required this.chatNo,
      required this.likeNo,
      required this.viwersNo,
      required this.isInFuture});

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
        viwersNo: json['viwersNo'].toString(),
        likeNo: json['likeNo'].toString(),
        chatNo: json['chatNo'].toString(),
        isCrmAdmin: json['isCrmAdmin'].toString(),
        isInFuture: json['isInFuture'].toString());
  }
}
