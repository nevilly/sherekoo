import 'dart:convert';

import 'package:http/http.dart' as http;

class BudgetCall {
  final int status;
  dynamic payload;

  BudgetCall({required this.payload, required this.status});

  factory BudgetCall.fromJson(Map<String, dynamic> json) {
    return BudgetCall(payload: json['payload'], status: json['status']);
  }

  Future<BudgetCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<BudgetCall> add(String token, String dirUrl, String amount,
      String minContribution, String crmId, String edtStatus) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'amount': amount,
        'minContribution': minContribution,
        'crmId': crmId,
        'editStatus': edtStatus
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BudgetCall> myBusness(
      String token, String dirUrl, String bsnType) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'type': 'My_Busness', 'ceoId': bsnType};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BudgetCall> bsnByCreatorid(
      String token, String dirUrl, String userId) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BudgetCall> deleteBsn(String token, String dirUrl, String bId) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': bId};
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
    return BudgetCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<BudgetCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    print('Budget Details');
    print(r.body);
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<BudgetCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

BudgetCall rBody(http.Response r) {
  return BudgetCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
