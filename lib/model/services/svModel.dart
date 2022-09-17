class SvModel {
  final String svId;
  final String busnessId;
  final String ceremonyId;
  final String confirm;
  final String createdBy;
  final String createdDate;
  final String payed;
  final String amount;

// Ceremony Model
  final String cId;
  final String codeNo;
  final String cImage;
  final String cName;
  final String ceremonyType;
  final String fId;
  final String fIdAvater;
  final String fIdUname;
  final String sId;
  final String sIdAvater;
  final String sIdUname;
  final String crmContact;

// Busness Data
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String bsncontact;
  final String bsncreatedBy;
  final String bsnUsername;
  // final String bsnAvater;
  // final String bsnUname;

  //subscription Model
  final String subId;
  final String level;
  final String categoryId;
  final String activeted;
  final String startTime;
  final String endTime;

  SvModel({
    required this.busnessId,
    required this.createdDate,
    required this.svId,
    required this.payed,
    required this.amount,
    required this.confirm,
    required this.ceremonyId,
    required this.createdBy,

    //Ceremon Model
    required this.cId,
    required this.cName,
    required this.cImage,
    required this.codeNo,
    required this.ceremonyType,
    required this.crmContact,
    required this.fId,
    required this.sId,
    required this.fIdAvater,
    required this.fIdUname,
    required this.sIdAvater,
    required this.sIdUname,
    required this.level,
    required this.activeted,
    required this.bId,
    required this.busnessType,
    required this.knownAs,
    required this.coProfile,
    required this.price,
    required this.bsncontact,
    required this.bsncreatedBy,
    required this.bsnUsername,

    //SubScription Model
    required this.subId,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
  });

  factory SvModel.fromJson(Map<String, dynamic> json) {
    return SvModel(
      svId: json['svId'] ?? "",
      confirm: json['confirm'] ?? "",
      payed: json['payed'] ?? "",
      amount: json['amount'] ?? "",
      
      //Ceremony Model
      cId: json['cId'] ?? "",
      cName: json['cName'] ?? "",
      codeNo: json['codeNo'] ?? "",
      ceremonyType: json['ceremonyType'] ?? "",
      fId: json['fId'] ?? "",
      sId: json['sId'] ?? "",
      fIdAvater: json['fIdAvater'] ?? "",
      fIdUname: json['fIdUname'] ?? "",
      sIdAvater: json['sIdAvater'] ?? "",
      sIdUname: json['sIdUname'] ?? "",
      cImage: json['cImage'] ?? "",
      crmContact: json['crmContact'] ?? "",

      // Busness Data
      bId: json['bId'] ?? "",
      busnessId: json['busnessId'] ?? "",
      createdDate: json['createdDate'] ?? "",
      price: json['price'] ?? "",
      knownAs: json['knownAs'] ?? "",
      createdBy: json['createdBy'] ?? "",
      coProfile: json['coProfile'] ?? "",
      bsncontact: json['bsncontact'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      // bsnAvater: json['bsnAvater'],
      // bsnUname: json['bsnUname'],

      busnessType: json['busnessType'] ?? "",
      bsncreatedBy: json['bsncreatedBy'] ?? "",
      bsnUsername: json['bsnUsername'] ?? "",
      // bId: json['bId'],

      //SubScription Model
      subId: json['subId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      activeted: json['activeted'] ?? "",
      level: json['level'] ?? "",
    );
  }
}
