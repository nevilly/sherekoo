// ignore: file_names
import '../ceremony/ceremonyModel.dart';
import '../userModel.dart';

class SherekooModel {
  final String pId;
  final String createdBy;
  final String ceremonyId;
  final String body;
  final String vedeo;

  final String isPostAdmin;

  User creatorInfo;

  // total Comments
  final String commentNumber;
  final String createdDate;

  //Ceremony Info
  final CeremonyModel crmInfo;

  //Likes Info
   String? totalLikes;
  dynamic isLike;
  // Shares info
  final String totalShare;

  //Ceremony Viewer
  dynamic crmViewer;

  //hashTag
  final String hashTag;

  SherekooModel(
      {required this.pId,
      required this.createdBy,
      required this.ceremonyId,
      required this.body,
      required this.vedeo,
      required this.creatorInfo,
      required this.createdDate,

      //Chats
      required this.commentNumber,

      //Ceremony Info
      required this.crmInfo,

      //Likes Info
      required this.totalLikes,
      required this.isLike,

      //Share Info
      required this.totalShare,

      //hashTag
      required this.hashTag,

      // Is Post Admin
      required this.isPostAdmin,

      //Ceremony Viewer
      required this.crmViewer});

  factory SherekooModel.fromJson(Map<String, dynamic> json) {
    return SherekooModel(
        pId: json['pId'] ?? "",
        createdBy: json['createdBy'] ?? "",
        vedeo: json['vedeo'] ?? "",
        body: json['body'] ?? "",
        ceremonyId: json['ceremonyId'].toString(),
        creatorInfo: User.fromJson(json['creatorInfo']),
        createdDate: json['createdDate'] ?? "",

        //Ceremony Info
        crmInfo: CeremonyModel.fromJson(json['crmInfo']),

        //Chats
        commentNumber: json['commentNumber'].toString(),
        isPostAdmin: json['isPostAdmin'].toString(),

        //Likes Info
        totalLikes: json['totalLikes'].toString(),
        isLike: json['isLike'] ?? "",
        // Share info
        totalShare: json['totalShare'].toString(),

        // hashTag
        hashTag: json['hashTag'] ?? "",
        // Crm Viewr info
        crmViewer: json['crmViewer'] ?? "");
  }
}
