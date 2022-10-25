import 'dart:convert';

import 'package:http/http.dart' as http;

class InvCards {
  dynamic status;
  dynamic payload;

  InvCards({required this.payload, required this.status});

  factory InvCards.fromJson(Map<String, dynamic> json) {
    return InvCards(payload: json['payload'], status: json['status']);
  }

  Future<InvCards> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return InvCards.fromJson({
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
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<InvCards> updateCard(String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return InvCards.fromJson({
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
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<InvCards> removeCard(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return InvCards.fromJson({
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
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return InvCards.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<InvCards> postCard(
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
      return InvCards.fromJson({
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
        return InvCards.fromJson(rJson);
      }
      return InvCards.fromJson({'status': false});
    });
  }

  Future<InvCards> orderPost(token, dirUrl, date, suggestedCardMsg,
      cardsQuantity, totalPrice, id, crmId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return InvCards.fromJson({
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
   
      if (r.statusCode == 200) {
        return InvCards.fromJson(rJson);
      }
      return InvCards.fromJson({'status': false});
    });
  }
}
