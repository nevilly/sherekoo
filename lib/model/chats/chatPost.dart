import 'dart:convert';

import 'package:http/http.dart' as http;

class PostAllChats {
  final String postId;
  final String userId;
  final String body; //ceremony Type

  final dynamic status;
  dynamic payload;

  PostAllChats(
      {required this.postId,
      required this.userId,
      required this.body,
      required this.status,
      required this.payload});

  factory PostAllChats.fromJson(Map<String, dynamic> json) {
    return PostAllChats(
      status: json['status'],
      payload: json['payload'],
      postId: json['postId'] ?? "",
      userId: json['userId'] ?? "",
      body: json['body'] ?? "",
    );
  }

  Future<PostAllChats> get(String token, String dirUrl) async {
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

  Future<PostAllChats> deleteChat(String token, String dirUrl) async {
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

  Future<PostAllChats> editChat(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'id': postId,
        'body':body
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<PostAllChats> updateLike(
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

  Future<PostAllChats> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
        'body': body,
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
    return PostAllChats.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<PostAllChats> postHttp(Uri url, Map<String, dynamic> Function() toMap,
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

Future<PostAllChats> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

PostAllChats rBody(http.Response r) {
  return PostAllChats.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
