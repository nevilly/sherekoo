

class MchangoModel {
  final String id;
  final String crmId;
  final String viewerId;

  final String ahadi;

  MchangoModel(
      {required this.id,
      required this.crmId,
      required this.viewerId,
      required this.ahadi
      });

  factory MchangoModel.fromJson(Map<String, dynamic> json) {
    return MchangoModel(
        id: json['id'] ?? '',
        crmId: json['userId'] ?? '',
        viewerId: json['viewerId'] ?? '',
        ahadi: json['ahadi'].toString(),
    
      );
  }
}
