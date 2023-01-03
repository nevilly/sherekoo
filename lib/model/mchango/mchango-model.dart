import 'mchangoPayment-model.dart';

class MchangoModel {
  final String id;
  final String crmId;
  final String viewerId;
  String? ahadi;
  String? totalPayInfo; // real Cash/Money

  List<MchangoPaymentModel> mchangoPayInfo;

  MchangoModel({
    required this.id,
    required this.crmId,
    required this.viewerId,
    required this.ahadi,
    required this.totalPayInfo,
    required this.mchangoPayInfo,
  });

  factory MchangoModel.fromJson(Map<String, dynamic> json) {
    return MchangoModel(
        id: json['id'] ?? '',
        crmId: json['userId'] ?? '',
        viewerId: json['viewerId'] ?? '',
        ahadi: json['ahadi'] ?? '',
        totalPayInfo:json['totalPayInfo'].toString(),
        mchangoPayInfo: json['mchangoPayInfo']
            .map<MchangoPaymentModel>((e) => MchangoPaymentModel.fromJson(e))
            .toList());
  }
}
