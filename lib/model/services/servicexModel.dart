import '../busness/busnessModel.dart';
import '../ceremony/crm-model.dart';

class ServicexModel {
  final String svId;
  final String busnessId;
  final String ceremonyId;
  final String confirm;
  final String createdBy;
  final String createdDate;
  final String payed;
  final String amount;

// Ceremony Model
  CeremonyModel? crmInfo;

// Busness Data
  BusnessModel? bsnInfo;

  //subscription Model
  final String subId;
  final String level;
  final String categoryId;
  final String activeted;
  final String startTime;
  final String endTime;

  ServicexModel({
    required this.busnessId,
    required this.createdDate,
    required this.svId,
    required this.payed,
    required this.amount,
    required this.confirm,
    required this.ceremonyId,
    required this.createdBy,

    //Ceremon Model
    required this.crmInfo,

    //Busness Model
    required this.bsnInfo,

    //SubScription Model
    required this.subId,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
    required this.level,
    required this.activeted,
  });

  factory ServicexModel.fromJson(Map<String, dynamic> json) {
    return ServicexModel(
      svId: json['svId'] ?? "",
      confirm: json['confirm'] ?? "",
      payed: json['payed'] ?? "",
      amount: json['amount'] ?? "",
      busnessId: json['busnessId'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      //Ceremony Model
      crmInfo: CeremonyModel.fromJson(json['crmInfo']),
      // Busness Data
      bsnInfo: BusnessModel.fromJson(json['bsnInfo']),


      //SubScription Model
      subId: json['subId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      activeted: json['activeted'] ?? "",
      level: json['level'] ?? "", 
    );
  }
}
