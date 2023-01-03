import 'dart:convert';
import 'package:http/http.dart' as http;

class MchangoCall {
  dynamic status;
  dynamic payload;

  MchangoCall({required this.payload, required this.status});

  factory MchangoCall.fromJson(Map<String, dynamic> json) {
    return MchangoCall(payload: json['payload'], status: json['status']);
  }

  Future<MchangoCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<MchangoCall> update(String token, String dirUrl, id, ahadi) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'ahadi': ahadi};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

   Future<MchangoCall> payment(String token, String dirUrl, mchangoId, amount,crmId,contact) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'mchangoId': mchangoId, 'amount': amount,'crmId':crmId,'contact':contact};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> remove(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }
}

/// External Function
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return MchangoCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<MchangoCall> myPostHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body);
    if (r.statusCode == 200) {
      return MchangoCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
    return MchangoCall.fromJson(
        {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
  });
}

Future<MchangoCall> myGetHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    // print(r.body);
    if (r.statusCode == 200) {
      return MchangoCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    } else {
      return MchangoCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
  });
}
