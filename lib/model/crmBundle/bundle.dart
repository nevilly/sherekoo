import '../InvCards/cards.dart';
import '../crmPackage/crmPackageModel.dart';
import '../crmPlan/plan.dart';
import '../crmSevers/Servers.dart';
import '../userModel.dart';

class Bundle {
  String id;
  String price;
  String bundleType;
  String aboutPackage;
  String bImage;
  String location;
  String around;
  String aboutBundle;
  String superVisorId;
  String bundleLevel;
  String createdBy;
  String createdDate;
  String amountOfPeople;
  String isBooking;

  CrmPckModel crmPackageInfo;

  String cardSampleId;
  Plan crmPlans;

  User superVisorInfo;
  List<ServersModel> crmServersInfo;
  List<CardsModel> cardsInfo;

  Bundle(
      {required this.id,
      required this.aboutPackage,
      required this.price,
      required this.bundleType,
      required this.bImage,
      required this.location,
      required this.around,
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
      required this.crmServersInfo,
      required this.superVisorInfo,
      required this.isBooking});

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'] ?? '',
      bImage: json['bImage'] ?? '',
      price: json['price'] ?? "",
      location: json['location'] ?? '',
      around: json['around'] ?? "",
      bundleType: json['bundleType'] ?? '',
      aboutBundle: json['aboutBundle'] ?? '',
      aboutPackage: json['aboutPackage'] ?? '',
      superVisorId: json['superVisorId'] ?? '',
      bundleLevel: json['bundleLevel'] ?? '',
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      cardSampleId: json['cardSampleId'],
      amountOfPeople: json['amountOfPeople'],
      isBooking: json['isBooking'].toString(),
      crmPlans: Plan.fromJson(json['crmPlans']),
      crmPackageInfo: CrmPckModel.fromJson(json['crmPackageInfo']),
      superVisorInfo: User.fromJson(json['superVisorInfo']),
      crmServersInfo: json['crmServersInfo']
          .map<ServersModel>((e) => ServersModel.fromJson(e))
          .toList(),
      cardsInfo: json['cardsInfo']
          .map<CardsModel>((e) => CardsModel.fromJson(e))
          .toList(),
    );
  }
}
