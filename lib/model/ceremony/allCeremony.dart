import 'dart:convert';
import 'package:http/http.dart' as http;

class AllCeremonysModel {
  dynamic status;
  dynamic payload;

  AllCeremonysModel({required this.payload, required this.status});

  factory AllCeremonysModel.fromJson(Map<String, dynamic> json) {
    return AllCeremonysModel(payload: json['payload'], status: json['status']);
  }

  Future<AllCeremonysModel> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<AllCeremonysModel> updateCrmViewer(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<AllCeremonysModel> removeCrmViewer(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<AllCeremonysModel> getDayCeremony(
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

  Future<AllCeremonysModel> getCeremonyById(
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

  Future<AllCeremonysModel> getCeremonyByUserId(
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

  Future<AllCeremonysModel> getCeremonyByType(
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

  Future<AllCeremonysModel> getCrmViewr(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myGetHttp(url, headers);
  }

  Future<AllCeremonysModel> getExistCrmnViewr(
      String token, String dirUrl, String crmId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'crmId': crmId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return myPostHttp(url, toMap, headers);
  }

  Future<AllCeremonysModel> addCrmnViewr(
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
    return AllCeremonysModel.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<AllCeremonysModel> myPostHttp(Uri url,
    Map<String, dynamic> Function() toMap, Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body);
    if (r.statusCode == 200) {
      return AllCeremonysModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
    return AllCeremonysModel.fromJson(
        {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
  });
}

Future<AllCeremonysModel> myGetHttp(
    Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return AllCeremonysModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    } else {
      return AllCeremonysModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    }
  });
}
