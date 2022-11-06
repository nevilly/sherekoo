import 'package:sherekoo/model/userModel.dart';

class MshengaWarModel {
  String id;
  String title;
  String description;
  String season;
  String episode;
  String showImage;
  String dedline;
  String showDate;
  String washengaId;
  String status;
  String isRegistered;
  List<User> washengaInfo;
  String createdDate;

  MshengaWarModel({
    required this.id,
    required this.title,
    required this.description,
    required this.season,
    required this.episode,
    required this.showImage,
    required this.dedline,
    required this.showDate,
    required this.washengaId,
    required this.status,
    required this.isRegistered,
    required this.washengaInfo,
    required this.createdDate,
  });

  factory MshengaWarModel.fromJson(Map<String, dynamic> json) {
    // print(json['isRegistered']);
    return MshengaWarModel(
      id: json['id'] ?? '',
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      season: json['season'] ?? "",
      episode: json['episode'] ?? "",
      showImage: json['showImage'] ?? "",
      dedline: json['dedline'] ?? "",
      showDate: json['showDate'] ?? "",
      washengaId: json['washengaId'] ?? "",
      status: json['status'].toString(),
      isRegistered: json['isRegistered'].toString(),
      washengaInfo:
          json['washengaInfo'].map<User>((e) => User.fromJson(e)).toList(),
      createdDate: json['createdDate'] ?? "",
    );
  }
}
