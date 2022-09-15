class RequestsModel {
  final String hostId;
  final String busnessId;
  final String ceremonyId;
  final String confirm;
  final String createdBy;
  final String createdDate;

// Ceremony Data
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
  final String ceoId;
  // final String bsnAvater;
  // final String bsnUname;

  // Service Info
  final String isInService;
  final String svId;
  final String svPayStatus;
  final String svAmount;

  //subscription Model
  final String subId;
  final String level;
  final String categoryId;
  final String activeted;
  final String startTime;
  final String endTime;

  RequestsModel({
    //Request Model
    required this.hostId,
    required this.busnessId,
    required this.ceremonyId,
    required this.createdDate,
    required this.confirm,
    required this.createdBy,

    //Busness Model
    required this.bId,
    required this.busnessType,
    required this.knownAs,
    required this.coProfile,
    required this.price,
    required this.bsncontact,
    required this.bsncreatedBy,
    required this.bsnUsername,
    // required this.bsnAvater,
    // required this.bsnUname,

    //Ceremon Model
    required this.cId,
    required this.cName,
    required this.cImage,
    required this.codeNo,
    required this.ceremonyType,
    required this.crmContact,
    required this.ceoId,
    required this.fId,
    required this.sId,
    required this.fIdAvater,
    required this.fIdUname,
    required this.sIdAvater,
    required this.sIdUname,
    required this.level,
    required this.activeted,

    // Service Model
    required this.isInService,
    required this.svId,
    required this.svPayStatus,
    required this.svAmount,

    //SubScription Model
    required this.subId,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      hostId: json['hostId'] ?? "",
      confirm: json['confirm'] ?? "",

      //Ceremony Model
      cId: json['cId'] ?? "",
      cName: json['cName'] ?? "",
      codeNo: json['codeNo'] ?? "",
      ceremonyType: json['ceremonyType'] ?? "",
      ceoId: json['ceoId'] ?? "",
      fId: json['fId'] ?? "",
      sId: json['sId'] ?? "",
      fIdAvater: json['fIdAvater'] ?? "",
      fIdUname: json['fIdUname'] ?? "",
      sIdAvater: json['sIdAvater'] ?? "",
      sIdUname: json['sIdUname'] ?? "",
      cImage: json['cImage'] ?? "",
      crmContact: json['crmContact'] ?? "",

      // Busness Model
      bId: json['bId'] ?? "",
      busnessId: json['busnessId'] ?? "",
      createdDate: json['createdDate'] ?? "",
      price: json['price'] ?? "",
      knownAs: json['knownAs'] ?? "",
      createdBy: json['createdBy'] ?? "",
      coProfile: json['coProfile'] ?? "",
      bsncontact: json['bsncontact'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      busnessType: json['busnessType'] ?? "",
      bsncreatedBy: json['bsncreatedBy'] ?? "",
      bsnUsername: json['bsnUsername'] ?? "",
      // bsnAvater: json['bsnAvater'],
      // bsnUname: json['bsnUname'],

      //SubScription Model
      subId: json['subId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      activeted: json['activeted'] ?? "",
      level: json['level'] ?? "",

      // Services Info
      isInService: json['isInService'].toString(),
      svId: json['svId'] ?? "",
      svPayStatus: json['svPayStatus'] ?? "",
      svAmount: json['svAmount'] ?? "",
    );
  }
}
