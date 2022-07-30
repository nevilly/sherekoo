class SvModel {
  final String hostId;
  final String busnessId;
  final String ceremonyId;
  final String confirm;
  final String createdBy;
  final String createdDate;

// Ceremony Data
  // final String cId;
  // final String codeNo;
  // final String cName;
  // final String ceremonyType;
  // final String fIdAvater;
  // final String fIdUname;
  // final String sIdAvater;
  // final String sIdUname;
  // final String crmContact;

// Busness Data
  // final String bId;
  final String busnessType;
  // final String cImage;
  final String knownAs;
  final String coProfile;
  final String price;
  final String bsncontact;
  final String bsncreatedBy;
  final String bsnUsername;
  // final String ceoId;
  // final String bsnAvater;
  // final String bsnUname;

  //subscription info
  final String level;
  final String activeted;

  SvModel(
      {required this.busnessId,
      // required this.cName,
      // required this.cImage,
      required this.createdDate,
      required this.hostId,
      required this.confirm,
      // required this.cId,
      // required this.codeNo,
      // required this.ceremonyType,
      required this.ceremonyId,
      required this.createdBy,
      // required this.crmContact,
      // required this.bId,
      required this.busnessType,
      required this.knownAs,
      required this.coProfile,
      required this.price,
      required this.bsncontact,
      required this.bsncreatedBy,
      required this.bsnUsername,
      // required this.ceoId,
      // required this.fIdAvater,
      // required this.fIdUname,
      // required this.sIdAvater,
      // required this.sIdUname,
      // required this.bsnAvater,
      // required this.bsnUname,
      required this.level,
      required this.activeted});

  factory SvModel.fromJson(Map<String, dynamic> json) {
    return SvModel(
        hostId: json['hostId'] ?? "",
        confirm: json['confirm'] ?? "",
        // cName: json['cName'],
        // cId: json['cId'],
        // codeNo: json['codeNo'],
        // ceremonyType: json['ceremonyType'],
        // fIdAvater: json['fIdAvater'],
        // fIdUname: json['fIdUname'],
        // sIdAvater: json['sIdAvater'],
        // sIdUname: json['sIdUname'],
        // cImage: json['cImage'],
        // crmContact: json['crmContact'],

        // Busness Data
        busnessId: json['busnessId'] ?? "",
        createdDate: json['createdDate'] ?? "",
        // bsnAvater: json['bsnAvater'],
        // bsnUname: json['bsnUname'],
        price: json['price'] ?? "",
        knownAs: json['knownAs'] ?? "",
        createdBy: json['createdBy'] ?? "",
        coProfile: json['coProfile'] ?? "",
        bsncontact: json['bsncontact'] ?? "",
        ceremonyId: json['avater'] ?? "",
        // ceoId: json['ceoId'],
        busnessType: json['busnessType'] ?? "",
        bsncreatedBy: json['bsncreatedBy'] ?? "",
        bsnUsername: json['bsnUsername'] ?? "",
        // bId: json['bId'],

        //Activated Info
        activeted: json['activeted'] ?? "",
        level: json['level'] ?? "");
  }
}
