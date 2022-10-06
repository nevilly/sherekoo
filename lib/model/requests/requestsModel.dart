import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

class RequestsModel {
  final String hostId;
  final String busnessId;
  final String ceremonyId;

  final String createdBy;
  final String createdDate;
  String confirm;

  //Ceremony Model
  final CeremonyModel crmInfo;

  //Busness Data
  final BusnessModel bsnInfo;

  //Service Info
  final String isInService;
  final String svId;
  final String svPayStatus;
  final String svAmount;

  //subscription Model
  final String subId;
  final String level;
  final String categoryId;
  final String activeted;
  final String startTime;
  final String endTime;

  RequestsModel({
    //Request Model
    required this.hostId,
    required this.busnessId,
    required this.ceremonyId,
    required this.createdDate,
    required this.confirm,
    required this.createdBy,

    //Busness Model
    required this.bsnInfo,

    //Ceremon Model
    required this.crmInfo,

    // Service Model
    required this.isInService,
    required this.svId,
    required this.svPayStatus,
    required this.svAmount,

    //SubScription Model
    required this.subId,
    required this.level,
    required this.activeted,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      hostId: json['hostId'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      busnessId: json['busnessId'] ?? "",

      confirm: json['confirm'] ?? "",

      //Ceremony Model
      crmInfo: CeremonyModel.fromJson(json['crmInfo']),

      // Busness Model
      bsnInfo: BusnessModel.fromJson(json['bsnInfo']),
      createdDate: json['createdDate'] ?? "",

      createdBy: json['createdBy'] ?? "",

      //SubScription Model
      subId: json['subId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      activeted: json['activeted'] ?? "",
      level: json['level'] ?? "",

      // Services Info
      isInService: json['isInService'].toString(),
      svId: json['svId'] ?? "",
      svPayStatus: json['svPayStatus'] ?? "",
      svAmount: json['svAmount'] ?? "",
    );
  }
}
