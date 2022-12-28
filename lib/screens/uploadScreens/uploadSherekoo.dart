// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../model/ceremony/crm-model.dart';
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
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        backgroundColor: OColors.secondary,
        body: Column(
          children: [
            TabBar(
                labelColor: OColors.primary,
                unselectedLabelColor: OColors.primary,
                indicatorColor: OColors.primary,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
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
