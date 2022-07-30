class BusnessModel {
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String aboutCEO;
  final String companyName;
  final String location;
  final String avater;
  final String contact;

  final String hotStatus;
  final String aboutCompany;
  // final String createdBy;

  final String username;

  BusnessModel({
    required this.location,
    required this.bId,
    required this.knownAs,
    required this.coProfile,
    required this.busnessType,
    required this.avater,
    required this.companyName,
    required this.price,
    required this.contact,
    required this.hotStatus,
    required this.aboutCEO,
    required this.aboutCompany,
    // required this.createdBy,

    required this.username,
  });

  factory BusnessModel.fromJson(Map<String, dynamic> json) {
    return BusnessModel(
      bId: json['bId'],
      busnessType: json['busnessType'],
      companyName: json['companyName'],
      aboutCEO: json['aboutCEO'],
      coProfile: json['coProfile'],
      knownAs: json['knownAs'],
      price: json['price'],
      avater: json['avater'],

      username: json['username'],

      aboutCompany: json['aboutCompany'],
      hotStatus: json['hotStatus'],
      contact: json['contact'], location: json['location'],

      // createdBy: json['createdBy'],
    );
  }
}
