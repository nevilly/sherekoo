class BusnessModel {
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String aboutCEO;
  final String companyName;
  final String ceoId;
  final String location;
  final String contact;

  final String hotStatus;
  final String aboutCompany;
  final String createdBy;

  final String username;
  final String avater;

  // subscription
  final String subcrlevel;

  BusnessModel({
    required this.location,
    required this.bId,
    required this.knownAs,
    required this.coProfile,
    required this.busnessType,
    required this.avater,
    required this.companyName,
    required this.ceoId,
    required this.price,
    required this.contact,
    required this.hotStatus,
    required this.aboutCEO,
    required this.aboutCompany,
    required this.createdBy,
    required this.username,
    required this.subcrlevel,
  });

  factory BusnessModel.fromJson(Map<String, dynamic> json) {
    return BusnessModel(
      bId: json['bId'] ?? "",
      busnessType: json['busnessType'] ?? "",
      companyName: json['companyName'] ?? "",
      aboutCEO: json['aboutCEO'] ?? "",
      coProfile: json['coProfile'] ?? "",
      knownAs: json['knownAs'] ?? "",
      price: json['price'] ?? "",
      avater: json['avater'] ?? "",
      ceoId: json['ceoId'] ?? "",
      username: json['username'] ?? "",
      subcrlevel: json['subcrlevel'] ?? "",
      aboutCompany: json['aboutCompany'] ?? "",
      hotStatus: json['hotStatus'] ?? "",
      contact: json['contact'],
      location: json['location'] ?? "",
      createdBy: json['createdBy'],
    );
  }
}
