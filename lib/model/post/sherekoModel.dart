// ignore: file_names
class SherekooModel {
  final String pId;
  final String createdBy;
  final String body;
  final String vedeo;
  final String ceremonyId;

  final String userId;
  final String username;
  final String avater;

  final String commentNumber;
  final String createdDate;

  //Ceremony Info
  final String cImage;
  final String crmUsername;

  SherekooModel(
      {required this.pId,
      required this.createdBy,
      required this.body,
      required this.vedeo,
      required this.ceremonyId,
      required this.userId,
      required this.username,
      required this.avater,
      required this.commentNumber,
      required this.createdDate,

      //Ceremony Info
      required this.cImage,
      required this.crmUsername});

  factory SherekooModel.fromJson(Map<String, dynamic> json) {
    return SherekooModel(
        pId: json['pId'] ?? "",
        createdBy: json['createdBy'] ?? "",
        vedeo: json['vedeo'] ?? "",
        ceremonyId: json['ceremonyId'] ?? "",
        body: json['body'] ?? "",
        userId: json['createdBy'] ?? "",
        username: json['username'] ?? "",
        avater: json['avater'] ?? "",
        commentNumber: json['commentNumber'] ?? "",
        createdDate: json['createdDate'] ?? "",

        //Ceremony Info
        cImage: json['cImage'] ?? "",
        crmUsername: json['crmUsername'] ?? "");
  }
}
