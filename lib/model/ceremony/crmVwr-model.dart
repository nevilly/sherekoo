import '../mchango/mchango-model.dart';
import '../user/userModel.dart';
import 'crm-model.dart';

class CrmViewersModel {
  final String id;
  final String userId;
  final String crmId;
  final String name;
  final String contact;

  final String position;

  final CeremonyModel crmInfo;
  MchangoModel mchangoInfo;

  // // Admin info
  final User viewerInfo;

  final String isAdmin;

  CrmViewersModel(
      {required this.id,
      required this.userId,
      required this.crmId,
      required this.name,
      required this.contact,
      required this.position,
      required this.crmInfo,
      required this.viewerInfo,
      required this.mchangoInfo,
      required this.isAdmin});

  factory CrmViewersModel.fromJson(Map<String, dynamic> json) {
    return CrmViewersModel(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        crmId: json['crmId'] ?? '',
        name: json['name'] ?? '',
        contact: json['contact'] ?? '',
        position: json['position'] ?? '',
        isAdmin: json['isAdmin'].toString(),
        crmInfo: CeremonyModel.fromJson(json['crmInfo']),
        mchangoInfo: MchangoModel.fromJson(json['mchangoInfo']),
        viewerInfo: User.fromJson(json['viewerInfo']));
  }
}
