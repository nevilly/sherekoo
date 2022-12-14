import 'package:flutter/material.dart';
import 'package:sherekoo/screens/bsnScreen/bsn-screen.dart';

import '../../model/busness/bsn-call.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../screens/detailScreen/bsn-details.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class CategoryBody extends StatefulWidget {
  final Stream<String> stream;
  final String sType;
  final String title;
  final double heights;
  final bool crm;
  final int crossAxisCountx;
  final String hotStatus;
  final CeremonyModel ceremony;

  const CategoryBody(
      {Key? key,
      required this.stream,
      required this.ceremony,
      required this.sType,
      required this.title,
      required this.heights,
      required this.crm,
      required this.crossAxisCountx,
      required this.hotStatus})
      : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
 

  List<BusnessModel> data = [];

  CeremonyModel ceremony = CeremonyModel(
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
      isCrmAdmin: '',
      isInFuture: '',
      likeNo: '',
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
      youtubeLink: '');
  String bsnType = '';

  @override
  void initState() {
    super.initState();
    preferences.init();
    preferences.get('token').then((value) {
      widget.stream.listen((page) {
        setState(() {
          token = value;
          bsnType = page;
        });

        // ceremonyLIfe
        if (page == 'Sherekoo') {
          getAllCrmn(widget.sType);
        }

        getAll(page);
      });
    });
  }

  getAll(bsn) async {
    BsnCall(payload: [], status: 0)
        .onGoldenBusness(token, urlGoldBusness, bsn, '')
        .then((value) {
      if (mounted) {
        if (value.status == 200) {
          // print(value.payload);
          setState(() {
            data = value.payload.map<BusnessModel>((e) {
              return BusnessModel.fromJson(e);
            }).toList();
          });
        }
      }
    });
  }

  getAllCrmn(datatype) async {
    AllCeremonysModel(payload: [], status: 0)
        .getCeremonyByType(token, urlGetCrmByType, datatype)
        .then((value) {
      if (mounted) {
        if (value.status == 200) {
          setState(() {
            data = value.payload
                .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
                .toList();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Top Header
        Container(
          padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 5,
                  left: 10,
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(color: OColors.fontColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BusnessScreen(
                              bsnType: bsnType, ceremony: ceremony)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 5,
                    right: 4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, top: 2, right: 10, bottom: 2),
                    decoration: BoxDecoration(
                        // color: OColors.primary,
                        border: Border.all(color: OColors.primary, width: 0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'All',
                      style: TextStyle(color: OColors.primary, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Body
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: widget.heights,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCountx),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BsnDetails(
                                          data: data[index],
                                          ceremonyData: widget.ceremony,
                                        )));
                          },
                          child: Column(children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(1.0),
                                  topRight: Radius.circular(1.0),
                                ),
                                child: data[index].coProfile != ''
                                    ? Image.network(
                                        '${api}public/uploads/${data[index].user.username}/busness/${data[index].coProfile}',
                                        height: 45,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(height: 1)),
                            Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(top: 1),
                              child: Center(
                                child: data[index].knownAs.length >= 5
                                    ? Text(
                                        '${data[index].knownAs.substring(0, 5)}...',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: OColors.fontColor),
                                      )
                                    : Text(
                                        data[index].knownAs,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: OColors.fontColor),
                                      ),
                              ),
                            ),
                          ]),
                        ));
                  })),
        ), //Top Header
      ],
    );
  }
}
