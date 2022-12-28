// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:sherekoo/model/admin/adminCrmMdl.dart';
import 'package:sherekoo/model/requests/requestsModel.dart';
import 'package:sherekoo/screens/uploadScreens/ceremonyUpload.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/requests/requests.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../admin/payment.dart';
import '../bsnScreen/bsn-screen.dart';
import '../detailScreen/bsn-details.dart';
import '../detailScreen/livee.dart';

class AdminPage extends StatefulWidget {
  final String from;
  final User user;
  const AdminPage({Key? key, required this.from, required this.user})
      : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
        widget.from == 'Crm' ? getAllCrm(offset: offset, limit: limit) : 'jsjs';
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

  List<AdminCrmMdl> admCrm = [];

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
    getAllCrm(offset: offset, limit: limit);
  }

  getAllCrm({int? offset, int? limit}) async {
    String d = offset != null && limit != null ? "$offset/$limit" : '';
    // print('$urlAdmCrmnRequests/$d');
    CrmCall(payload: [], status: 0)
        .get(token, '$urlAdmCrmnRequests/$d')
        .then((v) {
      if (v.status == 200) {
        setState(() {
          admCrm.addAll(v.payload
              .map<AdminCrmMdl>((e) => AdminCrmMdl.fromJson(e))
              .toList());
        });
      }
    });
  }

  cancelRequest(AdminCrmMdl ob, RequestsModel r) {
    Requests(
        hostId: r.hostId,
        busnessId: '',
        contact: '',
        ceremonyId: '',
        createdBy: '',
        type: '',
        status: 0,
        payload: []).cancelRequest(token, urlCancelRequest).then((v) {
      if (v.status == 200) {
        setState(() {
          for (var e in admCrm) {
            if (e.cId == ob.cId) {
              e.req.removeWhere((el) => el.hostId == r.hostId);
            }
          }
        });
      }
    });
  }

  // removeSelected(id) {
  //   ServicesCall(
  //           svId: id,
  //           busnessId: '',
  //           hId: '',
  //           payed: '',
  //           ceremonyId: widget.crm.cId,
  //           createdBy: '',
  //           status: 0,
  //           payload: [],
  //           type: 'ceremony')
  //       .removeService(token, urlRemoveServiceById)
  //       .then((value) {
  //     if (value.status == 200) {
  //       setState(() {
  //         myServ.removeWhere((element) => element.svId == id);
  //       });
  //     }
  //   });
  // }

  void checkSelection(BuildContext context, RequestsModel req) {
    //  for (var e in admCrm) {
    //   if (e.cId == ob.cId) {
    //     e.req.removeWhere((el) => el.hostId == r.hostId);
    //   }
    // }
    // var contain = admCrm
    //     .where(((element) => element.req.  .busnessType == req.bsnInfo!.busnessType));

    // if (contain.isEmpty) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => MyService(
    //                 req: req,
    //               )));
    // } else {

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: toBar(context),
        body: admCrm.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 105,
                      child: ListView.builder(
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: admCrm.length,
                          itemBuilder: (context, i) {
                            final adm = admCrm[i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Livee(
                                              ceremony: CeremonyModel(
                                                cId: adm.cId,
                                                codeNo: adm.codeNo,
                                                ceremonyType: adm.ceremonyType,
                                                cName: adm.cName,
                                                fId: adm.fId,
                                                sId: adm.sId,
                                                cImage: adm.cImage,
                                                ceremonyDate: adm.ceremonyDate,
                                                admin: adm.admin,
                                                contact: adm.contact,
                                                isInFuture: adm.isInFuture,
                                                isCrmAdmin: adm.isCrmAdmin,
                                                likeNo: '',
                                                chatNo: '',
                                                viwersNo: '',
                                                userFid: adm.userFid,
                                                userSid: adm.userSid,
                                                youtubeLink: adm.youtubeLink,
                                              ),
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: OColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Center(
                                              child: adm.cImage != ''
                                                  ? fadeImg(
                                                      context,
                                                      '${api}public/uploads/${adm.userFid.username!}/ceremony/${adm.cImage}',
                                                      60,
                                                      60)
                                                  : const SizedBox(height: 1)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    adm.isInFuture == 'true'
                                        ? Text(
                                            adm.ceremonyDate,
                                            style: header11,
                                          )
                                        : Text(
                                            adm.ceremonyDate,
                                            style: header11.copyWith(
                                                color: OColors.danger),
                                          )
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
                          itemCount: admCrm.length,
                          itemBuilder: (context, i) {
                            final adm = admCrm[i];
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: adm.isInFuture == 'false'
                                            ? OColors.danger
                                            : OColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Livee(
                                                              ceremony:
                                                                  CeremonyModel(
                                                                cId: adm.cId,
                                                                codeNo:
                                                                    adm.codeNo,
                                                                ceremonyType: adm
                                                                    .ceremonyType,
                                                                cName:
                                                                    adm.cName,
                                                                fId: adm.fId,
                                                                sId: adm.sId,
                                                                cImage:
                                                                    adm.cImage,
                                                                ceremonyDate: adm
                                                                    .ceremonyDate,
                                                                admin:
                                                                    adm.admin,
                                                                contact:
                                                                    adm.contact,
                                                                isInFuture: adm
                                                                    .isInFuture,
                                                                isCrmAdmin: adm
                                                                    .isCrmAdmin,
                                                                likeNo: '',
                                                                chatNo: '',
                                                                viwersNo: '',
                                                                userFid:
                                                                    adm.userFid,
                                                                userSid:
                                                                    adm.userSid,
                                                                youtubeLink: adm
                                                                    .youtubeLink,
                                                              ),
                                                            )));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Center(
                                                      child: adm.cImage != ''
                                                          ? fadeImg(
                                                              context,
                                                              '${api}public/uploads/${adm.userFid.username!}/ceremony/${adm.cImage}',
                                                              40,
                                                              40)
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
                                                  adm.cName,
                                                  style: header13.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  adm.ceremonyDate,
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
                                                            editCrmn(adm)));
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12.0),
                                                  child: Text('Edit',
                                                      style: header14)),
                                            ),
                                            const SizedBox(width: 5),
                                            adm.isInFuture == 'true'
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  BusnessScreen(
                                                                    bsnType:
                                                                        'all',
                                                                    ceremony:
                                                                        inviteBsn(
                                                                            adm),
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Text('Invite',
                                                          style: header14),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: adm.req.length,
                                        itemBuilder: (context, x) {
                                          final r = adm.req[x];
                                          return r.hostId != ''
                                              ? r.bsnInfo!.bId != ''
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          BsnDetails(
                                                                            ceremonyData:
                                                                                crmModel,
                                                                            data:
                                                                                r.bsnInfo!,
                                                                          )));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: Center(
                                                                      child: adm.cImage !=
                                                                              ''
                                                                          ? fadeImg(
                                                                              context,
                                                                              '${api}public/uploads/${r.bsnInfo!.user.username!}/busness/${r.bsnInfo!.coProfile}',
                                                                              40,
                                                                              40)
                                                                          : const SizedBox(
                                                                              height: 1)),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        r.bsnInfo!
                                                                            .busnessType,
                                                                        style:
                                                                            header14),
                                                                    Text(
                                                                        r.bsnInfo!
                                                                            .knownAs,
                                                                        style:
                                                                            header12)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        /// Bsn kama amekubali request kutoka kwa crm Admin
                                                        r.confirm == '1'
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  cancelRequest(
                                                                      adm, r);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: OColors
                                                                        .primary,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            4.0,
                                                                        left: 4,
                                                                        right:
                                                                            4),
                                                                    child: Text(
                                                                      'Cancel Req..',
                                                                      style:
                                                                          header10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            :

                                                            ///Bsn Confirmed, request send By  Crm Admin
                                                            /// Then
                                                            ///If Bsn SELECTED: to service table

                                                            r.isInService ==
                                                                    'false'
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (BuildContext context) => MyService(
                                                                                    user: widget.user,
                                                                                    req: r,
                                                                                  )));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: OColors
                                                                            .primary,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          'Pay Now',
                                                                          style:
                                                                              header10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                :

                                                                /// isInService false:  Bsn not SELECTED:
                                                                ///
                                                                /// Bas Crm Admin anatakawa achague Huduma aipendayo

                                                                GestureDetector(
                                                                    onTap: () {
                                                                      // checkSelection(context, req);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: OColors
                                                                            .primary,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                4.0,
                                                                            bottom:
                                                                                4.0,
                                                                            left:
                                                                                8,
                                                                            right:
                                                                                8),
                                                                        child:
                                                                            Text(
                                                                          'Payed', // choose

                                                                          style:
                                                                              header10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
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
              )
            : Container(
                alignment: Alignment.center, child: loadingFunc(35, prmry)));
  }

  CeremonyModel inviteBsn(AdminCrmMdl adm) {
    return CeremonyModel(
      cId: adm.cId,
      codeNo: adm.codeNo,
      ceremonyType: adm.ceremonyType,
      cName: adm.cName,
      fId: adm.fId,
      sId: adm.sId,
      cImage: adm.cImage,
      ceremonyDate: adm.ceremonyDate,
      admin: adm.admin,
      contact: adm.contact,
      isInFuture: adm.isInFuture,
      isCrmAdmin: adm.isCrmAdmin,
      likeNo: '',
      chatNo: '',
      viwersNo: '',
      userFid: User(
          id: adm.userFid.id,
          username: adm.userFid.username,
          firstname: adm.userFid.firstname,
          lastname: adm.userFid.lastname,
          avater: adm.userFid.avater,
          phoneNo: adm.userFid.phoneNo,
          email: adm.userFid.email,
          gender: adm.userFid.gender,
          role: adm.userFid.role,
          address: adm.userFid.address,
          meritalStatus: adm.userFid.meritalStatus,
          bio: adm.userFid.bio,
          totalPost: adm.userFid.totalPost,
          isCurrentUser: adm.userFid.isCurrentUser,
          isCurrentCrmAdmin: adm.userFid.isCurrentCrmAdmin,
          isCurrentBsnAdmin: adm.userFid.isCurrentBsnAdmin,
          totalFollowers: '',
          totalFollowing: '',
          totalLikes: ''),
      userSid: User(
          id: adm.userSid.id,
          username: adm.userSid.username,
          firstname: adm.userSid.firstname,
          lastname: adm.userSid.lastname,
          avater: adm.userSid.avater,
          phoneNo: adm.userSid.phoneNo,
          email: adm.userSid.email,
          gender: adm.userSid.gender,
          role: adm.userSid.role,
          address: adm.userSid.address,
          meritalStatus: adm.userSid.meritalStatus,
          bio: adm.userSid.bio,
          totalPost: '',
          isCurrentUser: adm.userSid.isCurrentUser,
          isCurrentCrmAdmin: adm.userSid.isCurrentCrmAdmin,
          isCurrentBsnAdmin: adm.userSid.isCurrentBsnAdmin,
          totalFollowers: '',
          totalFollowing: '',
          totalLikes: ''),
      youtubeLink: adm.youtubeLink,
    );
  }

  CeremonyUpload editCrmn(AdminCrmMdl adm) {
    return CeremonyUpload(
      getData: CeremonyModel(
        cId: adm.cId,
        codeNo: adm.codeNo,
        ceremonyType: adm.ceremonyType,
        cName: adm.cName,
        fId: adm.fId,
        sId: adm.sId,
        cImage: adm.cImage,
        ceremonyDate: adm.ceremonyDate,
        admin: adm.admin,
        contact: adm.contact,
        isInFuture: adm.isInFuture,
        isCrmAdmin: adm.isCrmAdmin,
        likeNo: '',
        chatNo: '',
        viwersNo: '',
        userFid: User(
            id: adm.userFid.id,
            username: adm.userFid.username,
            firstname: adm.userFid.firstname,
            lastname: adm.userFid.lastname,
            avater: adm.userFid.avater,
            phoneNo: adm.userFid.phoneNo,
            email: adm.userFid.email,
            gender: adm.userFid.gender,
            role: adm.userFid.role,
            address: adm.userFid.address,
            meritalStatus: adm.userFid.meritalStatus,
            bio: adm.userFid.bio,
            totalPost: adm.userFid.totalPost,
            isCurrentUser: adm.userFid.isCurrentUser,
            isCurrentCrmAdmin: adm.userFid.isCurrentCrmAdmin,
            isCurrentBsnAdmin: adm.userFid.isCurrentBsnAdmin,
            totalFollowers: '',
            totalFollowing: '',
            totalLikes: ''),
        userSid: User(
            id: adm.userSid.id,
            username: adm.userSid.username,
            firstname: adm.userSid.firstname,
            lastname: adm.userSid.lastname,
            avater: adm.userSid.avater,
            phoneNo: adm.userSid.phoneNo,
            email: adm.userSid.email,
            gender: adm.userSid.gender,
            role: adm.userSid.role,
            address: adm.userSid.address,
            meritalStatus: adm.userSid.meritalStatus,
            bio: adm.userSid.bio,
            totalPost: '',
            isCurrentUser: adm.userSid.isCurrentUser,
            isCurrentCrmAdmin: adm.userSid.isCurrentCrmAdmin,
            isCurrentBsnAdmin: adm.userSid.isCurrentBsnAdmin,
            totalFollowers: '',
            totalFollowing: '',
            totalLikes: ''),
        youtubeLink: adm.youtubeLink,
      ),
      getcurrentUser: widget.user,
    );
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
                          getData: crmModel, getcurrentUser: widget.user)));
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
