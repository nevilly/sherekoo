import 'dart:convert';
import 'package:http/http.dart' as http;

class FollowCall {
  dynamic status;
  dynamic payload;

  FollowCall({required this.payload, required this.status});

  factory FollowCall.fromJson(Map<String, dynamic> json) {
    return FollowCall(payload: json['payload'], status: json['status']);
  }

  Future<FollowCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<FollowCall> follow(String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'followId': id};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<FollowCall> getfollow(
      String token, String dirUrl, String id, String typ) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'followId': id, 'followType': typ};
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
    return FollowCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<FollowCall> myPostHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body);
    if (r.statusCode == 200) {
      return FollowCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
    return FollowCall.fromJson(
        {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
  });
}

Future<FollowCall> myGetHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return FollowCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    } else {
      return FollowCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
  });
}
