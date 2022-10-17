import '../InvCards/cards.dart';
import '../crmPackage/crmPackageModel.dart';
import '../crmPlan/plan.dart';
import '../crmSevers/Servers.dart';

class Bundle {
  String id;
  String price;
  String bundleType;
  String aboutPackage;
  String bImage;
  String location;
  String aboutBundle;
  String superVisorId;
  String bundleLevel;
  String createdBy;
  String createdDate;
  String amountOfPeople;

  CrmPckModel crmPackageInfo;

  String cardSampleId;
  Plan crmPlans;
  List<ServersModel> crmServersInfo;
  List<CardsModel> cardsInfo;

  Bundle(
      {required this.id,
      required this.aboutPackage,
      required this.price,
      required this.bundleType,
      required this.bImage,
      required this.location,
      required this.aboutBundle,
      required this.cardSampleId,
      required this.superVisorId,
      required this.amountOfPeople,
      required this.bundleLevel,
      required this.createdBy,
      required this.createdDate,
      required this.crmPlans,
      required this.cardsInfo,
      required this.crmPackageInfo,
      required this.crmServersInfo});

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'] ?? '',
      bImage: json['bImage'] ?? '',
      price: json['price'] ?? "",
      location: json['location'] ?? '',
      bundleType: json['bundleType'] ?? '',
      aboutBundle: json['aboutBundle'] ?? '',
      aboutPackage: json['aboutPackage'] ?? '',
      superVisorId: json['superVisorId'] ?? '',
      bundleLevel: json['bundleLevel'] ?? '',
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      cardSampleId: json['cardSampleId'],
      amountOfPeople: json['amountOfPeople'],
      crmPlans: Plan.fromJson(json['crmPlans']),
      crmPackageInfo: CrmPckModel.fromJson(json['crmPackageInfo']),
      crmServersInfo: json['crmServersInfo']
          .map<ServersModel>((e) => ServersModel.fromJson(e))
          .toList(),
      cardsInfo: json['cardsInfo']
          .map<CardsModel>((e) => CardsModel.fromJson(e))
          .toList(),
    );
  }
}