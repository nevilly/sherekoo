class Payment {
  final String id;
  final String hostId;
  final String crmId;

  Payment({required this.id, required this.crmId, required this.hostId, requi});
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      crmId: '',
      hostId: '',
      id: '',
    );
  }
}
