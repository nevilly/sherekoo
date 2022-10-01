import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sherekoo/util/pallets.dart';

import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/ceremony/crmViewerModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../crmScreen/crmDoor.dart';

class MyCrmn extends StatefulWidget {
  final String userId;
  const MyCrmn({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyCrmn> createState() => _MyCrmnState();
}

class _MyCrmnState extends State<MyCrmn> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<CeremonyModel> myCeremony = [];
  List<CrmViewersModel> crmV = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        getCeremonyPosts(widget.userId);
      });
    });
    super.initState();
  }

  // My all ceremonie post
  Future getCeremonyPosts(id) async {
    AllCeremonysModel(payload: [], status: 0)
        .getCrmViewr(token, '$urlGetCrmViewrs/userId/$id')
        .then((value) {
      if (value.status == 200) {
        // print(value.payload);
        setState(() {
          crmV = value.payload
              .map<CrmViewersModel>((e) => CrmViewersModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        crossAxisSpacing: 1,
        mainAxisSpacing: 3,
        crossAxisCount: 6,
        shrinkWrap: true,
        itemCount: crmV.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CrmDoor(
                            crm: CeremonyModel(
                              cId: crmV[index].crmInfo.cId,
                              codeNo: crmV[index].crmInfo.codeNo,
                              ceremonyDate: crmV[index].crmInfo.ceremonyDate,
                              cImage: crmV[index].crmInfo.cImage,
                              cName: crmV[index].crmInfo.cName,
                              ceremonyType: crmV[index].crmInfo.ceremonyType,
                              contact: crmV[index].crmInfo.contact,
                              admin: crmV[index].crmInfo.admin,
                              fId: crmV[index].crmInfo.fId,
                              sId: crmV[index].crmInfo.sId,
                              youtubeLink: crmV[index].crmInfo.youtubeLink,
                              userFid: User(
                                  id: crmV[index].crmInfo.userFid.id,
                                  username:
                                      crmV[index].crmInfo.userFid.username,
                                  firstname:
                                      crmV[index].crmInfo.userFid.firstname,
                                  lastname:
                                      crmV[index].crmInfo.userFid.lastname,
                                  avater: crmV[index].crmInfo.userFid.avater,
                                  phoneNo: crmV[index].crmInfo.userFid.phoneNo,
                                  email: crmV[index].crmInfo.userFid.email,
                                  gender: crmV[index].crmInfo.userFid.gender,
                                  role: crmV[index].crmInfo.userFid.role,
                                  address: crmV[index].crmInfo.userFid.address,
                                  meritalStatus:
                                      crmV[index].crmInfo.userFid.meritalStatus,
                                  bio: crmV[index].crmInfo.userFid.bio,
                                  totalPost: '',
                                  isCurrentUser: '',
                                  isCurrentCrmAdmin: '',
                                  isCurrentBsnAdmin: '',
                                  totalFollowers: '',
                                  totalFollowing: '',
                                  totalLikes: ''),
                              userSid: User(
                                  id: crmV[index].crmInfo.userSid.id,
                                  username:
                                      crmV[index].crmInfo.userSid.username,
                                  firstname:
                                      crmV[index].crmInfo.userSid.firstname,
                                  lastname:
                                      crmV[index].crmInfo.userSid.lastname,
                                  avater: crmV[index].crmInfo.userSid.avater,
                                  phoneNo: crmV[index].crmInfo.userSid.phoneNo,
                                  email: crmV[index].crmInfo.userSid.email,
                                  gender: crmV[index].crmInfo.userSid.gender,
                                  role: crmV[index].crmInfo.userSid.role,
                                  address: crmV[index].crmInfo.userSid.address,
                                  meritalStatus:
                                      crmV[index].crmInfo.userSid.meritalStatus,
                                  bio: crmV[index].crmInfo.userSid.bio,
                                  totalPost: '',
                                  isCurrentUser: '',
                                  isCurrentCrmAdmin: '',
                                  isCurrentBsnAdmin: '',
                                  totalFollowers: '',
                                  totalFollowing: '',
                                  totalLikes: ''),
                            ),
                          
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Stack(clipBehavior: Clip.hardEdge, children: [
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: crmV[index].crmInfo.cImage != ''
                              ? FadeInImage(
                                  image: NetworkImage(
                                      '${api}public/uploads/${crmV[index].crmInfo.userFid.username}/ceremony/${crmV[index].crmInfo.cImage}'),
                                  fadeInDuration:
                                      const Duration(milliseconds: 100),
                                  placeholder: const AssetImage(
                                      'assets/logo/noimage.png'),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/logo/noimage.png',
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                )
                              : const SizedBox(height: 1)),
                    ),
                    Positioned(
                      left: 2,
                      bottom: 2,
                      child: Container(
                          decoration: BoxDecoration(
                              color: OColors.primary,
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  crmV[index].crmInfo.ceremonyType,
                                  style:
                                      h5.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ))),
                    )
                  ]),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return const StaggeredTile.fit(2);
        });
  }
}
