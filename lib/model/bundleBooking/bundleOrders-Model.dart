import '../user/userModel.dart';

class BundleOrderModel {
  String id;
  String crmBundleId;
  String crmId;
  String ceremonyDate;
  String contact;
  String createdById;
  String createdDate;

  User userInfo;

  BundleOrderModel(
      {required this.id,
      required this.crmBundleId,
      required this.crmId,
      required this.ceremonyDate,
      required this.contact,
      required this.createdById,
      required this.createdDate,
      required this.userInfo});

  factory BundleOrderModel.fromJson(Map<String, dynamic> json) {
    return BundleOrderModel(
      id: json['id'] ?? '',
      crmBundleId: json['cardType'] ?? "",
      crmId: json['crmId'] ?? "",
      ceremonyDate: json['ceremonyDate'] ?? "",
      contact: json['contact'] ?? "",
      createdById: json['createdById'] ?? "",
      createdDate: json['createdDate'] ?? "",
      userInfo: User.fromJson(json['userInfo']),
    );
  }
}
