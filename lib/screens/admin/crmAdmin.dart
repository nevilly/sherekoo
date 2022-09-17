import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/model/requests/requestsModel.dart';

import '../../model/requests/requests.dart';
import '../../model/services/postServices.dart';
import '../../model/services/svModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/animetedClip.dart';
import '../bsnScreen/bsnScrn.dart';
import 'payment.dart';

class CrmnAdmin extends StatefulWidget {
  final CeremonyModel crm;

  const CrmnAdmin({Key? key, required this.crm}) : super(key: key);

  @override
  State<CrmnAdmin> createState() => _CrmnAdminState();
}

class _CrmnAdminState extends State<CrmnAdmin> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<RequestsModel> mcReq = [];
  List<RequestsModel> productionReq = [];
  List<RequestsModel> decoratorReq = [];

  //Selected host for Cereemony
  List<SvModel> myServ = [];

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getservices();
        getAllRequests();
      });
    });
  }

  getAllRequests() async {
    Requests(
            hostId: '',
            busnessId: '',
            contact: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'ceremony')
        .getGoldenRequest(token, urlGetGoldReq, widget.crm.cId)
        .then((v) {
      // print('check the payload brother');

      if (v.status == 200) {
        // print(v.payload);

        setState(() {
          mcReq = v.payload.map<RequestsModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Mc') {
              // print(e);
              return RequestsModel.fromJson(e);
            }
            return RequestsModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          mcReq.removeWhere((element) => element.busnessId.isEmpty);

          //Production
          productionReq = v.payload.map<RequestsModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Production') {
              return RequestsModel.fromJson(e);
            }
            return RequestsModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          productionReq.removeWhere((element) => element.busnessId.isEmpty);

          //Decoration
          decoratorReq = v.payload.map<RequestsModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Decorator') {
              return RequestsModel.fromJson(e);
            }
            return RequestsModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          decoratorReq.removeWhere((element) => element.busnessId.isEmpty);
        });
      }
    });
  }

  getservices() async {
    Services(
            svId: '',
            busnessId: '',
            hId: '',
            payed: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'ceremony')
        .getService(token, urlGetGoldService, widget.crm.cId)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          myServ =
              value.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
        });
      }
    });
  }

  removeSelected(id) {
    Services(
            svId: id,
            busnessId: '',
            hId: '',
            payed: '',
            ceremonyId: widget.crm.cId,
            createdBy: '',
            status: 0,
            payload: [],
            type: 'ceremony')
        .removeService(token, urlRemoveServiceById)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          myServ.removeWhere((element) => element.svId == id);
        });
      }
    });
  }

  cancelRequest(RequestsModel ob) {
    Requests(
        hostId: ob.hostId,
        busnessId: '',
        contact: '',
        ceremonyId: '',
        createdBy: '',
        type: '',
        status: 0,
        payload: []).cancelRequest(token, urlCancelRequest).then((value) {
      if (value.status == 200) {
        setState(() {
          if (ob.busnessType == 'Mc') {
            mcReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          if (ob.busnessType == 'Production') {
            productionReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          if (ob.busnessType == 'Decorator') {
            decoratorReq.removeWhere((element) => element.hostId == ob.hostId);
          }
        });
      }
    });
  }

  bool _openMc = false;
  bool _openProd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: const Text('Invitation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///
            /// Selected Busness for ceremont
            ///
            /// Colum

            Column(
              children: [
                /// titleBar
                ///

                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Selected Host',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: OColors.fontColor)),
                      ],
                    ),
                  ),
                ),

                ///
                /// Selcete Busness..
                ///
                ///
                Container(
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
                                        '${api}public/uploads/${my.bsnUsername}/busness/${my.coProfile}',
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
                            Text(
                              '${my.busnessType} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: OColors.fontColor),
                            ),
                            Text(
                              '${my.knownAs} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: OColors.fontColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            my.payed == '0'
                                ? Padding(
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
                                : GestureDetector(
                                    onTap: () {
                                      // showModel(context, req);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //             MyService(
                                      //               req: my,
                                      //             )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: OColors.primary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0,
                                            bottom: 4.0,
                                            left: 8,
                                            right: 8),
                                        child: Text(
                                          'Pay Hime..',
                                          style: TextStyle(
                                              color: OColors.fontColor,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            ///
            /// All  Requst or Invitation
            /// Start Here
            ///
            /// Requst function
            /// All Mc Invitaion
            ///
            requestBody(context, 'Mc', mcReq),

            const SizedBox(height: 8),

            ///
            ///  Production Request

            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Production',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: OColors.fontColor)),
                        IconButton(
                            color: OColors.fontColor,
                            highlightColor: OColors.primary,
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() => _openProd ^= true);
                            },
                            icon: _openProd == false
                                ? Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor,
                                  )
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openProd,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productionReq.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.7),
                      itemBuilder: (context, i) {
                        final req = productionReq[i];
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
                              Image.network(
                                '${api}public/uploads/${req.bsnUsername}/busness/${req.coProfile}',
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${req.price} Tsh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: OColors.fontColor),
                              ),
                              Text(
                                '${req.knownAs} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: OColors.fontColor),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.primary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //footer
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BusnessScreen(
                        bsnType: 'all',
                        ceremony: widget.crm,
                      )));
        },
        // splashColor: Colors.yellow,

        // icon: const Icon(Icons.upload, color: Colors.white),
        label: const Text('invite'),

        backgroundColor: OColors.primary,
      ),
    );
  }

  Column requestBody(
      BuildContext context, String title, List<RequestsModel> arr) {
    return Column(
      children: <Widget>[
        ///
        /// Request/invitation Busness title
        ///

        Container(
          color: OColors.darkGrey,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: OColors.fontColor)),
                arr.isNotEmpty
                    ? Text('Invited (${arr.length})',
                        style: TextStyle(color: OColors.fontColor))
                    : const SizedBox(),
                IconButton(
                    color: OColors.fontColor,
                    highlightColor: OColors.primary,
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {
                      setState(() => _openMc ^= true);
                    },
                    icon: _openMc == false
                        ? Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: OColors.fontColor,
                          )
                        : Icon(Icons.keyboard_arrow_down,
                            color: OColors.fontColor))
              ],
            ),
          ),
        ),

        ///
        /// Animation container
        /// open and close by slide up and down
        ///
        /// used for desplay all Busness request Or ceremony invitation
        AnimatedClipRect(
          open: _openMc,
          horizontalAnimation: false,
          verticalAnimation: true,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn,
          child: Container(
            margin: const EdgeInsets.all(6.0),
            child:

                ///
                /// Grid View for Busness Invitation
                ///

                GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: arr.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.6),
              itemBuilder: (context, i) {
                final req = arr[i];

                ///
                ///
                /// Busness Container
                ///
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
                      Image.network(
                        '${api}public/uploads/${req.bsnUsername}/busness/${req.coProfile}',
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${req.price} Tsh',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: OColors.fontColor),
                      ),
                      Text(
                        '${req.knownAs} ',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: OColors.fontColor),
                      ),
                      const SizedBox(
                        height: 6,
                      ),

                      /// Bsn kama amekubali request kutoka kwa crm Admin
                      req.confirm == '1'
                          ?

                          ///
                          ///Bsn not Confirmed Request from Crmn Admin
                          ///Crmn Admin can Cancel Request
                          ///
                          GestureDetector(
                              onTap: () {
                                cancelRequest(req);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: OColors.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4.0, left: 8, right: 8),
                                  child: Text(
                                    'Cancel Req..',
                                    style: TextStyle(
                                        color: OColors.fontColor, fontSize: 10),
                                  ),
                                ),
                              ),
                            )
                          :

                          ///
                          ///Bsn Confirmed, request send By  Crm Admin
                          /// Then
                          ///If Bsn SELECTED: to service table
                          ///
                          req.isInService == 'true'
                              ?

                              ///
                              /// Bsn SELECTED:
                              ///
                              ///

                              const Text('Selectedf',
                                  style: TextStyle(color: Colors.white))
                              :

                              /// isInService false:  Bsn not SELECTED:
                              ///
                              /// Bas Crm Admin anatakawa achague Huduma aipendayo
                              ///
                              GestureDetector(
                                  onTap: () {
                                    checkSelection(context, req);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: OColors.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0,
                                          bottom: 4.0,
                                          left: 8,
                                          right: 8),
                                      child: Text(
                                        'Choose',
                                        style: TextStyle(
                                            color: OColors.fontColor,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),
                      req.confirm == '0'
                          ? Text(
                              'Wait..',
                              style: TextStyle(
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold,
                                  color: OColors.primary),
                            )
                          : Text(
                              'Select',
                              style: TextStyle(

                                  // fontWeight: FontWeight.bold,
                                  color: OColors.primary),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void checkSelection(BuildContext context, RequestsModel req) {
    var contain =
        myServ.where(((element) => element.busnessType == req.busnessType));

    if (contain.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MyService(
                    req: req,
                  )));
    } else {
      showAlertDialog(
          context,
          "You already have ${req.busnessType} ",
          "Would like to Select another ${req.busnessType}.. ?",
          req,
          'requests');
    }
  }

  Future<dynamic> showModel(BuildContext context, SvModel req) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            // color: OColors.secondary,
            height: 600,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    // color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 18.0),
                          child: Column(
                            children: [
                              Text('My Wallet',
                                  style: TextStyle(color: OColors.fontColor)),
                              Text('2,000,000 Tsh',
                                  style: TextStyle(
                                      color: OColors.fontColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        req.ceremonyId,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),

                    // Busness Profile
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 10, bottom: 8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(
                            '${api}public/uploads/${req.bsnUsername}/busness/${req.coProfile}',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Text(
                                  req.knownAs,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  req.price,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ),

                    const Spacer(),
                    // footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // getservices(
                            //     req.busnessId, req.ceremonyId, req.hostId, '0');
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: OColors.primary),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Select',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: OColors.primary),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )),
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
        if (from == 'requests') {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MyService(
                        req: req,
                      )));
        } else {
          Navigator.of(context).pop();
          removeSelected(req.svId);
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
