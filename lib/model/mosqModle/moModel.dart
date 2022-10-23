import 'dart:convert';

import 'package:http/http.dart' as http;

class MosqPostModel {
  final String pId;
  final String createdBy;
  final String body;
  final String vedeo;
  final String title;
  final String amount;


  dynamic status;
  dynamic payload;

  MosqPostModel(
      {required this.pId,
      required this.createdBy,
      required this.body,
      required this.vedeo,
      required this.title,
      required this.amount,
      required this.status,
      required this.payload});

  factory MosqPostModel.fromJson(Map<String, dynamic> json) {
    return MosqPostModel(
      status: json['status'],
      payload: json['payload'],
      pId: json['pId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      vedeo: json['vedeo'] ?? "",
      title: json['title'] ?? "",
      amount: json['amount'] ?? "",
      body: json['body'] ?? ""
    );
  }

  Future<MosqPostModel> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return MosqPostModel.fromJson({
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
        return MosqPostModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return MosqPostModel.fromJson({'status': r.statusCode, 'payload': {}});
      }
    });
  }

  Future<MosqPostModel> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return MosqPostModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'title': createdBy,
        'vedeo': vedeo,
         'amount': amount,
        'body': body,
       
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return MosqPostModel.fromJson(rJson);
      }
      return MosqPostModel.fromJson({'status': false});
    });
  }

  //Future<Post> set(String token, String dirUrl, imageFileList {String? token, dirUrl, var imageFileList})
  Future<MosqPostModel> set(String token, String dirUrl, imageFileList) async {
    // Uri url = Uri.parse(Api + 'posts/add');
    Uri url = Uri.parse(dirUrl);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Owesis $token"
    }; // ignore this headers if there is no authentication

    Map<String, String> toMap() =>
        {"body": body, "createdBy": createdBy, 'title': amount};
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

    return MosqPostModel.fromJson(
        {"status": res.statusCode, "payload": jsonDecode(data)['payload']});
    //return Post.fromJson({"status": false});
  }

}
