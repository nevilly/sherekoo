import 'dart:convert';

import 'package:http/http.dart' as http;

class ReplyCall {
  final String id;
  final String postId;
  final String chatId;
  final String userId;
  final String body; //ceremony Type

  final dynamic status;
  dynamic payload;

  ReplyCall(
      {required this.id,
      required this.postId,
      required this.chatId,
      required this.userId,
      required this.body,
      required this.status,
      required this.payload});

  factory ReplyCall.fromJson(Map<String, dynamic> json) {
    return ReplyCall(
      status: json['status'],
      payload: json['payload'],
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      body: json['body'] ?? "",
      chatId: json['chatId'] ?? "",
      id: json['id'] ?? "",
    );
  }

  Future<ReplyCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ReplyCall> deleteChat(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'id': postId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ReplyCall> editReply(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': postId, 'body': body};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ReplyCall> updateLike(
      String token, String dirUrl, String isLike) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
        'isLike': isLike,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ReplyCall> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
        'chatId': chatId,
        'body': body,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }
}

///
/// External Function
///
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return ReplyCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<ReplyCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    if (r.statusCode == 200) {
      // print(r.body);
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<ReplyCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

ReplyCall rBody(http.Response r) {
  return ReplyCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
