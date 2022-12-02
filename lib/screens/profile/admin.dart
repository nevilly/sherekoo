import 'package:flutter/material.dart';
import 'package:sherekoo/model/admin/adminCrmMdl.dart';
import 'package:sherekoo/screens/uploadScreens/ceremonyUpload.dart';
import 'package:sherekoo/util/colors.dart';


import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/textStyle-pallet.dart';
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
        // getAllCrmReq();
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

  List<AdminCrmMdl> admCrmReq = [];
  getAllCrmReq() async {
    AllCeremonysModel(payload: [], status: 0)
        .get(
      token,
      urlAdmCrmnRequests,
    )
        .then((v) {
      if (v.status == 200) {
        // print('Ceremony Requests');
        // print(v.payload);
        setState(() {
          admCrmReq = v.payload
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
        appBar: toBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                                              username: adm.userFid.username!,
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

  AppBar toBar(BuildContext context) {
    return AppBar(
        backgroundColor: OColors.transparent,
        title: Text(
          'Admin Page',
          style: header16,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CeremonyUpload(
                          getData: CeremonyModel(
                            cId: '',
                            codeNo: '',
                            ceremonyType: '',
                            cName: '',
                            fId: '',
                            sId: '',
                            cImage: '',
                            ceremonyDate: '',
                            admin: '',
                            contact: '',
                            isInFuture:'',
                            isCrmAdmin: '',
                              likeNo:'',
      chatNo: '',
      viwersNo: '',
                            userFid: User(
                                id: '',
                                username: '',
                                firstname: '',
                                lastname: '',
                                avater: '',
                                phoneNo: '',
                                email: '',
                                gender: '',
                                role: '',
                                address: '',
                                meritalStatus: '',
                                bio: '',
                                totalPost: '',
                                isCurrentUser: '',
                                isCurrentCrmAdmin: '',
                                isCurrentBsnAdmin: '',
                                totalFollowers: '',
                                totalFollowing: '',
                                totalLikes: ''),
                            userSid: User(
                                id: '',
                                username: '',
                                firstname: '',
                                lastname: '',
                                avater: '',
                                phoneNo: '',
                                email: '',
                                gender: '',
                                role: '',
                                address: '',
                                meritalStatus: '',
                                bio: '',
                                totalPost: '',
                                isCurrentUser: '',
                                isCurrentCrmAdmin: '',
                                isCurrentBsnAdmin: '',
                                totalFollowers: '',
                                totalFollowing: '',
                                totalLikes: ''),
                            youtubeLink: '',
                          ),
                          getcurrentUser: widget.user)));
           
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: OColors.fontColor, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: OColors.fontColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ]);
  }
}
