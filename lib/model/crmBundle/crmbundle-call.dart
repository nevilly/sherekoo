import 'dart:convert';

import 'package:http/http.dart' as http;

class CrmBundleCall {
  dynamic status;
  dynamic payload;

  CrmBundleCall({required this.payload, required this.status});

  factory CrmBundleCall.fromJson(Map<String, dynamic> json) {
    return CrmBundleCall(payload: json['payload'], status: json['status']);
  }

  Future<CrmBundleCall> postBundle(
      String token,
      String dirUrl,
      String price,
      String bundleType,
      String ownerName,
      String amountOfPeople,
      String aboutBundle,
      String crmPackageInfo,
      String location,
      String around,
      List cardId,
      List bsnId,
      String superVisorId,
      String bundleImage,
      List hallImageSample,
      List plan) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'price': price,
        'bundleType': bundleType,
        'ownerName': ownerName,
        'bImage': bundleImage,
        'crmPackageId': crmPackageInfo,
        'location': location,
        'around': around,
        'aboutBundle': aboutBundle,
        'aboutPackage': aboutBundle,
        'superVisorId': superVisorId,
        'bundleLevel': '0',
        'amountOfPeople': amountOfPeople,
        'bsnId': bsnId,
        'cardSampleId': cardId.toString(),
        // 'hallImageSample': hallImageSample,
        'plan': jsonEncode(plan),
      };
    }

    // print(bsnId);

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<CrmBundleCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }
  

  Future<CrmBundleCall> search(
      String token, String dirUrl, String inyear) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'inyear': inyear};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  
  Future<CrmBundleCall> updateCard(
      String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<CrmBundleCall> removeCard(
      String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<CrmBundleCall> postCard(
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

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<CrmBundleCall> orderPost(token, dirUrl, date, suggestedCardMsg,
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
    return CrmBundleCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<CrmBundleCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body);
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<CrmBundleCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

CrmBundleCall rBody(http.Response r) {
  // print(r.body);
  return CrmBundleCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
