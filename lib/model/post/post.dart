import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  final String pId;
  final String createdBy;
  final String body;
  final String vedeo;
  final String ceremonyId;

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
      body: json['body'] ?? "",
      username: json['username'] ?? "",
      avater: json['avater'] ?? "",
    );
  }

  Future<Post> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Post.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((r) {
      print('Our status Code');
      print(r.statusCode);
      if (r.statusCode == 200) {
        print(r.body);
        return Post.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return Post.fromJson({'status': r.statusCode, 'payload': {}});
      }
    });
  }

 

  Future<Post> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Post.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'createdBy': createdBy,
        'vedeo': vedeo,
        'ceremonyId': ceremonyId,
        'body': body
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return Post.fromJson(rJson);
      }
      return Post.fromJson({'status': false});
    });
  }

  //Future<Post> set(String token, String dirUrl, imageFileList {String? token, dirUrl, var imageFileList})
  Future<Post> set(String token, String dirUrl, imageFileList) async {
    // Uri url = Uri.parse(Api + 'posts/add');
    Uri url = Uri.parse(dirUrl);
 
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis " + token
    }; // ignore this headers if there is no authentication

     Map<String, String> toMap() => {"body": body, "createdBy": createdBy,
     'ceremonyId':ceremonyId
     };
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

    print(data);

    return Post.fromJson(
        {"status": res.statusCode, "payload": jsonDecode(data)['payload']});
    //return Post.fromJson({"status": false});
  }

  Future<Post> getPostByCeremonyId(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Post.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'ceremonyId': ceremonyId,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return Post.fromJson(rJson);
      }
      return Post.fromJson(rJson);
    });
  }

  Future<Post> getPostByUserId(String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Post.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'userId': id,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return Post.fromJson(rJson);
      }
      return Post.fromJson(rJson);
    });
  }
}
