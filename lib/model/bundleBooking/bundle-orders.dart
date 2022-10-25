import 'dart:convert';

import 'package:http/http.dart' as http;

class BundleOrders {
  dynamic status;
  dynamic payload;

  BundleOrders({required this.payload, required this.status});

  factory BundleOrders.fromJson(Map<String, dynamic> json) {
    return BundleOrders(payload: json['payload'], status: json['status']);
  }

  Future<BundleOrders> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<BundleOrders> postOrders(
      token, dirUrl, ceremonyDate, contact, crmBundleId, String crmId) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'ceremonyDate': ceremonyDate,
        'contact': contact,
        'crmBundleId': crmBundleId,
        'crmId': crmId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);

    return await myPostHttp(url, toMap, headers);
  }

  Future<BundleOrders> updateCrmBundleOrders(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    return myPostHttp(url, toMap, headers);
  }

  Future<BundleOrders> removeCard(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    return myPostHttp(url, toMap, headers);
  }
}


///// New Life
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return BundleOrders.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<BundleOrders> myPostHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    if (r.statusCode == 200) {
      return BundleOrders.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
    return BundleOrders.fromJson(
        {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
  });
}

Future<BundleOrders> myGetHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return BundleOrders.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    } else {
      return BundleOrders.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
  });
}
