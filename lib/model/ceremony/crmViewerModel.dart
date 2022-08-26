class CrmViewersModel {
  final String id;
  final String username;
  final String avater;
  final String position;

  final String cid;
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

  final String u2;
  final String u2Avt;
  final String u2Fname;
  final String u2Lname;
  final String u2g;

  final String youtubeLink;

  CrmViewersModel({
    required this.id,
    required this.avater,
    required this.username,
    required this.position,
    required this.codeNo,
    required this.cid,
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
  });

  factory CrmViewersModel.fromJson(Map<String, dynamic> json) {
    return CrmViewersModel(
        id: json['id'] ?? '',
        username: json['username'] ?? '',
        avater: json['avater'] ?? '',
        position: json['position'] ?? '',
        cid: json['cid'] ?? '',
        codeNo: json['codeNo'] ?? '',
        ceremonyType: json['ceremonyType'] ?? '',
        fId: json['crmFid'] ?? '',
        sId: json['sId'] ?? '',
        cImage: json['cImage'] ?? '',
        cName: json['cName'] ?? '',
        ceremonyDate: json['ceremonyDate'] ?? '',
        contact: json['contact'] ?? '',
        admin: json['admin'] ?? '',
        crmUsername: json['crmUsername'] ?? '',
        u1Avt: json['u1Avt'] ?? '',
        u1Fname: json['u1Fname'] ?? '',
        u1g: json['u1g'] ?? '',
        u2: json['u2'] ?? '',
        u2Avt: json['u2Avt'] ?? '',
        u2Fname: json['u2Fname'] ?? '',
        u2g: json['u2g'] ?? '',
        u1Lname: json['u1Lname'] ?? '',
        youtubeLink: json['crmYoutubeLink'] ?? '',
        u2Lname: json['u2Lname'] ?? '');
  }
}
