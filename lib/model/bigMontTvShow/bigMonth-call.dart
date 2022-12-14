import 'dart:convert';

import 'package:http/http.dart' as http;

class BigMonthShowCall {
  dynamic status;
  dynamic payload;

  BigMonthShowCall({required this.payload, required this.status});

  factory BigMonthShowCall.fromJson(Map<String, dynamic> json) {
    return BigMonthShowCall(payload: json['payload'], status: json['status']);
  }

  Future<BigMonthShowCall> postBigMonthRegistration(String token, String dirUrl,
      String tvShowId, String dateBirth, String contact,String registerAs) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'tvShowId': tvShowId,
        'dateBirth': dateBirth,
        'contact': contact,
        'registerAs':registerAs
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<BigMonthShowCall> isActive(
      String token, String dirUrl, id, isActive) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'packageId': id, 'isActive': isActive};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> isRegistered(
      String token, String dirUrl, id, isSelected) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'packageIxd': id, 'isSelected': isSelected};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> getRegisteredMember(
      String token, String dirUrl, id, isSelected) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'tvShowId': id, 'isSelected': isSelected};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> editShow(
      String token,
      String dirUrl,
      String id,
      String title,
      String season,
      String episode,
      String description,
      String tvshowDate,
      String dedline,
      List washengaId,
      String washengaIdEdited,
      String showImage,
      String isUpdeted) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'id': id,
        'title': title,
        'season': season,
        'episode': episode,
        'description': description,
        'showDate': tvshowDate,
        'dedline': dedline,
        'washengaId': washengaId.toString(),
        'washengaIdEdited': washengaIdEdited,
        'showImage': showImage,
        'isUpdeted': isUpdeted
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> removeShow(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> updateCard(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> removeCard(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> post(
    String token,
    String dirUrl,
    String title,
    String season,
    String episode,
    String description,
    String tvshowDate,
    String dedline,
    List judgesId,
    List superStarId,
    String showImage,
  ) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'title': title,
        'season': season,
        'episode': episode,
        'description': description,
        'showDate': tvshowDate,
        'dedline': dedline,
        'judgesId': judgesId.toString(),
        'superStarsId': superStarId.toString(),
        'showImage': showImage,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BigMonthShowCall> orderPost(token, dirUrl, date, suggestedCardMsg,
      cardsQuantity, totalPrice, id, crmId) async {
    Uri url = Uri.parse(dirUrl);
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

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }
}

/// External Function
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return BigMonthShowCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<BigMonthShowCall> postHttp(Uri url,
    Map<String, dynamic> Function() toMap, Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print('Error View PosHttp Level');
    // print(jsonDecode(r.body)['payload']);
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<BigMonthShowCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      // print(jsonDecode(r.body)['payload']);
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

BigMonthShowCall rBody(http.Response r) {
  return BigMonthShowCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
