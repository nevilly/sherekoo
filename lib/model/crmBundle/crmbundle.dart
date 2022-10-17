import 'dart:convert';

import 'package:http/http.dart' as http;

class CrmBundle {
  dynamic status;
  dynamic payload;

  CrmBundle({required this.payload, required this.status});

  factory CrmBundle.fromJson(Map<String, dynamic> json) {
    return CrmBundle(payload: json['payload'], status: json['status']);
  }

  Future<CrmBundle> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmBundle.fromJson({
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
        print(r.body);
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmBundle> updateCard(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmBundle.fromJson({
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
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmBundle> removeCard(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmBundle.fromJson({
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
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmBundle.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmBundle> postCard(
      String token,
      String dirUrl,
      String cardType,
      String cardImage,
      String font,
      String middle,
      String back,
      String wdMsg,
      price,
      quantity) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmBundle.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'cardType': cardType,
        'cardImage': cardImage,
        'font': font,
        'middle': middle,
        'back': back,
        'price': price,
        'quantity': quantity,
        'msg': wdMsg,
      };
    }

    // print(toMap());

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return CrmBundle.fromJson(rJson);
      }
      return CrmBundle.fromJson({'status': false});
    });
  }

  Future<CrmBundle> orderPost(token, dirUrl, date, suggestedCardMsg,
      cardsQuantity, totalPrice, id, crmId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmBundle.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'dedlineDate': date,
        'suggestedCardMsg': suggestedCardMsg,
        'totalPrice': totalPrice,
        'cardsQuantity': cardsQuantity,
        'cardId': id,
        'crmId': crmId,
      };
    }

    // print(toMap());

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);
      print(rJson);
      if (r.statusCode == 200) {
        return CrmBundle.fromJson(rJson);
      }
      return CrmBundle.fromJson({'status': false});
    });
  }
}
