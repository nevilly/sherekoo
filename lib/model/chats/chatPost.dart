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

    if (token.isEmpty) {
      return PostAllChats.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      // final rJson = jsonDecode(r.body);
      if (r.statusCode == 200) {
        return PostAllChats.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostAllChats.fromJson({'status': false});
    });
  }

  Future<PostAllChats> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return PostAllChats.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'postId': postId,
        'body': body,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    // print('toMap(9999');
    // print(toMap());

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      // final rJson = jsonDecode(r.body);
      if (r.statusCode == 200) {
        return PostAllChats.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return PostAllChats.fromJson({'status': false});
    });
  }
}
