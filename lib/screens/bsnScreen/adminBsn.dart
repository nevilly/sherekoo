import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/requests/requests.dart';
import '../../model/requests/requestsModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class AdminBsn extends StatefulWidget {
  final BusnessModel bsn;
  const AdminBsn({Key? key, required this.bsn}) : super(key: key);

  @override
  State<AdminBsn> createState() => _AdminBsnState();
}

class _AdminBsnState extends State<AdminBsn> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<RequestsModel> req = [];

  late BusnessModel bsn;

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        bsn = widget.bsn;
        getBsnRequests();
      });
    });
  }

  ///
  ///Send bsn Id to Api
  ///
  getBsnRequests() async {
    Requests(
            hostId: '',
            busnessId: '',
            contact: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'busness')
        .getGoldenRequest(token, urlGetGoldReq, '34')
        .then((v) {
      if (v.status == 200) {
        // print(v.payload);

        setState(() {
          req = v.payload.map<RequestsModel>((e) {
            return RequestsModel.fromJson(e);
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: const Text('Admin'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: req.length,
                itemBuilder: (context, i) {
                  return Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: ListTile(
                        tileColor: OColors.darGrey,
                        horizontalTitleGap: 8,
                        leading: req[i].activeted != '0'
                            ? ClipRect(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    tileMode: TileMode.mirror,
                                    sigmaX: 7.0,
                                    sigmaY: 7.0,
                                  ),
                                  child: Image.network(
                                    '${api}public/uploads/${req[i].fIdUname}/ceremony/${req[i].cImage}',
                                    height: 70,
                                    width: 65,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Image.network(
                                '${api}public/uploads/${req[i].fIdUname}/ceremony/${req[i].cImage}',
                                height: 70,
                                width: 65,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                        title: Text(
                          req[i].ceremonyType,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: OColors.fontColor),
                        ),
                        subtitle: req[i].activeted != '0'
                            ? Text(
                                req[i].createdDate,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: OColors.fontColor),
                              )
                            : const SizedBox(),
                        trailing: req[i].activeted == '0'
                            ? Text(
                                'View Request',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.primary),
                              )
                            : Text(
                                'Accept',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.primary),
                              ),
                      ));
                },
              ),
            ),
          ],
        ));
  }
}
