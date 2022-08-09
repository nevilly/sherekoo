class CeremonyModel {
  final String cId;
  final String codeNo;
  final String cName;
  final String ceremonyType;
  final String fId;
  final String sId;
  final String cImage;
  final String ceremonyDate;
  final String contact;
  final String admin;

  final String u1; //    username for fid
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

  CeremonyModel({
    required this.cId,
    required this.codeNo,
    required this.ceremonyType,
    required this.cName,
    required this.fId,
    required this.sId,
    required this.cImage,
    required this.ceremonyDate,
    required this.contact,
    required this.admin,
    required this.u1,
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

  factory CeremonyModel.fromJson(Map<String, dynamic> json) {
    return CeremonyModel(
        cId: json['cId'],
        codeNo: json['codeNo'],
        cName: json['cName'],
        ceremonyType: json['ceremonyType'],
        fId: json['fId'],
        sId: json['sId'],
        cImage: json['cImage'],
        ceremonyDate: json['ceremonyDate'],
        contact: json['contact'],
        admin: json['admin'],
        u1: json['u1'],
        u1Avt: json['u1Avt'],
        u1Fname: json['u1Fname'],
        u1g: json['u1g'],
        u2: json['u2'],
        u2Avt: json['u2Avt'],
        u2Fname: json['u2Fname'],
        u2g: json['u2g'],
        u1Lname: json['u1Lname'],
        youtubeLink: json['youtubeLink'],
        u2Lname: json['u2Lname']);
  }
}
