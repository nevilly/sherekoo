

import '../requests/requestsModel.dart';
import '../subScription/subsrModel.dart';
import '../user/userModel.dart';

class AdmnBsnModel {
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

  final String hotStatus;
  final String aboutCompany;
  final String createdBy;
  final String createdDate;
  final String isBsnAdmin;

  final User user;

  List<RequestsModel> req;

  // subscription
  SubscriptionModel? subscriptionInfo;

  AdmnBsnModel({
    required this.location,
    required this.bId,
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
    required this.subscriptionInfo,
    required this.isBsnAdmin,
    required this.req
  });

  factory AdmnBsnModel.fromJson(Map<String, dynamic> json) {
    return AdmnBsnModel(
      bId: json['bId'] ?? "",
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
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      isBsnAdmin: json['isBsnAdmin'].toString(),
      user: User.fromJson(json['user']),
      subscriptionInfo: SubscriptionModel.fromJson(json['subscriptionInfo']),
       req: json['req']
            .map<RequestsModel>((e) => RequestsModel.fromJson(e))
            .toList()
    );
  }
}
