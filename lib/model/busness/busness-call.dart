import 'dart:convert';

import 'package:http/http.dart' as http;

class BusnessCall {
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

  BusnessCall(
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

  factory BusnessCall.fromJson(Map<String, dynamic> json) {
    return BusnessCall(
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

  Future<BusnessCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);


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
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BusnessCall> update(
      String token, String dirUrl, String oldCoProfile) async {
    Uri url = Uri.parse(dirUrl);



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

      invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }
}


/// External Function
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return BusnessCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<BusnessCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print('categories Details');
    // print(r.body);
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<BusnessCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

BusnessCall rBody(http.Response r) {
  return BusnessCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
