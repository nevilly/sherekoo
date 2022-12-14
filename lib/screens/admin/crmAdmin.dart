import 'package:flutter/material.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/model/requests/requestsModel.dart';
import 'package:sherekoo/model/subScription/subsrModel.dart';

import '../../model/requests/requests.dart';
import '../../model/services/service-call.dart';
import '../../model/services/servicexModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/colors.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/animetedClip.dart';
import '../bsnScreen/bsn-screen.dart';
import '../detailScreen/bsn-details.dart';
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
  List arr = ['Mc', 'cooker', 'singer', 'decorator'];

  // final Map myCategoryDynamic = {};
  //Selected host for Cereemony
  List<ServicexModel> myServ = [];

  RequestsModel rew = RequestsModel(
    hostId: '',
    busnessId: '',
    ceremonyId: '',
    createdDate: '',
    confirm: '',
    createdBy: '',
    isInService: '',
    svId: '',
    svPayStatus: '',
    svAmount: '',
    bsnInfo: BusnessModel(
      location: '',
      bId: '',
      knownAs: '',
      coProfile: '',
      busnessType: '',
      createdDate: '',
      companyName: '',
      ceoId: '',
      price: '',
      contact: '',
      hotStatus: '',
      aboutCEO: '',
      aboutCompany: '',
      createdBy: '',
      isBsnAdmin: '',
      subscriptionInfo: SubscriptionModel(
          subId: '',
          level: '',
          subscriptionType: '',
          categoryId: '',
          activeted: '',
          duration: '',
          startTime: '',
          endTime: '',
          receiptNo: '',
          createdDate: ''),
      user: User(
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
    ),
    crmInfo: CeremonyModel(
      cId: '',
      codeNo: '',
      ceremonyDate: '',
      cImage: '',
      cName: '',
      ceremonyType: '',
      contact: '',
      admin: '',
      fId: '',
      sId: '',
      youtubeLink: '',
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
    ),
  );

  // get crmInfo => CeremonyModel;

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

  getservices() async {
    ServicesCall(
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
              value.payload.map<ServicexModel>((e) => ServicexModel.fromJson(e)).toList();
        });
      }
    });
  }

  removeSelected(id) {
    ServicesCall(
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
          if (ob.bsnInfo!.busnessType == 'Mc') {
            mcReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          if (ob.bsnInfo!.busnessType == 'Production') {
            productionReq.removeWhere((element) => element.hostId == ob.hostId);
          }
          // Decorator
          if (ob.bsnInfo!.busnessType == 'Decorator') {
            decoratorReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          if (ob.bsnInfo!.busnessType == 'Decorator') {
            decoratorReq.removeWhere((element) => element.hostId == ob.hostId);
          }
          // Hall
          if (ob.bsnInfo!.busnessType == 'Hall') {
            hallReq.removeWhere((element) => element.hostId == ob.hostId);
          }
          //"Cake Bakery"
          if (ob.bsnInfo!.busnessType == 'Cake Bakery') {
            cakeReq.removeWhere((element) => element.hostId == ob.hostId);
          }
          //Singer
          if (ob.bsnInfo!.busnessType == 'Singer') {
            singerReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          //Dancer
          if (ob.bsnInfo!.busnessType == 'Dancer') {
            dancerReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          // Saloon
          if (ob.bsnInfo!.busnessType == 'Saloon') {
            saloonReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          //Car
          if (ob.bsnInfo!.busnessType == 'Car') {
            carReq.removeWhere((element) => element.hostId == ob.hostId);
          }

          //Cooker
          if (ob.bsnInfo!.busnessType == 'Cooker') {
            cookerReq.removeWhere((element) => element.hostId == ob.hostId);
          }
        });
      }
    });
  }

  // ignore: prefer_final_fields
  bool _openMc = false;
  bool _openProd = false;
  bool _openDec = false;
  bool _openHall = false;
  bool _openCake = false;
  bool _openSinger = false;
  bool _openDancer = false;
  bool _openSaloon = false;
  bool _openCar = false;
  bool _openCooker = false;

  List<RequestsModel> mcReq = [];
  List<RequestsModel> productionReq = [];
  List<RequestsModel> decoratorReq = [];
  List<RequestsModel> hallReq = [];
  List<RequestsModel> cakeReq = [];
  List<RequestsModel> singerReq = [];
  List<RequestsModel> dancerReq = [];
  List<RequestsModel> saloonReq = [];
  List<RequestsModel> carReq = [];
  List<RequestsModel> cookerReq = [];

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
      if (v.status == 200) {
        setState(() {
          //Mc
          mcReq = reqPayload(v, 'Mc').toList();
          mcReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Decoration
          decoratorReq = reqPayload(v, 'Decorator').toList();
          decoratorReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Production
          productionReq = reqPayload(v, 'Production').toList();
          productionReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Hall
          hallReq = reqPayload(v, 'Hall').toList();
          hallReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Cake Bakery
          cakeReq = reqPayload(v, 'Cake Bakery').toList();
          cakeReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Singer
          singerReq = reqPayload(v, 'Singer').toList();
          singerReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Danceer
          dancerReq = reqPayload(v, 'Dancer').toList();
          dancerReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Saloon
          saloonReq = reqPayload(v, 'Saloon').toList();
          saloonReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Car
          carReq = reqPayload(v, 'Car').toList();
          carReq.removeWhere((element) => element.busnessId!.isEmpty);

          //Cooker
          cookerReq = reqPayload(v, 'Cooker').toList();
          cookerReq.removeWhere((element) => element.busnessId!.isEmpty);
        });
      }
    });
  }

  reqPayload(Requests v, String type) {
    return v.payload.map<RequestsModel>((e) {
      if (e['bsnInfo']['busnessType'] == type &&
          e['busnessId'].toString().isNotEmpty) {
        return RequestsModel.fromJson(e);
      } else {
        return rew;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: Text(
          'Admin',
          style: appBarH,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                /// titleBar
                ///

                SizedBox(
                  // color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Selected Service', style: header18),
                  ),
                ),

                ///
                /// Selcete Busness..
                ///

                Container(
                  margin: const EdgeInsets.all(4.0),
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
                      final itm = myServ[i];
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
                                            'Delete ${itm.bsnInfo!.busnessType}',
                                            'Are SURE you want remove ${itm.bsnInfo!.busnessType}  ${itm.bsnInfo!.knownAs}..??',
                                            itm.bsnInfo!,
                                            'myServices');
                                      },
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        color: OColors.primary,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.network(
                                        '${api}public/uploads/${itm.bsnInfo!.user.username}/busness/${itm.bsnInfo!.coProfile}',
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
                              height: 3,
                            ),
                            Text(
                              '${itm.bsnInfo!.busnessType} ',
                              style: header13,
                            ),
                            Text(
                              '${itm.bsnInfo!.knownAs} ',
                              style: header12,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            itm.payed == '0'
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
                                          style: header10,
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

            /// Request Starts
            SizedBox(
              // color: OColors.darkGrey,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Your Requests', style: header18),
              ),
            ),

            requestBody(context, 'Mc', mcReq, _openMc),
            const SizedBox(height: 8),

            ///
            ///  Production Request

            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Production',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: OColors.fontColor)),
                        ),
                        productionReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${productionReq.length})',
                                    style: TextStyle(
                                        color: OColors.fontColor,
                                        fontSize: 13)),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openProd ^= true);
                            },
                            icon: _openProd == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
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
                              childAspectRatio: 0.6),
                      itemBuilder: (context, i) {
                        final req = productionReq[i];

                        return reqContainer(context, req);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///
            ///  Decooration Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Decoration',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        decoratorReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${decoratorReq.length})',
                                    style: header13),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openDec ^= true);
                            },
                            icon: _openDec == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openDec,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: decoratorReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: decoratorReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = decoratorReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child:
                              Text('$reqMsgInCrmdAdmin Decoration', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///
            ///  Hall Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Hall',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        hallReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${hallReq.length})',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              )
                            : Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 13),
                                  child: Text('Requests (0)',
                                      style: header13.copyWith(
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openHall ^= true);
                            },
                            icon: _openHall == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openHall,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: hallReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: hallReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = hallReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Hall', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///  Cake bakery Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Cake Bakery',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        cakeReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${cakeReq.length})',
                                    style: header13),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openCake ^= true);
                            },
                            icon: _openCake == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openCake,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: cakeReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cakeReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = cakeReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child:
                              Text('$reqMsgInCrmdAdmin Cake Bakery', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///  Singer Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Singer',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        singerReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${singerReq.length})',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openSinger ^= true);
                            },
                            icon: _openSinger == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openSinger,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: singerReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: singerReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = singerReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Singer', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///  Saloon Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Dancer',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        dancerReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${dancerReq.length})',
                                    style: header13),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openDancer ^= true);
                            },
                            icon: _openDancer == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openDancer,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: dancerReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dancerReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = dancerReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Dancer', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///  Saloon Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Saloon',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        saloonReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${saloonReq.length})',
                                    style: header13),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Requests (0)',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openSaloon ^= true);
                            },
                            icon: _openSaloon == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openSaloon,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: saloonReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: saloonReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = saloonReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Saloon', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///
            ///  Car Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Vehicles',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        carReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${carReq.length})',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              )
                            : Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 13),
                                  child: Text('Requests (0)',
                                      style: header13.copyWith(
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openCar ^= true);
                            },
                            icon: _openCar == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openCar,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: carReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: carReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = carReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Car', style: ef),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ///  Cooker Request
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 13),
                          child: Text('Cooker',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ),
                        cookerReq.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 13),
                                child: Text('Invited (${cookerReq.length})',
                                    style: header13.copyWith(
                                        fontWeight: FontWeight.normal)),
                              )
                            : Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 13),
                                  child: Text('Requests (0)',
                                      style: header13.copyWith(
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                        IconButton(
                            color: OColors.primary,
                            highlightColor: OColors.primary,
                            onPressed: () {
                              setState(() => _openCooker ^= true);
                            },
                            icon: _openCooker == false
                                ? Icon(Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openCooker,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: cookerReq.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cookerReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, i) {
                              final req = cookerReq[i];

                              return reqContainer(context, req);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                          child: Text('$reqMsgInCrmdAdmin Cooker', style: ef),
                        ),
                ),
              ],
            ),

            const SizedBox(
              height: 50,
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

  Container reqContainer(BuildContext context, RequestsModel req) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.2),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4.0, spreadRadius: 0.2, offset: Offset(0.1, 0.5)),
          ],
          color: OColors.darGrey),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => reqBsnDetaOnTap(req)));
            },
            child: Image.network(
              '${api}public/uploads/${req.bsnInfo!.user.username}/busness/${req.bsnInfo!.coProfile}',
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${req.bsnInfo!.price} Tsh',
            style: header13,
          ),
          req.bsnInfo!.knownAs.length >= 5
              ? Text(
                  '${req.bsnInfo!.knownAs.substring(0, 5).toUpperCase()}..',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: OColors.fontColor),
                )
              : Text(
                  req.bsnInfo!.knownAs,
                  style: header12,
                ),

          const SizedBox(
            height: 8,
          ),

          /// Bsn kama amekubali request kutoka kwa crm Admin
          req.confirm == '1'
              ? GestureDetector(
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
                        style: header10,
                      ),
                    ),
                  ),
                )
              :

              ///Bsn Confirmed, request send By  Crm Admin
              /// Then
              ///If Bsn SELECTED: to service table

              req.isInService == 'true'
                  ?

                  ///
                  /// Bsn SELECTED:

                  const Text('Selectedf', style: TextStyle(color: Colors.white))
                  :

                  /// isInService false:  Bsn not SELECTED:
                  ///
                  /// Bas Crm Admin anatakawa achague Huduma aipendayo

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
                              top: 4.0, bottom: 4.0, left: 8, right: 8),
                          child: Text(
                            'Choose',
                            style: TextStyle(
                                color: OColors.fontColor, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  /// Request Boddy
  Column requestBody(
      BuildContext context, String title, List<RequestsModel> arr, open) {
    return Column(
      children: <Widget>[
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
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: OColors.fontColor)),
                arr.isNotEmpty
                    ? Text('Invited (${arr.length})',
                        style: TextStyle(color: OColors.fontColor))
                    : const SizedBox(),
                IconButton(
                    color: OColors.primary,
                    highlightColor: OColors.primary,
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {
                      setState(() => _openMc ^= true);
                    },
                    icon: _openMc == false
                        ? Icon(Icons.keyboard_arrow_up_outlined,
                            color: OColors.fontColor)
                        : Icon(Icons.keyboard_arrow_down,
                            color: OColors.fontColor))
              ],
            ),
          ),
        ),
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
                return reqContainer(context, req);
              },
            ),
          ),
        ),
      ],
    );
  }

  BsnDetails reqBsnDetaOnTap(RequestsModel req) {
    return BsnDetails(
      ceremonyData: widget.crm,
      data: BusnessModel(
          location: req.bsnInfo!.location,
          bId: req.bsnInfo!.bId,
          knownAs: req.bsnInfo!.knownAs,
          coProfile: req.bsnInfo!.coProfile,
          busnessType: req.bsnInfo!.busnessType,
          companyName: req.bsnInfo!.companyName,
          ceoId: req.bsnInfo!.ceoId,
          price: req.bsnInfo!.price,
          contact: req.bsnInfo!.contact,
          hotStatus: req.bsnInfo!.hotStatus,
          aboutCEO: req.bsnInfo!.aboutCEO,
          aboutCompany: req.bsnInfo!.aboutCompany,
          createdBy: req.bsnInfo!.createdBy,
          subscriptionInfo: SubscriptionModel(
              subId: '',
              level: '',
              subscriptionType: '',
              categoryId: '',
              activeted: '',
              duration: '',
              startTime: '',
              endTime: '',
              receiptNo: '',
              createdDate: ''),
          isBsnAdmin: '',
          createdDate: req.bsnInfo!.createdDate,
          user: User(
              id: '',
              username: req.bsnInfo!.user.username,
              firstname: '',
              lastname: '',
              avater: req.bsnInfo!.user.avater,
              phoneNo: '',
              email: '',
              gender: '',
              role: '',
              isCurrentUser: '',
              address: '',
              bio: '',
              meritalStatus: '',
              totalPost: '',
              isCurrentBsnAdmin: '',
              isCurrentCrmAdmin: '',
              totalFollowers: '',
              totalFollowing: '',
              totalLikes: '')),
    );
  }

  void checkSelection(BuildContext context, RequestsModel req) {
    var contain = myServ
        .where(((element) => element.bsnInfo!.busnessType == req.bsnInfo!.busnessType));

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
          "You already have ${req.bsnInfo!.busnessType} ",
          "Would like to Select another ${req.bsnInfo!.busnessType}.. ?",
          req,
          'requests');
    }
  }

  Future<dynamic> showModel(BuildContext context, ServicexModel req) {
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
                            '${api}public/uploads/${req.bsnInfo!.user.username}/busness/${req.bsnInfo!.coProfile}',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Text(
                                  req.bsnInfo!.knownAs,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  req.bsnInfo!.price,
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



//  for (int i = 0; i < arr.length; i++) {
//       List myList = ['${arr[i]}Req'];

//       // print(myList);

//       myCategoryDynamic[myList] = [
//         {
//           'hostId': '',
//           'busnessId': '',
//           'ceremonyId': '',
//           'createdBy': '',
//           'contact': '',
//           'confirm': '',
//           'createdDate': '',
//           'coProfile': '',
//           'knownAs': '',
//           'price': '',
//           'bsncontact': '',
//           'busnessType': '',
//           'bsncreatedBy': '',
//           'bsnUsername': '',
//           'level': '',
//           'categoryId': '',
//           'activeted': ''
//         }
//       ];
//     }

   // myCategoryDynamic.map((key, value) {
    //   // print('valuee');
    //   // print(value);

    //   print('keyy');
    //   print(key);

    //   print('Encodevaluee');
    //   print(jsonEncode(value));
    //   final j = jsonEncode(value);

    //   return value;
    // });
    // // print('g tyeem');
    // // print(g);

          /// Proceed
          // for (int i = 0; i < arr.length; i++) {
          //   for (var key in myCategoryDynamic.keys) {
          //     String k = key.join();

          //     if (k.toString().startsWith(arr[i])) {
          //       print(myCategoryDynamic);
          //       // key.removeWhere((element) => element.busnessId.isEmpty);
          //       print('myCategoryDynamic');
          //       print(myCategoryDynamic);
          //     }
          //   }
          // }
