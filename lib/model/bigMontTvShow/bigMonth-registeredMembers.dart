
import 'bigMnth-Reg-Memb.dart';

class BigMonthRegisteredModel {
  String id;
  String title;
  String description;
  String season;
  String episode;
  String showImage;
  String dedline;
  String showDate;
  String judgesId;
  String superStarsId;
  String status;
  List<BgMnthRegMembersModel> registerMembersInfo;

  String createdDate;

  BigMonthRegisteredModel({
    required this.id,
    required this.title,
    required this.description,
    required this.season,
    required this.episode,
    required this.showImage,
    required this.dedline,
    required this.showDate,
    required this.judgesId,
    required this.superStarsId,
    required this.status,
    required this.registerMembersInfo,
    required this.createdDate,
  });

  factory BigMonthRegisteredModel.fromJson(Map<String, dynamic> json) {
    // print(json['isRegistered']);
    return BigMonthRegisteredModel(
      id: json['id'] ?? '',
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      season: json['season'] ?? "",
      episode: json['episode'] ?? "",
      showImage: json['showImage'] ?? "",
      dedline: json['dedline'] ?? "",
      showDate: json['showDate'] ?? "",
      judgesId: json['judgesId'] ?? "",
      superStarsId: json['superStarsId'] ?? "",
      status: json['status'].toString(),
      registerMembersInfo: json['registerMembersInfo']
          .map<BgMnthRegMembersModel>((e) => BgMnthRegMembersModel.fromJson(e))
          .toList(),
      createdDate: json['createdDate'] ?? "",
    );
  }
}
