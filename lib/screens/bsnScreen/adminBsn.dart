import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/requests/requests.dart';
import '../../model/requests/requestsModel.dart';
import '../../model/services/postServices.dart';
import '../../model/services/svModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class AdminBsn extends StatefulWidget {
  final BusnessModel bsn;
  const AdminBsn({Key? key, required this.bsn}) : super(key: key);

  @override
  State<AdminBsn> createState() => _AdminBsnState();
}

class _AdminBsnState extends State<AdminBsn> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<RequestsModel> req = [];
  //Cereemony which Select You
  List<SvModel> myServ = [];

  late BusnessModel bsn;

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        bsn = widget.bsn;
        getservices(widget.bsn.bId);
        getBsnRequests(widget.bsn.bId);
      });
    });
  }

  getservices(bsnId) async {
    Services(
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
        // print(value.payload);
        setState(() {
          myServ =
              value.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: const Text('Admin'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ///
            /// Our Celemenies
            ///
            Column(
              children: [
                /// titleBar
                ///

                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
                    child: Center(
                      child: Text('Your Tender',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: OColors.fontColor)),
                    ),
                  ),
                ),

                ///
                /// Selcete Busness..
                ///
                ///
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
                                  childAspectRatio: 0.7),
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
                                                  'Delete ${my.busnessType}',
                                                  'Are SURE you want remove ${my.busnessType}  ${my.knownAs}..??',
                                                  my,
                                                  'myServices');
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
                                              '${api}public/uploads/${my.fIdUname}/ceremony/${my.cImage}',
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
                                    '${my.ceremonyType} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: OColors.fontColor),
                                  ),
                                  Text(
                                    '${my.ceremonyDate} ',
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
              ],
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
                padding: const EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
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

                                    req[i].activeted == '0'
                                        ? ClipRect(
                                            child: ImageFiltered(
                                              imageFilter: ImageFilter.blur(
                                                tileMode: TileMode.mirror,
                                                sigmaX: 7.0,
                                                sigmaY: 7.0,
                                              ),
                                              child: Image.network(
                                                '${api}public/uploads/${req[i].fIdUname}/ceremony/${req[i].cImage}',
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
                                            ),
                                          )
                                        : Image.network(
                                            '${api}public/uploads/${req[i].fIdUname}/ceremony/${req[i].cImage}',
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
                                  req[i].ceremonyType,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: OColors.fontColor),
                                ),
                                subtitle: req[i].activeted != '0'
                                    ? Text(
                                        req[i].createdDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: OColors.fontColor),
                                      )
                                    : const SizedBox(),

                                ///
                                ///Ceremony Date, Busness owner cant see
                                /// if subscription activeted is 0 (not paid)
                                ///

                                trailing: req[i].activeted != '0'
                                    ? Text(
                                        'Pay to View',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: OColors.primary),
                                      )
                                    : req[i].isInService == 'true'
                                        ? Text(
                                            'Slected',
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
                                                        color: OColors.primary),
                                                  )
                                                : Text(
                                                    'Ignore',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: OColors.primary),
                                                  ),
                                          )));
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                    child: Center(
                      child: Text('Empty',
                          style: TextStyle(
                              color: OColors.fontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
          ],
        ));
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
        if (from == 'requests') {
          Navigator.of(context).pop();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => MyService(
          //               req: req,
          //             )));
        } else {
          Navigator.of(context).pop();
          // removeSelected(req.svId);
        }
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
        Navigator.pop(context);
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
