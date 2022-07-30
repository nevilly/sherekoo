class BusnessMembersModel {
  final String stId;
  final String bId;
  final String userId;
  final String createdDate;
  final String username;
  final String avater;
  final String position;
  final String confirm;

  BusnessMembersModel({
    required this.bId,
    required this.userId,
    required this.createdDate,
    required this.stId,
    required this.username,
    required this.avater,
    required this.position,
    required this.confirm,
  });

  factory BusnessMembersModel.fromJson(Map<String, dynamic> json) {
    return BusnessMembersModel(
        stId: json['stId'] ?? "",
        username: json['username'] ?? "",
        avater: json['avater'] ?? "",
        position: json['position'] ?? "",
        confirm: json['confirm'],
        bId: json['bId'] ?? "",
        createdDate: json['createdDate'] ?? "",
        userId: json['userId'] ?? "");
  }
}
