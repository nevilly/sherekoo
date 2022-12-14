import 'package:sherekoo/model/busness/busnessModel.dart';

class erversModel {
  String id;
  String crmBundleId;
  String bsnId;
  String rates;
  String createdDate;

  BusnessModel bsnInfo;

  erversModel(
      {required this.id,
      required this.rates,
      required this.bsnId,
      required this.crmBundleId,
      required this.createdDate,
      required this.bsnInfo});

  factory erversModel.fromJson(Map<String, dynamic> json) {
    
    return erversModel(
      id: json['id'] ?? '',
      crmBundleId: json['crmBundleId'] ?? '',
      bsnId: json['bsnId'] ?? '',
      createdDate: json['createdDate'],
      rates: json['rates'],
      bsnInfo: BusnessModel.fromJson(json['bsnInfo']),
    );
  }
}
