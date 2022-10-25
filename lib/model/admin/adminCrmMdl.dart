


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
  String youtubeLink;

  final User userFid;

  final User userSid;

  // List<RequestsModel> req;

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
    // required this.req,
  });

  factory AdminCrmMdl.fromJson(Map<dynamic, dynamic> json) {
    // print('am Heree');
    // print(json['req']);
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
        youtubeLink: json['goLiveId'] ?? '',
        userFid: User.fromJson(json['userFid']),
        userSid: User.fromJson(json['userSid'])
        // req: json['req']
        //     .map<RequestsModel>((e) => RequestsModel.fromJson(e))
        //     .toList
        );
  }
}
