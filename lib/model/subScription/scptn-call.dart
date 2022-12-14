import 'dart:convert';

import 'package:http/http.dart' as http;

class SubscrptionCall {
  dynamic status;
  dynamic payload;

  SubscrptionCall({required this.payload, required this.status});

  factory SubscrptionCall.fromJson(Map<String, dynamic> json) {
    return SubscrptionCall(payload: json['payload'], status: json['status']);
  }

  Future<SubscrptionCall> add(
      String token,
      String dirUrl,
      String price,
      String bundleType,
      String amountOfPeople,
      String aboutBundle,
      String crmPackageInfo,
      String location,
      String around,
      List cardId,
      List bsnId,
      String superVisorId,
      String bundleImage,
      List hallImageSample,
      List plan) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'price': price,
        'bImage': bundleImage,
        'crmPackageId': crmPackageInfo,
        'location': location,
        'around': around,
        'aboutBundle': aboutBundle,
        'aboutPackage': aboutBundle,
        'superVisorId': superVisorId,
        'bundleLevel': '1',
        'amountOfPeople': amountOfPeople,
        // 'bsnId': jsonEncode(bsnId),
        'cardSampleId': cardId.toString(),
        'hallImageSample': hallImageSample,
        // 'plan': jsonEncode(plan),
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<SubscrptionCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<SubscrptionCall> update(String token, String dirUrl, id, level) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'id': id,
        'level': level,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<SubscrptionCall> remove(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
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
    return SubscrptionCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<SubscrptionCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body); // Error Debuger
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<SubscrptionCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

SubscrptionCall rBody(http.Response r) {
  // print(jsonDecode(r.body));
  return SubscrptionCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
