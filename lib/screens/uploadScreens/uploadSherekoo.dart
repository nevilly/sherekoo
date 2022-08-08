// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../util/Preferences.dart';
import 'uploadImage.dart';
import 'uploadVedeo.dart';

class SherekooUpload extends StatefulWidget {
  const SherekooUpload({Key? key}) : super(key: key);

  @override
  State<SherekooUpload> createState() => _SherekooUploadState();
}

class _SherekooUploadState extends State<SherekooUpload> {
  final Preferences _preferences = Preferences();
  String token = "";

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          title: const Text('Upload',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              )),
          // ignore: prefer_const_literals_to_create_immutables
        ),
        body: Column(
          children: const [
            TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Image',
                  ),
                  Tab(
                    text: 'Vedio',
                  ),
                ]),
            Expanded(
                child: TabBarView(children: [
              // Image Uploading
              UploadImage(),

              //Vedio Uploader...
              UploadVedeo()
            ])),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
