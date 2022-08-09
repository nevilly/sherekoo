class ServicesModel {
  // Services (Hostlist)
  final String hostId;
  final String busnessId;
  final String ceremonyId;
  final String confirm;
  final String createdBy;
  final String createdDate;

  // Busness Info
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String bsnContact;
  final String ceoId;
  final String bsnAvater;
  final String bsnUname;

  // ceremony Details
  final String cId;
  final String codeNo;
  final String cImage;
  final String cName;
  final String ceremonyType;
  final String fIdAvater;
  final String fIdUname;
  final String sIdAvater;
  final String sIdUname;
  final String crmContact;

  //subscription info
  final String level;
  final String activeted;

  ServicesModel(
      {required this.busnessId,
      required this.cName,
      required this.cImage,
      required this.createdDate,
      required this.hostId,
      required this.confirm,
      required this.cId,
      required this.codeNo,
      required this.ceremonyType,
      required this.ceremonyId,
      required this.createdBy,
      required this.crmContact,
      required this.bId,
      required this.busnessType,
      required this.knownAs,
      required this.coProfile,
      required this.price,
      required this.bsnContact,
      required this.ceoId,
      required this.fIdAvater,
      required this.fIdUname,
      required this.sIdAvater,
      required this.sIdUname,
      required this.bsnAvater,
      required this.bsnUname,
      required this.level,
      required this.activeted});

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
        // Service Info
        hostId: json['hostId'] ?? "",
        busnessId: json['busnessId'] ?? "",
        ceremonyId: json['ceremonyId'] ?? "",
        confirm: json['confirm'] ?? "",

        //busness
        bId: json['bId'] ?? "",
        busnessType: json['busnessType'] ?? "",
        createdDate: json['createdDate'] ?? "",
        bsnAvater: json['bsnAvater'] ?? "",
        bsnUname: json['bsnUname'] ?? "",
        price: json['price'] ?? "",
        knownAs: json['knownAs'] ?? "",
        createdBy: json['createdBy'] ?? "",
        coProfile: json['coProfile'] ?? "",
        bsnContact: json['bsnContact'] ?? "",
        ceoId: json['ceoId'] ?? "",

        // ceremony
        cName: json['cName'] ?? "",
        cId: json['cId'] ?? "",
        codeNo: json['codeNo'] ?? "",
        ceremonyType: json['ceremonyType'] ?? "",
        fIdAvater: json['fIdAvater'] ?? "",
        fIdUname: json['fIdUname'] ?? "",
        sIdAvater: json['sIdAvater'] ?? "",
        sIdUname: json['sIdUname'] ?? "",
        cImage: json['cImage'] ?? "",
        crmContact: json['crmContact'] ?? "",

        //subscription info
        activeted: json['activeted'] ?? "",
        level: json['level'] ?? "");
  }
}
