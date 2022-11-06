import 'dart:convert';

import 'package:http/http.dart' as http;

class MshengaWarCall {
  dynamic status;
  dynamic payload;

  MshengaWarCall({required this.payload, required this.status});

  factory MshengaWarCall.fromJson(Map<String, dynamic> json) {
    return MshengaWarCall(payload: json['payload'], status: json['status']);
  }

  Future<MshengaWarCall> postBigMonthRegistration(String token, String dirUrl,
      String tvShowId, String dateBirth, String contact) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'tvShowId': tvShowId,
        'dateBirth': dateBirth,
        'contact': contact
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<MshengaWarCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<MshengaWarCall> isActive(
      String token, String dirUrl, id, isActive) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'packageId': id, 'isActive': isActive};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<MshengaWarCall> removeShow(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<MshengaWarCall> post(
    String token,
    String dirUrl,
    String title,
    String season,
    String episode,
    String description,
    String tvshowDate,
    String dedline,
    List washengaId,
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
        'washengaId': washengaId.toString(),
        'showImage': showImage,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<MshengaWarCall> editShow(
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

  Future<MshengaWarCall> orderPost(token, dirUrl, date, suggestedCardMsg,
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
    return MshengaWarCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<MshengaWarCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
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

Future<MshengaWarCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      // print(jsonDecode(r.body)['payload']);
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

MshengaWarCall rBody(http.Response r) {
  print(jsonDecode(r.body)['payload']);
  return MshengaWarCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
