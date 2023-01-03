import 'package:sherekoo/model/ceremony/crm-model.dart';

import '../user/userModel.dart';

class BudgetModel {
  String? id,
      crmId,
      amount,
      minContribution,
      michangoPayment,
      createdBy,
      createdDate;

  User user;

  CeremonyModel crmInfo;

  BudgetModel({
    required this.id,
    required this.crmId,
    required this.amount,
    required this.minContribution,
    required this.michangoPayment,
    required this.createdBy,
    required this.createdDate,
    required this.user,
    required this.crmInfo,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'] ?? "",
      crmId: json['crmId'] ?? "",
      amount: json['amount'] ?? "",
      minContribution: json['min_contribution'] ?? "",
      michangoPayment: json['michangoPayment'].toString(),
      createdBy: json['createdBy'] ?? "",
      createdDate: json['createdDate'] ?? "",
      user: User.fromJson(json['user']),
      crmInfo: CeremonyModel.fromJson(json['crmInfo']),
    );
  }
}
