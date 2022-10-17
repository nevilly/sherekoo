class Plan {
  String id;
  String crmBundleId;
  String title;
  List plan;
  Plan({
    required this.id,
    required this.title,
    required this.plan,
    required this.crmBundleId,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] ?? '',
      crmBundleId: json['crmBundleId'] ?? '',
      plan: json['plan'],
      title: json['title'] ?? '',
    );
  }
}
