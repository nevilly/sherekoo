import 'dart:convert';

import 'package:http/http.dart' as http;

class PostBusness {
  final String bId;
  final String busnessType;
  final String knownAs;
  final String coProfile;
  final String price;
  final String contact;
  final String location;
  final String companyName;
  final String ceoId;
  final String aboutCEO;
  final String aboutCompany;
  final String createdBy;
  final String hotStatus;
  final String subscrlevel; //subscription level

  dynamic status;
  dynamic payload;

  PostBusness(
      {required this.bId,
      required this.busnessType,
      required this.knownAs,
      required this.coProfile,
      required this.price,
      required this.contact,
      required this.location,
      required this.companyName,
      required this.ceoId,
      required this.aboutCEO,
      required this.aboutCompany,
      required this.createdBy,
      required this.hotStatus,
      required this.subscrlevel,
      required this.status,
      required this.payload});

  factory PostBusness.fromJson(Map<String, dynamic> json) {
    return PostBusness(
      status: json['status'],
      payload: json['payload'],
      bId: json['bId'] ?? "",
      busnessType: json['busnessType'] ?? "",
      knownAs: json['knownAs'] ?? "",
      coProfile: json['coProfile'] ?? "",
      price: json['price'] ?? "",
      contact: json['contact'] ?? "",
      location: json['location'] ?? "",
      companyName: json['companyName'] ?? "",
      ceoId: json['ceoId'] ?? "",
      aboutCEO: json['aboutCEO'] ?? "",
      aboutCompany: json['aboutCompany'] ?? "",
      subscrlevel: json['subscrlevel'] ?? "",
      createdBy: json['createdBy'] ?? "",
      hotStatus: json['hotStatus'] ?? "",
    );
  }

  Future<PostBusness> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return PostBusness.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'busnessType': busnessType,
        'knownAs': knownAs,
        'coProfile': coProfile,
        'price': price,
        'contact': contact,
        'location': location,
        'companyName': companyName,
        'ceoId': ceoId,
        'aboutCEO': aboutCEO,
        'aboutCompany': aboutCompany,
        'createdBy': createdBy,
        'hotStatus': hotStatus,
        'subscrlevel': subscrlevel,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return PostBusness.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostBusness.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<PostBusness> update(
      String token, String dirUrl, String oldCoProfile) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return PostBusness.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'bId': bId,
        'busnessType': busnessType,
        'knownAs': knownAs,
        'coProfile': coProfile,
        'price': price,
        'contact': contact,
        'location': location,
        'companyName': companyName,
        'ceoId': ceoId,
        'aboutCEO': aboutCEO,
        'aboutCompany': aboutCompany,
        'createdBy': createdBy,
        'hotStatus': hotStatus,
        'subscrlevel': subscrlevel,
        'oldCoProfile': oldCoProfile,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return PostBusness.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostBusness.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
