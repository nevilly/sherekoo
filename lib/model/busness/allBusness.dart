import 'dart:convert';

import 'package:http/http.dart' as http;

class AllBusnessModel {
  final int status;
  dynamic payload;

  AllBusnessModel({required this.payload, required this.status});

  factory AllBusnessModel.fromJson(Map<String, dynamic> json) {
    return AllBusnessModel(payload: json['payload'], status: json['status']);
  }

  Future<AllBusnessModel> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllBusnessModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((http.Response r) {
      if (r.statusCode == 200) {
        return AllBusnessModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return AllBusnessModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<AllBusnessModel> onBusnessType(
      String token, String dirUrl, String bsnType) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllBusnessModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'type': bsnType};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return AllBusnessModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return AllBusnessModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<AllBusnessModel> myBusness(
      String token, String dirUrl, String bsnType) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllBusnessModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'type': 'My_Busness', 'ceoId': bsnType};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return AllBusnessModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return AllBusnessModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<AllBusnessModel> bsnByCreatorid(
      String token, String dirUrl, String userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllBusnessModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': userId};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return AllBusnessModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return AllBusnessModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
