import 'package:sherekoo/model/userModel.dart';

class BigMonthModel {
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
  String isUserIdRegister;
  List<User> judgesInfo;
  List<User> superStarInfo;
  String createdDate;

  BigMonthModel({
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
    required this.isUserIdRegister,
    required this.judgesInfo,
    required this.superStarInfo,
    required this.createdDate,
  });

  factory BigMonthModel.fromJson(Map<String, dynamic> json) {
    // print(json['isRegistered']);
    return BigMonthModel(
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
      isUserIdRegister: json['isUserIdRegister'].toString(),
      superStarInfo:
          json['superStarsInfo'].map<User>((e) => User.fromJson(e)).toList(),
      judgesInfo:
          json['judgesInfo'].map<User>((e) => User.fromJson(e)).toList(),
      createdDate: json['createdDate'] ?? "",
    );
  }
}
