import 'package:flutter/material.dart';
import 'package:sherekoo/model/admin/adminCrmMdl.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/admin/adminCrm.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/boxImg.dart';

class AdminPage extends StatefulWidget {
  final String from;
  final User user;
  const AdminPage({Key? key, required this.from, required this.user})
      : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final Preferences _preferences = Preferences();
  String token = '';

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        widget.from == 'Crm' ? getAllCrm(widget.user.id) : 'jsjs';
      });
    });

    super.initState();
  }

  List<AdminCrmMdl> admCrm = [];
  getAllCrm(userId) async {
    AllCeremonysModel(payload: [], status: 0)
        .getCeremonyByUserId(token, urlAdminCrmnByUserId, userId)
        .then((v) {
      if (v.status == 200) {
        setState(() {
          admCrm = v.payload
              .map<AdminCrmMdl>((e) => AdminCrmMdl.fromJson(e))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.transparent,
          title: const Text('Admin Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 105,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: admCrm.length,
                    itemBuilder: (context, i) {
                      final adm = admCrm[i];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: OColors.primary,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Center(
                                      child: adm.cImage != ''
                                          ? Img(
                                              avater: adm.cImage,
                                              url: '/ceremony/',
                                              username: adm.userFid.username,
                                              width: 60,
                                              height: 60,
                                            )
                                          : const SizedBox(height: 1)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              adm.ceremonyDate,
                              style: header11,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Text(
                'booddyyy',
                style: header12,
              ),
            ],
          ),
        ));
  }
}
