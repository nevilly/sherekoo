class SubscriptionModel {
  String subId,
      subscriptionType,
      categoryId,
      level,
      activeted,
      duration,
      startTime,
      endTime,
      receiptNo,
      createdDate;

  SubscriptionModel(
      {required this.subId,
      required this.level,
      required this.subscriptionType,
      required this.categoryId,
      required this.activeted,
      required this.duration,
      required this.startTime,
      required this.endTime,
      required this.receiptNo,
      required this.createdDate});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
        // Service Info
        subId: json['subId'] ?? "",
        level: json['level'] ?? "",
        subscriptionType: json['subscriptionType'] ?? "",
        categoryId: json['categoryId'] ?? "",
        activeted: json['activeted'] ?? "",
        duration: json['duration'] ?? "",
        startTime: json['startTime'] ?? "",
        createdDate: json['createdDate'] ?? "",
        endTime: json['endTime'] ?? "",
        receiptNo: json['receiptNo'] ?? "");
  }
}
