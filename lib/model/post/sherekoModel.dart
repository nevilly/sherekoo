// ignore: file_names
class SherekooModel {
  final String pId;
  final String createdBy;
  final String body;
  final String vedeo;

  final String userId;
  final String username;
  final String avater;


  // total Comments
  final String commentNumber;
  final String createdDate;

  //Ceremony Info
  final String ceremonyId;
  final String cImage;
  final String crmUsername;
  final String crmFid;
  final String crmYoutubeLink;

  //Likes Info
  final String totalLikes;
  dynamic isLike;

  SherekooModel(
      {required this.pId,
      required this.createdBy,
      required this.body,
      required this.vedeo,
      required this.userId,
      required this.username,
      required this.avater,
      required this.createdDate,

      //Chats
      required this.commentNumber,

      //Ceremony Info
      required this.ceremonyId,
      required this.cImage,
      required this.crmUsername,
      required this.crmFid,
      required this.crmYoutubeLink,

      //Likes Info
      required this.totalLikes,
      required this.isLike});

  factory SherekooModel.fromJson(Map<String, dynamic> json) {
    return SherekooModel(
      pId: json['pId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      vedeo: json['vedeo'] ?? "",
      body: json['body'] ?? "",
      userId: json['createdBy'] ?? "",
      username: json['username'] ?? "",
      avater: json['avater'] ?? "",
      createdDate: json['createdDate'] ?? "",

      //Ceremony Info
      ceremonyId: json['ceremonyId'] ?? "",
      cImage: json['cImage'] ?? "",
      crmUsername: json['crmUsername'] ?? "",
      crmYoutubeLink: json['crmYoutubeLink'] ?? "",
      crmFid: json['crmFid'] ?? "",

      //Chats
      commentNumber: json['commentNumber'].toString(),

      //Likes Info
      totalLikes: json['totalLikes'].toString(),
      isLike: json['isLike'] ?? "",
    );
  }
}
