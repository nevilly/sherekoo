class CrmPckModel {
  String id;
  String title;
  String descr;
  String status;
  List colorCode;
  String createdDate;

  CrmPckModel(
      {required this.id,
      required this.title,
      required this.descr,
      required this.status,
      required this.colorCode,
      required this.createdDate});

  factory CrmPckModel.fromJson(Map<String, dynamic> json) {
    return CrmPckModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        descr: json['descr'] ?? "",
        status: json['status'] ?? "",
        colorCode: json['colorCode'],
        createdDate: json['createdDate'] ?? "");
  }
}
