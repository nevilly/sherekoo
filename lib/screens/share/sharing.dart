import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Sharing extends StatefulWidget {
  const Sharing({Key? key}) : super(key: key);

  @override
  State<Sharing> createState() => _SharingState();
}

class _SharingState extends State<Sharing> {
  TextEditingController textdata = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sharing'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
                controller: textdata,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter Message'))),
          ),
          ElevatedButton(
            child: const Text('Share Text'),
            onPressed: () async {
              if (textdata.value.text.isNotEmpty) {
                // final url = 'https://protocoderspoint.com/';
                await Share.share('${textdata.value.text} ');
              }
            },
          ),
          // Image.network(
          //     'https://res.cloudinary.com/practicaldev/image/fetch/s--_HBZhuhF--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/nweeqf97l2md3tlqkjyt.jpg'),

          ElevatedButton(
            onPressed: () async {
              // final String dirUrl = api +
              //     'public/uploads/' +
              //     widget.username +
              //     '/posts/' +
              //     widget.postVedeo;
              Uri url = Uri.parse(
                  'https://res.cloudinary.com/practicaldev/image/fetch/s--_HBZhuhF--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/nweeqf97l2md3tlqkjyt.jpg');
              final response = await http.get(url);

              if (response.bodyBytes.isEmpty) {
                print('empty');
              } else {
                final bytes = response.bodyBytes;

                print(bytes);

                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';

                File(path).writeAsBytesSync(bytes);
                print('pathh');
                print(path);
                await Share.shareFiles([path]);
              }
            },
            child: Text('share'),
          ),
        ],
      ),
    );
  }
}
