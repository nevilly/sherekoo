import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final String pId;
  final String createdBy;
  final String body;
  final String vedeo;
  final String ceremonyId;
  final String hashTag;

  final String username;
  final String avater;

  dynamic status;
  dynamic payload;

  Post(
      {required this.pId,
      required this.createdBy,
      required this.body,
      required this.vedeo,
      required this.ceremonyId,
      required this.hashTag,
      required this.username,
      required this.avater,
      required this.status,
      required this.payload});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      status: json['status'],
      payload: json['payload'],
      pId: json['pId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      vedeo: json['vedeo'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      hashTag: json['hashTag'] ?? "",
      body: json['body'] ?? "",
      username: json['username'] ?? "",
      avater: json['avater'] ?? "",
    );
  }

  Future<Post> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<Post> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'createdBy': createdBy,
        'vedeo': vedeo,
        'ceremonyId': ceremonyId,
        'body': body,
        'hashTag': hashTag
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  //Future<Post> set(String token, String dirUrl, imageFileList {String? token, dirUrl, var imageFileList})
  Future<Post> set(String token, String dirUrl, imageFileList) async {
    // Uri url = Uri.parse(Api + 'posts/add');
    Uri url = Uri.parse(dirUrl);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis $token"
    }; // ignore this headers if there is no authentication

    Map<String, String> toMap() =>
        {"body": body, "createdBy": createdBy, 'ceremonyId': ceremonyId};
    var request = http.MultipartRequest('POST', url);

    // print('fileeeeeeeeeeeee');
    // print(imageFileList);

    request.headers.addAll(headers);
    // List<http.MultipartFile> files = [];

    // if (imageFileList != null) {
    //   for (int x = 0; x <= imageFileList!.length - 1; x++) {
    //     files.add(await http.MultipartFile.fromPath(
    //         'media[]', imageFileList![x].path));
    //   }
    // }

    // print('fileeeeeeeeeeeee');
    // print(imageFileList);
    request.fields.addAll(toMap());

    request.files
        .add(await http.MultipartFile.fromPath('media[]', imageFileList));
    var res = await request.send();

    String data = await res.stream.bytesToString();

    return Post.fromJson(
        {"status": res.statusCode, "payload": jsonDecode(data)['payload']});
    //return Post.fromJson({"status": false});
  }

  Future<Post> getPostByCeremonyId(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'ceremonyId': ceremonyId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<Post> getPostByUserId(String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'userId': id,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  //Gets Like
  Future<Post> likes(String token, String dirUrl, String isLike) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'isLike': isLike, 'postId': pId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  //Get Shares
  Future<Post> share(String token, String dirUrl, String table) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'fromTable': table, 'tableId': pId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

//Get Shares
  Future<Post> remove(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': pId};
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
    return Post.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<Post> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    print(r.body); // Debugger
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<Post> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

Post rBody(http.Response r) {
  return Post.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
