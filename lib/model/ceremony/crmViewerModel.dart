import '../userModel.dart';
import 'ceremonyModel.dart';

class CrmViewersModel {
  final String id;
  final String userId;

  final String position;

  final CeremonyModel crmInfo;

  // // Admin info
  final User viewerInfo;

  final String isAdmin;

  CrmViewersModel(
      {required this.id,
      required this.userId,
      required this.position,
      required this.crmInfo,
      required this.viewerInfo,
      required this.isAdmin});

  factory CrmViewersModel.fromJson(Map<String, dynamic> json) {
    return CrmViewersModel(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        position: json['position'] ?? '',
        isAdmin: json['isAdmin'].toString(),
        crmInfo: CeremonyModel.fromJson(json['crmInfo']),
        viewerInfo: User.fromJson(json['viewerInfo']));
  }
}
