import 'package:sherekoo/model/busness/busnessModel.dart';

class ServersModel {
  String id;
  String crmBundleId;
  String bsnId;
  String rates;
  String createdDate;

  BusnessModel bsnInfo;

  ServersModel(
      {required this.id,
      required this.rates,
      required this.bsnId,
      required this.crmBundleId,
      required this.createdDate,
      required this.bsnInfo});

  factory ServersModel.fromJson(Map<String, dynamic> json) {
    
    return ServersModel(
      id: json['id'] ?? '',
      crmBundleId: json['crmBundleId'] ?? '',
      bsnId: json['bsnId'] ?? '',
      createdDate: json['createdDate'],
      rates: json['rates'],
      bsnInfo: BusnessModel.fromJson(json['bsnInfo']),
    );
  }
}
