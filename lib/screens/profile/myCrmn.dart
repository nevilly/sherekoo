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
                                cId: crmV[index].cId,
                                codeNo: crmV[index].codeNo,
                                ceremonyDate: crmV[index].ceremonyDate,
                                cImage: crmV[index].cImage,
                                cName: crmV[index].cName,
                                ceremonyType: crmV[index].ceremonyType,
                                contact: crmV[index].contact,
                                userFid: User(
                                    id: '',
                                    username: crmV[index].crmUsername,
                                    firstname: crmV[index].u1Fname,
                                    lastname: crmV[index].u1Lname,
                                    avater: crmV[index].u1Avt,
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
                                    username: crmV[index].u2Lname,
                                    firstname: crmV[index].u2Fname,
                                    lastname: crmV[index].u2Lname,
                                    avater: crmV[index].u2Avt,
                                    phoneNo: '',
                                    email: '',
                                    gender: crmV[index].u2g,
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
                                admin: crmV[index].admin,
                                fId: crmV[index].fId,
                                sId: crmV[index].sId,
                                youtubeLink: crmV[index].youtubeLink),
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
                          child: crmV[index].cImage != ''
                              ? FadeInImage(
                                  image: NetworkImage(
                                      '${api}public/uploads/${crmV[index].crmUsername}/ceremony/${crmV[index].cImage}'),
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
                                  crmV[index].ceremonyType,
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
