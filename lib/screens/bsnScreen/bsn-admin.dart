import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/user/user-call.dart';
import '../../model/busness/bsn-call.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/requests/requests.dart';
import '../../model/requests/requestsModel.dart';
import '../../model/services/service-call.dart';
import '../../model/services/servicexModel.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../categoriesPage/sherekooPage.dart';
import '../profile/crm-admin.dart';
import '../subscriptionScreen/update-subscription.dart';
import '../uploadScreens/busnessUpload.dart';
import 'media-add.dart';

class AdminBsn extends StatefulWidget {
  final BusnessModel bsn;
  const AdminBsn({Key? key, required this.bsn}) : super(key: key);

  @override
  State<AdminBsn> createState() => _AdminBsnState();
}

class _AdminBsnState extends State<AdminBsn> {
  List<RequestsModel> req = [];
  //Cereemony which Select You
  List<ServicexModel> myServ = [];
  User user = User(
      id: '',
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
      whatYouDo: '',
      followInfo: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      currentFllwId: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  @override
  void initState() {
    super.initState();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;

        getservices(widget.bsn.bId);
        getBsnRequests(widget.bsn.bId);
        getUser(urlGetUser);
      });
    });
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

  getservices(bsnId) async {
    ServicesCall(
            svId: '',
            busnessId: '',
            hId: '',
            payed: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'busness')
        .getService(token, urlGetGoldService, bsnId)
        .then((value) {
      if (value.status == 200) {
        // print('services data');
        // print(value.payload);
        setState(() {
          myServ = value.payload
              .map<ServicexModel>((e) => ServicexModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  ///
  ///Send bsn Id to Api
  ///
  getBsnRequests(bsnId) async {
    Requests(
            hostId: '',
            busnessId: '',
            contact: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'busness')
        .getGoldenRequest(token, urlGetGoldReq, bsnId)
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

  ecceptIgnoreRequest(reqId) {
    final firstWhere = req.firstWhere((item) => item.hostId == reqId);
    Requests(
        hostId: reqId,
        busnessId: '',
        contact: '',
        ceremonyId: '',
        createdBy: '',
        type: '',
        status: 0,
        payload: []).updateRequest(token, urlUpdatelRequest).then((value) {
      if (value.status == 200) {
        setState(() {
          if (value.payload == '1') {
            // Accept
            var target = firstWhere;
            target.confirm = '2';
          } else {
            // Ignore
            var target = firstWhere;
            target.confirm = '1';
          }
        });
      }
    });
  }

  deleteBsn() async {
    BsnCall(payload: [], status: 0)
        .deleteBsn(token, urlBusnessRemove, widget.bsn.bId)
        .then((value) {
      setState(() {
        if (value.status == 200) {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Sherekoo()));
        }
        // print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: Text(
            widget.bsn.knownAs,
            style: header18,
          ),
          centerTitle: true,
          actions: [
            const NotifyWidget(),
            GestureDetector(
              onTap: () {
                bsnsettings();
              },
              child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.settings,
                    color: prmry,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: ClipRRect(
                          child: fadeImg(
                              context,
                              '${api}${widget.bsn.mediaUrl}',
                              150,
                              100,
                              BoxFit.fitWidth)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 1.0,
                        bottom: 8.0,
                        left: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(widget.bsn.busnessType,
                                style: header15.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 2),
                            child: Text(
                              widget.bsn.companyName,
                              style: header13,
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AddBsnMediaUpload(
                                                  bsn: widget.bsn)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: prmry,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: fntClr,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Add photos',
                                        style: header11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BusnessUpload(
                                                getData: widget.bsn,
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: prmry,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: fntClr,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Edit',
                                        style: header11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                ///
                /// Our Celemenies
                ///

                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                    child: Center(
                      child: Text('Your Tender', style: header15),
                    ),
                  ),
                ),

                myServ.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.all(6.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: myServ.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  childAspectRatio: 0.6),
                          itemBuilder: (context, i) {
                            final my = myServ[i];
                            return Container(
                              margin: const EdgeInsets.only(top: 2, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 0.2),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 4.0,
                                        spreadRadius: 0.2,
                                        offset: Offset(0.1, 0.5)),
                                  ],
                                  color: OColors.darGrey),
                              child: Column(
                                children: [
                                  ///
                                  /// ceremony Avater
                                  ///

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    // color: Colors.red,
                                    child: Stack(children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              showAlertDialog(
                                                  context,
                                                  'Delete ${my.bsnInfo!.busnessType}',
                                                  'Are SURE you want remove ${my.bsnInfo!.busnessType}  ${my.bsnInfo!.knownAs}..??',
                                                  my,
                                                  'myServices');
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(
                                              Icons.cancel_rounded,
                                              color: OColors.primary,
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: ClipOval(
                                            child: Image.network(
                                              '${api}public/uploads/${my.crmInfo!.userFid.username}/ceremony/${my.crmInfo!.cImage}',
                                              height: 55,
                                              width: 55,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  ///
                                  /// Ceremony info
                                  ///

                                  Text(
                                    '${my.crmInfo!.ceremonyType} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: OColors.fontColor),
                                  ),
                                  Text(
                                    '${my.crmInfo!.ceremonyDate} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        color: OColors.fontColor),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0,
                                        bottom: 4.0,
                                        left: 8,
                                        right: 8),
                                    child: Text(
                                      'Selected..',
                                      style: TextStyle(
                                          color: OColors.primary, fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                        child: Center(
                          child: Text('You dont Have Work',
                              style: TextStyle(
                                  color: OColors.fontColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),

                const SizedBox(
                  height: 15,
                ),

                /// titleBar
                ///

                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sherekoo Requests',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: OColors.fontColor)),
                      ],
                    ),
                  ),
                ),

                //

                ///
                /// Busness Requests List
                ///
                req.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          itemCount: req.length,
                          itemBuilder: (context, i) {
                            final itm = req[i];
                            return Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: ListTile(
                                    tileColor: OColors.darGrey,
                                    horizontalTitleGap: 8,
                                    leading:

                                        /// Ceremony Profile Picture
                                        ///
                                        /// if Busness owner not pay subuscription fee
                                        /// cant see the ceremony Request

                                        itm.bsnInfo!.subscriptionInfo!
                                                    .activeted ==
                                                '0'
                                            ? ClipRect(
                                                child: ImageFiltered(
                                                  imageFilter: ImageFilter.blur(
                                                    tileMode: TileMode.mirror,
                                                    sigmaX: 7.0,
                                                    sigmaY: 7.0,
                                                  ),
                                                  child: Image.network(
                                                    '${api}public/uploads/${itm.crmInfo!.userFid.username}/ceremony/${itm.crmInfo!.cImage}',
                                                    height: 70,
                                                    width: 65,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
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
                                                '${api}public/uploads/${itm.crmInfo!.userFid.username}/ceremony/${itm.crmInfo!.cImage}',
                                                height: 70,
                                                width: 65,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
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

                                    ///
                                    /// Ceremony Type
                                    ///
                                    title: Text(
                                      itm.crmInfo!.ceremonyType,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: OColors.fontColor),
                                    ),
                                    subtitle: itm.bsnInfo!.subscriptionInfo!
                                                .activeted !=
                                            '0'
                                        ? Text(
                                            itm.createdDate!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: OColors.fontColor),
                                          )
                                        : const SizedBox.shrink(),

                                    ///
                                    ///Ceremony Date, Busness owner cant see
                                    /// if subscription activeted is 0 (not paid)
                                    ///

                                    trailing: widget.bsn.subscriptionInfo!
                                                .activeted ==
                                            '0'
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          UpdateSubscription(
                                                            subscription: widget
                                                                .bsn
                                                                .subscriptionInfo!,
                                                            bsn: widget.bsn,
                                                            from: 'bsnAdmin2',
                                                          )));
                                            },
                                            child: Text(
                                              'View',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: OColors.primary),
                                            ),
                                          )
                                        : req[i].isInService == 'true'
                                            ? Text(
                                                'Selected',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: OColors.primary),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  ecceptIgnoreRequest(
                                                      req[i].hostId);
                                                },
                                                child: req[i].confirm == '1'
                                                    ? Text(
                                                        'Accept',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: OColors
                                                                .primary),
                                                      )
                                                    : Text(
                                                        'Ignore',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: OColors
                                                                .primary),
                                                      ),
                                              )));
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                        child: Center(
                          child: Text('Empty',
                              style: header15.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ),
                      ),

                SizedBox(height: 10)
              ],
            ),
          ),
        ));
  }

  void bsnsettings() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 250,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BusnessUpload(
                                              getData: widget.bsn,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: OColors.whiteFade,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Edit your Busness', style: header14),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             const BigMonthRegistered()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: OColors.whiteFade,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Upload new features/photo',
                                        style: header14),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             const BigMonthRegistered()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      color: OColors.whiteFade,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Add / remove Members',
                                        style: header14),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UpdateSubscription(
                                              subscription:
                                                  widget.bsn.subscriptionInfo!,
                                              bsn: widget.bsn,
                                              from: 'bsnAdmin2',
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.wallet,
                                      color: OColors.whiteFade,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Payment', style: header14),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                showAlertDialog(
                                    context,
                                    'Delete..!!',
                                    'Are sure you want to Delete ${widget.bsn.busnessType}  ${widget.bsn.knownAs} Account.. ?',
                                    widget.bsn,
                                    'deleteAccount');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: OColors.danger,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Delete your  Busness',
                                        style: header14.copyWith(
                                            color: OColors.danger)),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))),
          );
        });
  }

  // Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("yes",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        if (from == 'deleteAccount') {
          deleteBsn();
        }
        if (from == 'requests') {
          Navigator.of(context).pop();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => MyService(
          //               req: req,
          //             )));
        }
        Navigator.of(context).pop();
        // removeSelected(req.svId);
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: const Text("NO"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      content: Text(msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: OColors.fontColor)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
