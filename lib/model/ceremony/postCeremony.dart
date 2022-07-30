import 'dart:convert';

import 'package:http/http.dart' as http;

class PostAllCeremony {
  final String cId;
  final String userId;
  final String sId;
  final String name;
  final String date;
  final String image;
  final String cType; //ceremony Type
  final String codeNo;
  final String goLiveId;
  final int status;
  dynamic payload;

  PostAllCeremony(
      {required this.cId,
      required this.userId,
      required this.sId,
      required this.name,
      required this.date,
      required this.image,
      required this.cType,
      required this.codeNo,
      required this.goLiveId,
      required this.status,
      required this.payload});

  factory PostAllCeremony.fromJson(Map<String, dynamic> json) {
    return PostAllCeremony(
      status: json['status'],
      payload: json['payload'],
      cId: json['cId'] ?? "",
      sId: json['sId'] ?? "",
      userId: json['userId'] ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      cType: json['cType'] ?? "",
      goLiveId: json['goLiveId'] ?? "",
      date: json['date'] ?? "",
      codeNo: json['codeNo'] ?? "",
    );
  }

  Future<PostAllCeremony> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return PostAllCeremony.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'userId': userId,
        'sId': sId,
        'name': name,
        'date': date,
        'codeNo': codeNo,
        'cType': cType,
        'goLiveId': goLiveId,
        'image': image
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return PostAllCeremony.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostAllCeremony.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<PostAllCeremony> update(
      String token, String dirUrl, String crmCover) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return PostAllCeremony.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'cId': cId,
        'userId': userId,
        'sId': sId,
        'name': name,
        'date': date,
        'codeNo': codeNo,
        'cType': cType,
        'goLiveId': goLiveId,
        'oldCrmCover': crmCover,
        'newCrmCover': image,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return PostAllCeremony.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostAllCeremony.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
