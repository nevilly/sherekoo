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
          final itm = crmV[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CrmDoor(
                            crm: CeremonyModel(
                              cId: itm.crmInfo.cId,
                              codeNo: itm.crmInfo.codeNo,
                              ceremonyDate: itm.crmInfo.ceremonyDate,
                              cImage: itm.crmInfo.cImage,
                              cName: itm.crmInfo.cName,
                              ceremonyType: itm.crmInfo.ceremonyType,
                              contact: itm.crmInfo.contact,
                              admin: itm.crmInfo.admin,
                              fId: itm.crmInfo.fId,
                              sId: itm.crmInfo.sId,
                              youtubeLink: itm.crmInfo.youtubeLink,
                              isInFuture: itm.crmInfo.isInFuture,
                              isCrmAdmin: itm.isAdmin,
                                likeNo:'',
      chatNo: '',
      viwersNo: '',
                              userFid: User(
                                  id: itm.crmInfo.userFid.id,
                                  username: itm.crmInfo.userFid.username,
                                  firstname: itm.crmInfo.userFid.firstname,
                                  lastname: itm.crmInfo.userFid.lastname,
                                  avater: itm.crmInfo.userFid.avater,
                                  phoneNo: itm.crmInfo.userFid.phoneNo,
                                  email: itm.crmInfo.userFid.email,
                                  gender: itm.crmInfo.userFid.gender,
                                  role: itm.crmInfo.userFid.role,
                                  address: itm.crmInfo.userFid.address,
                                  meritalStatus:
                                      itm.crmInfo.userFid.meritalStatus,
                                  bio: itm.crmInfo.userFid.bio,
                                  totalPost: '',
                                  isCurrentUser: '',
                                  isCurrentCrmAdmin: '',
                                  isCurrentBsnAdmin: '',
                                  totalFollowers: '',
                                  totalFollowing: '',
                                  totalLikes: ''),
                              userSid: User(
                                  id: itm.crmInfo.userSid.id,
                                  username: itm.crmInfo.userSid.username,
                                  firstname: itm.crmInfo.userSid.firstname,
                                  lastname: itm.crmInfo.userSid.lastname,
                                  avater: itm.crmInfo.userSid.avater,
                                  phoneNo: itm.crmInfo.userSid.phoneNo,
                                  email: itm.crmInfo.userSid.email,
                                  gender: itm.crmInfo.userSid.gender,
                                  role: itm.crmInfo.userSid.role,
                                  address: itm.crmInfo.userSid.address,
                                  meritalStatus:
                                      itm.crmInfo.userSid.meritalStatus,
                                  bio: itm.crmInfo.userSid.bio,
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
