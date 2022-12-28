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

  Future<MchangoCall> updateCrmViewer(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> removeCrmViewer(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> getDayCeremony(
      String token, String dirUrl, String day, offset, limit) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'day': day, 'offset': offset, 'limit': limit};
    }

    print(toMap());

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> getCeremonyById(
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

  Future<MchangoCall> getCeremonyByUserId(
      String token, String dirUrl, String userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'userId': userId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> getCeremonyByType(
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

  Future<MchangoCall> getCrmViewr(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<MchangoCall> getCrmnVwrByUid(
      String token, String dirUrl, String uid, limit, offset) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'crmId': uid, 'offset': offset, 'limit': limit};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> getExistCrmnViewr(
      String token, String dirUrl, String crmId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'crmId': crmId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<MchangoCall> addCrmnViewr(
      String token, String dirUrl, String crmId, String position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'crmId': crmId, 'position': position};
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

Future<MchangoCall> myPostHttp(Uri url,
    Map<String, dynamic> Function() toMap, Map<String, String> headers) async {
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

Future<MchangoCall> myGetHttp(
    Uri url, Map<String, String> headers) async {
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
