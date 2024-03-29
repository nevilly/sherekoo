class CrmPckModel {
  String id;
  String title;
  String descr;
  String pImage;
  String inYear;
  String status;
  List colorCode;
  String colorDesigner;
  String createdDate;

  CrmPckModel(
      {required this.id,
      required this.title,
      required this.descr,
      required this.pImage,
      required this.inYear,
      required this.status,
      required this.colorCode,
      required this.colorDesigner,
      required this.createdDate});

  factory CrmPckModel.fromJson(Map<String, dynamic> json) {
    return CrmPckModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        descr: json['descr'] ?? "",
        status: json['status'] ?? "",
        pImage: json['pImage'] ?? "",
        inYear: json['inYear'] ?? "",
        colorCode: json['colorCode'],
        colorDesigner: json['colorDesigner'] ?? "",
        createdDate: json['createdDate'] ?? "");
  }
}
