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

  Future<FollowCall> updateCrmViewer(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<FollowCall> unfollow(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<FollowCall> getCeremonyById(
      String token, String dirUrl, String day) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'cId': day,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<FollowCall> fallowback(
      String token, String dirUrl, String type) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'ceremonyType': type,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<FollowCall> getExistCrmnViewr(
      String token, String dirUrl, String crmId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'crmId': crmId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
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
