class CrmViewersModel {
  final String id;
  final String username;
  final String avater;
  final String position;

  final String cId;
  final String codeNo;
  final String ceremonyType;
  final String fId;
  final String sId;
  final String cImage;
  final String ceremonyDate;
  final String contact;
  final String admin;
  final String cName;

  final String crmUsername; //    username for fid
  final String u1Avt; //  avater for fid
  final String u1Fname; //  firstName fid
  final String u1Lname; //  lastName fid
  final String u1g; // gender fid

  //User info
  final String u2;
  final String u2Avt;
  final String u2Fname;
  final String u2Lname;
  final String u2g;
  
  // Admin info
  final String crmAdminAvater;
  final String crmAdminUsername;
  final String crmAdminFname;
  final String crmAdminLname;
  final String crmAdminGender;

  final String youtubeLink;

 

  CrmViewersModel({
    required this.id,
    required this.avater,
    required this.username,
    required this.position,
    required this.codeNo,
    required this.cId,
    required this.ceremonyType,
    required this.fId,
    required this.sId,
    required this.cImage,
    required this.ceremonyDate,
    required this.contact,
    required this.admin,
    required this.crmUsername,
    required this.cName,
    required this.u1Avt,
    required this.u1Fname,
    required this.u1Lname,
    required this.u1g,
    required this.u2,
    required this.u2Avt,
    required this.u2Fname,
    required this.u2Lname,
    required this.u2g,
    required this.youtubeLink,
    required this.crmAdminAvater,
    required this.crmAdminUsername,
    required this.crmAdminFname,
    required this.crmAdminLname,
    required this.crmAdminGender,
  });

  factory CrmViewersModel.fromJson(Map<String, dynamic> json) {
    return CrmViewersModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      avater: json['avater'] ?? '',
      position: json['position'] ?? '',

      cId: json['cId'] ?? '',
      codeNo: json['codeNo'] ?? '',
      ceremonyType: json['ceremonyType'] ?? '',
      fId: json['fId'] ?? '',
      sId: json['sId'] ?? '',
      cImage: json['cImage'] ?? '',
      cName: json['cName'] ?? '',
      ceremonyDate: json['ceremonyDate'] ?? '',
      contact: json['contact'] ?? '',
      admin: json['admin'] ?? '',

      //User info First userId (fId)
      u1Avt: json['fIdAvater'] ?? '',
      crmUsername: json['fIdUsername'] ?? '',
      u1Fname: json['fIdFname'] ?? '',
      u1Lname: json['fIdLname'] ?? '',
      u1g: json['fIdGender'] ?? '',

      //User info Second userId (sId)
      u2: json['sIdUname'] ?? '',
      u2Avt: json['sIdAvater'] ?? '',
      u2Fname: json['sIdFname'] ?? '',
      u2Lname: json['sIdLname'] ?? '',
      u2g: json['sIdGender'] ?? '',

      //Admin infos
      crmAdminAvater: json['crmAdminAvater'] ?? '',
      crmAdminUsername: json['crmAdminUsername'] ?? '',
      crmAdminFname: json['crmAdminFname'] ?? '',
      crmAdminLname: json['crmAdminLname'] ?? '',
      crmAdminGender: json['crmAdminGender'] ?? '',

      youtubeLink: json['crmYoutubeLink'] ?? '',
    );
  }
}
