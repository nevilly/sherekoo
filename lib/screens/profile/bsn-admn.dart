// ignore_for_file: iterable_contains_unrelated_type

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/requests/requestsModel.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/screens/subscriptionScreen/update-subscription.dart';
import 'package:sherekoo/screens/uploadScreens/busnessUpload.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';

import '../../model/busness/admBsn-model.dart';
import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/requests/requests.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../detailScreen/bsn-details.dart';

class BSnAdminPage extends StatefulWidget {
  final User user;
  const BSnAdminPage({Key? key, required this.user}) : super(key: key);

  @override
  State<BSnAdminPage> createState() => _BSnAdminPageState();
}

class _BSnAdminPageState extends State<BSnAdminPage> {
  int page = 0, limit = 12, offset = 1;

  final _controller = ScrollController();
  final _controller2 = ScrollController();
  CeremonyModel crmModel = CeremonyModel(
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
    isInFuture: '',
    isCrmAdmin: '',
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
    youtubeLink: '',
  );

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAllBsn(offset: offset, limit: limit);
        // getAllCrmReq();
      });
    });

    _controller.addListener(() {
      if (_controller.hasClients &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        onPage(page);
      }
    });

    _controller2.addListener(() {
      if (_controller2.hasClients &&
          _controller2.offset >= _controller2.position.maxScrollExtent &&
          !_controller2.position.outOfRange) {
        onPage(page);
      }
    });

    super.initState();
  }

  List<AdmnBsnModel> admBsn = [];

  onPage(int pag) {
    if (mounted) {
      setState(() {
        if (page > pag) {
          page--;
        } else {
          page++;
        }
        offset = page * limit;
      });
    }

    //print("Select * from posts order by id limit ${offset}, ${limit}");
    getAllBsn(offset: offset, limit: limit);
  }

  getAllBsn({int? offset, int? limit}) async {
    String d = offset != null && limit != null ? "$offset/$limit" : '';
    // print('$urlAdmCrmnRequests/$d');
    CrmCall(payload: [], status: 0)
        .get(token, '$urlAdmBsnRequests/$d')
        .then((v) {
      if (v.status == 200) {
        setState(() {
          admBsn.addAll(v.payload
              .map<AdmnBsnModel>((e) => AdmnBsnModel.fromJson(e))
              .toList());
        });
      }
    });
  }

  ecceptIgnoreRequest(adm, RequestsModel r) {
    // final firstWhere = r.firstWhere((item) => item.hostId == reqId);
    Requests(
        hostId: r.hostId,
        busnessId: '',
        contact: '',
        ceremonyId: '',
        createdBy: '',
        type: '',
        status: 0,
        payload: []).updateRequest(token, urlUpdatelRequest).then((value) {
      if (value.status == 200) {
        setState(() {
          for (var e in admBsn) {
            if (e.bId == adm.bId) {
              if (value.payload == '1') {
                r.confirm = '2';
              } else {
                // Ignore
                r.confirm = '1';
              }
            }
          }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 105,
                child: ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: admBsn.length,
                    itemBuilder: (context, i) {
                      final adm = admBsn[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => BsnDetails(
                                      data: admBsnMdl(adm),
                                      ceremonyData: emptyCrmModel)));
                        },
                        child: Padding(
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
                                        child: adm.coProfile != ''
                                            ? fadeImg(
                                                context,
                                                '${api}public/uploads/${adm.user.username!}/busness/${adm.coProfile}',
                                                60,
                                                60,BoxFit.fitWidth)
                                            : const SizedBox(height: 1)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // adm.isInFuture == 'true'
                              //     ?
                              Text(
                                adm.knownAs,
                                style: header11,
                              )
                              // : Text(
                              //     adm.ceremonyDate,
                              //     style: header11.copyWith(
                              //         color: OColors.danger),
                              //   )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Requests',
                  style: header14,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                    controller: _controller2,
                    itemCount: admBsn.length,
                    itemBuilder: (context, i) {
                      final adm = admBsn[i];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      //adm.isInFuture == 'false'
                                      //     ? OColors.danger
                                      //     :
                                      OColors.primary,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        // onTap: () {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (BuildContext
                                        //                   context) =>
                                        //               Livee(
                                        //                 ceremony:
                                        //                     CeremonyModel(
                                        //                   cId: adm.cId,
                                        //                   codeNo:
                                        //                       adm.codeNo,
                                        //                   ceremonyType: adm
                                        //                       .ceremonyType,
                                        //                   cName:
                                        //                       adm.cName,
                                        //                   fId: adm.fId,
                                        //                   sId: adm.sId,
                                        //                   cImage:
                                        //                       adm.cImage,
                                        //                   ceremonyDate: adm
                                        //                       .ceremonyDate,
                                        //                   admin:
                                        //                       adm.admin,
                                        //                   contact:
                                        //                       adm.contact,
                                        //                   isInFuture: adm
                                        //                       .isInFuture,
                                        //                   isCrmAdmin: adm
                                        //                       .isCrmAdmin,
                                        //                   likeNo: '',
                                        //                   chatNo: '',
                                        //                   viwersNo: '',
                                        //                   userFid:
                                        //                       adm.userFid,
                                        //                   userSid:
                                        //                       adm.userSid,
                                        //                   youtubeLink: adm
                                        //                       .youtubeLink,
                                        //                 ),
                                        //               )));
                                        // },

                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      BsnDetails(
                                                          data: admBsnMdl(adm),
                                                          ceremonyData:
                                                              emptyCrmModel)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Center(
                                                child: adm.coProfile != ''
                                                    ? fadeImg(
                                                        context,
                                                        '${api}public/uploads/${adm.user.username!}/busness/${adm.coProfile}',
                                                        40,
                                                        40,BoxFit.fitWidth)
                                                    : const SizedBox(
                                                        height: 1)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            adm.knownAs,
                                            style: header13.copyWith(
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            adm.busnessType,
                                            style: header11,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      BusnessUpload(
                                                          getData:
                                                              admBsnMdl(adm))));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child:
                                                Text('Edit', style: header14)),
                                      ),
                                      const SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      UpdateSubscription(
                                                          subscription: adm
                                                              .subscriptionInfo!,
                                                          bsn: admBsnMdl(adm),
                                                          from: 'bsnAdm')));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              adm.subscriptionInfo!.level,
                                              style: header14),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                top: 4,
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: adm.req.length,
                                  itemBuilder: (context, x) {
                                    final r = adm.req[x];
                                    return r.hostId != ''
                                        ? r.crmInfo!.cId != ''
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (adm.subscriptionInfo!
                                                                .activeted !=
                                                            '0') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                              context) =>
                                                                          Livee(
                                                                            ceremony:
                                                                                r.crmInfo!,
                                                                          )));
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Center(
                                                                child: r.crmInfo!
                                                                            .cImage !=
                                                                        ''
                                                                    ? adm.subscriptionInfo!.activeted ==
                                                                            '0'
                                                                        ? ImageFiltered(
                                                                            imageFilter:
                                                                                ImageFilter.blur(
                                                                              tileMode: TileMode.mirror,
                                                                              sigmaX: 7.0,
                                                                              sigmaY: 7.0,
                                                                            ),
                                                                            child: fadeImg(
                                                                                context,
                                                                                '${api}public/uploads/${r.crmInfo!.userFid.username}/ceremony/${r.crmInfo!.cImage}',
                                                                                40,
                                                                                40,BoxFit.fitWidth),
                                                                          )
                                                                        : fadeImg(
                                                                            context,
                                                                            '${api}public/uploads/${r.crmInfo!.userFid.username}/ceremony/${r.crmInfo!.cImage}',
                                                                            40,
                                                                            40,BoxFit.fitWidth)
                                                                    : const SizedBox(
                                                                        height:
                                                                            1)),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  r.crmInfo!
                                                                      .ceremonyType,
                                                                  style:
                                                                      header14),
                                                              adm.subscriptionInfo!
                                                                          .activeted !=
                                                                      '0'
                                                                  ? Text(
                                                                      r.crmInfo!
                                                                          .ceremonyDate,
                                                                      style:
                                                                          header12)
                                                                  : const SizedBox
                                                                      .shrink()
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  adm.subscriptionInfo!
                                                              .activeted ==
                                                          '0'
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        UpdateSubscription(
                                                                          subscription: r
                                                                              .bsnInfo!
                                                                              .subscriptionInfo!,
                                                                          bsn: admBsnMdl(
                                                                              adm),
                                                                          from:
                                                                              'bsnAdmin2',
                                                                        )));
                                                          
                                                          },
                                                          child: Text(
                                                            'View',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: OColors
                                                                    .primary),
                                                          ),
                                                        )
                                                      : r.isInService == 'true'
                                                          ? Text(
                                                              'Selected',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: OColors
                                                                      .primary),
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                ecceptIgnoreRequest(
                                                                  adm,
                                                                  r,
                                                                );
                                                              },
                                                              child:
                                                                  r.confirm ==
                                                                          '1'
                                                                      ? Text(
                                                                          'Accept',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: OColors.primary),
                                                                        )
                                                                      : Text(
                                                                          'Ignore',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: OColors.primary),
                                                                        )),
                                                ],
                                              )
                                            : const SizedBox.shrink()
                                        : Text(
                                            'No Context',
                                            style: header10,
                                          );
                                  }),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  BusnessModel admBsnMdl(AdmnBsnModel adm) {
    return BusnessModel(
        location: adm.location,
        bId: adm.bId,
        knownAs: adm.knownAs,
        coProfile: adm.coProfile,
        busnessType: adm.busnessType,
        createdDate: adm.createdDate,
        companyName: adm.companyName,
        ceoId: adm.ceoId,
        price: adm.price,
        contact: adm.contact,
        hotStatus: adm.hotStatus,
        aboutCEO: adm.aboutCEO,
        aboutCompany: adm.aboutCompany,
        createdBy: adm.createdBy,
        user: adm.user,
        subscriptionInfo: adm.subscriptionInfo,
        isBsnAdmin: adm.isBsnAdmin);
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
                      builder: (BuildContext context) =>
                          BusnessUpload(getData: emptyBsnMdl)));
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
