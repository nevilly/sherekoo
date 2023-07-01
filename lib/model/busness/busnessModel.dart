import 'package:sherekoo/model/user/userModel.dart';

import '../subScription/subsrModel.dart';

class BusnessModel {
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String aboutCEO;
  final String companyName;
  final String ceoId;
  final String location;
  final String contact;
  final String mediaUrl;

  final String hotStatus;
  final String aboutCompany;
  final String createdBy;
  final String createdDate;
  final String isBsnAdmin;
  final String work;
  List works = [];
  final User user;

  // subscription
  SubscriptionModel? subscriptionInfo;

  BusnessModel({
    required this.location,
    required this.bId,
    required this.mediaUrl,
    required this.knownAs,
    required this.coProfile,
    required this.busnessType,
    required this.createdDate,
    required this.companyName,
    required this.ceoId,
    required this.price,
    required this.contact,
    required this.hotStatus,
    required this.aboutCEO,
    required this.aboutCompany,
    required this.createdBy,
    required this.user,
    required this.work,
    required this.works,
    required this.subscriptionInfo,
    required this.isBsnAdmin,
  });

  factory BusnessModel.fromJson(Map<String, dynamic> json) {
    return BusnessModel(
      bId: json['bId'] ?? "",
      mediaUrl: json['mediaUrl'] ?? "",
      busnessType: json['busnessType'] ?? "",
      companyName: json['companyName'] ?? "",
      aboutCEO: json['aboutCEO'] ?? "",
      coProfile: json['coProfile'] ?? "",
      knownAs: json['knownAs'] ?? "",
      price: json['price'] ?? "",
      ceoId: json['ceoId'] ?? "",
      aboutCompany: json['aboutCompany'] ?? "",
      hotStatus: json['hotStatus'] ?? "",
      contact: json['contact'] ?? "",
      location: json['location'] ?? "",
      work: json['work'] ?? "",
      works: json['works'],
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      isBsnAdmin: json['isBsnAdmin'].toString(),
      user: User.fromJson(json['user']),
      subscriptionInfo: SubscriptionModel.fromJson(json['subscriptionInfo']),
    );
  }
}
