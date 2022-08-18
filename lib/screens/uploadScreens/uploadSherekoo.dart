// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import 'uploadImage.dart';
import 'uploadVedeo.dart';

class SherekooUpload extends StatefulWidget {
  final String from;
  final CeremonyModel crm;
  const SherekooUpload({Key? key, required this.from, required this.crm})
      : super(key: key);

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
          backgroundColor: OColors.appBarColor,
          title: const Text('Upload',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              )),
          // ignore: prefer_const_literals_to_create_immutables
        ),
        body: Column(
          children: [
            const TabBar(
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
              UploadImage(from: widget.from, crm: widget.crm),

              //Vedio Uploader...
              UploadVedeo(
                from: widget.from,
                crm: widget.crm,
              )
            ])),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
