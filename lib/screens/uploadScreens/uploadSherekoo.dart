// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../model/ceremony/crm-model.dart';
import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import 'busnessUpload.dart';
import 'ceremonyUpload.dart';
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
  User user = User(
      id: '',
      gId: '',
      urlAvatar: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
      });
    });
    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await UsersCall(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
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
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CeremonyUpload(
                                      getData: emptyCrmModel,
                                      getcurrentUser: user,
                                    )));
                      },
                      child: addProject('Ceremony')),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BusnessUpload(
                                      getData: emptyBsnMdl,
                                    )));
                      },
                      child: addProject('Busness')),
                ],
              ),
            ),
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
              UploadImage(
                from: widget.from,
                crm: widget.crm,
                user: user,
              ),

              //Vedio Uploader...
              UploadVedeo(
                from: widget.from,
                crm: widget.crm,
                user: user,
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

  Container addProject(String title) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: prmry)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 12),
        child: Row(
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(title, style: header14),
          ],
        ),
      ),
    );
  }
}
