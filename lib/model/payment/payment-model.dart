class PaymentModel {
  final String id;
  final String hostId;
  final String crmId;

  PaymentModel({required this.id, required this.crmId, required this.hostId, requi});
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      crmId: '',
      hostId: '',
      id: '',
    );
  }
}
