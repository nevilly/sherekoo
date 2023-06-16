import 'dart:convert';

import 'package:http/http.dart' as http;

class CrmPackage {
  dynamic status;
  dynamic payload;

  CrmPackage({required this.payload, required this.status});

  factory CrmPackage.fromJson(Map<String, dynamic> json) {
    return CrmPackage(payload: json['payload'], status: json['status']);
  }

  Future<CrmPackage> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPackage.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((r) {
      if (r.statusCode == 200) {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmPackage> updateBundle(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPackage.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((http.Response r) {
      if (r.statusCode == 200) {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmPackage> removeCard(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPackage.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((http.Response r) {
      // print(r.body);
      if (r.statusCode == 200) {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmPackage> post(String token, String dirUrl, title, descr, colorCode,
      image, inYear, String ClrDesgner) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPackage.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'title': title,
        'descr': descr,
        'colorCode': jsonEncode(colorCode),
        'year': inYear,
        'image': image,
        'colorDesigner': ClrDesgner
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
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return CrmPackage.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<CrmPackage> activate(String token, String dirUrl, id, stats) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPackage.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'packageId': id,
        'isActive': stats,
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
        return CrmPackage.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return CrmPackage.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
