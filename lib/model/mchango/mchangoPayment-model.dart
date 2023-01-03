class MchangoPaymentModel {
  final String id;
  final String mchangoId;
  final String amount;
  String? contact;
  String? crmId;
  final String reciept;
  final String createdBy;
  final String status;
  final String createdDate;
  // String? total;
  MchangoPaymentModel(
      {required this.id,
      required this.mchangoId,
      required this.crmId,
      required this.contact,
      required this.amount,
      required this.createdBy,
      required this.createdDate,
      required this.status,
      // required this.total,
      required this.reciept});

  factory MchangoPaymentModel.fromJson(Map<String, dynamic> json) {
    return MchangoPaymentModel(
      id: json['id'] ?? '',
      mchangoId: json['mchangoId'] ?? '',
      amount: json['amount'] ?? '',
      createdBy: json['createdBy'] ?? '',
      crmId:json['crmId']?? "",
       contact:json['contact']?? "",
      createdDate: json['createdDate'] ?? '',
      status: json['status'] ?? '',
      // total: json['total'] ?? '',
      reciept: json['reciept'] ?? '',
    );
  }
}
