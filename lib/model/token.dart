class TokenManager {
  String id;
  dynamic token;
  dynamic page;

  TokenManager({required this.id, required this.token, required this.page});

  factory TokenManager.fromJson(Map<String, dynamic> json) {
    return TokenManager(
        token: json['status'],
        page: json['payload'] ?? "",
        id: json['id'] ?? "");
  }

  set(ip)async {
    
  }
}
