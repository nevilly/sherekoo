import 'package:flutter/material.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';
import '../../model/allData.dart';
import '../../model/busness/bsn-call.dart';
import '../../model/busness/busnessMembers.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/busness/busnessPhotoModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/getAll.dart';
import '../../model/userModel.dart';
import '../../model/services/service-call.dart';
import '../../model/services/servicexModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import '../../util/util.dart';
import '../../widgets/detailsWidg/BsnProfile.dart';
import '../../widgets/detailsWidg/bsnDescr.dart';
import '../../widgets/detailsWidg/busnessList.dart';
import '../../widgets/detailsWidg/ceremonyList.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../bsnScreen/bsn-admin.dart';
import '../subscriptionScreen/hiringPage.dart';

class BsnDetails extends StatefulWidget {
  final BusnessModel data;
  final CeremonyModel ceremonyData;

  const BsnDetails({Key? key, required this.data, required this.ceremonyData})
      : super(key: key);

  @override
  _BsnDetailsState createState() => _BsnDetailsState();
}

class _BsnDetailsState extends State<BsnDetails> {
  late User user = User(
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
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

 
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

  List<ServicexModel> service = []; // Need To change to SvModel
  List<BusnessModel> info = [];
  List<BusnessModel> otherBsn = [];
  List<BusnessPhotoModel> photo = [];
  List<BusnessMembersModel> members = [];
  String getMemberResult = "";

  bool go = false;

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        // print('widget.data.coProfile');
        // print(widget.data.coProfile);
        getUser(urlGetUser);
        getOther();
        // getPhoto();
        // getMembers();
        // crmWorkWithBsn();
        // print('widget.data.bId');
        // print(widget.data.bId);
        getservices(widget.data.bId);
      });
    });

    ceremony = widget.ceremonyData;

    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  getOther() async {
    BsnCall(payload: [], status: 0)
        .onGoldenBusness(token, urlGoldBusness, widget.data.busnessType, '')
        .then((value) {
      setState(() {
        // print(value.payload);
        otherBsn = value.payload.map<BusnessModel>((e) {
          return BusnessModel.fromJson(e);
        }).toList();

        // print(data);
      });
    });
  }

  getPhoto() async {
    GetAll(
      payload: [],
      status: 0,
      id: widget.data.bId,
    ).get(token, urlBusnessPhoto).then((value) {
      // print('Get Photo view..');
      // print(value.payload);

      setState(() {
        photo = value.payload.map<BusnessPhotoModel>((e) {
          return BusnessPhotoModel.fromJson(e);
        }).toList();

        // print(data);
      });
    });
  }

  getMembers() async {
    GetAll(
      payload: [],
      status: 0,
      id: widget.data.bId,
    ).get(token, urlBusnessMembers).then((value) {
      // print('Get member view........................');
      // print(value.payload);

      if (value.payload != 'No content') {
        setState(() {
          go = true;
          members = value.payload.map<BusnessMembersModel>((e) {
            return BusnessMembersModel.fromJson(e);
          }).toList();

          // print(data);
        });
      } else {
        setState(() {
          go = false;
          getMemberResult = value.payload;
        });
      }
    });
  }

  //All Ceremony work With Busness

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
        // print(value.payload);
        setState(() {
          service = value.payload
              .map<ServicexModel>((e) => ServicexModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  // crmWorkWithBsn() async {
  //   GetAll(id: data.bId, status: 0, payload: [])
  //       .get(token, urlGetBsnToCrmRequests)
  //       .then((value) {
  //     if (value.status == 200) {
  //       setState(() {
  //         service = value.payload
  //             .map<ServicesModel>((e) => ServicesModel.fromJson(e))
  //             .toList();
  //       });
  //     }
  //   });
  // }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: const [
            Tab(
              text: 'OverView',
            ),
            Tab(
              text: 'Description',
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: OColors.secondary,
          appBar: AppBar(
            backgroundColor: OColors.secondary,
            title: widget.data.busnessType.length >= 6
                ? Text(
                    '${widget.data.busnessType.substring(0, 6)}..',
                    style: header16.copyWith(fontWeight: FontWeight.bold),
                  )
                : Text(widget.data.busnessType,
                    style: header16.copyWith(fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              const NotifyWidget(),
              widget.data.isBsnAdmin == 'true'
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdminBsn(
                                      bsn: widget.data,
                                    )));
                      },
                      child: Container(
                        // width: 30,
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: OColors.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.admin_panel_settings_sharp),
                        ),
                      ),
                    )
                  : Container(
                      // width: 30,
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10),
                      padding: const EdgeInsets.only(left: 6.0, right: 6),
                      decoration: BoxDecoration(
                        color: OColors.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.share_rounded,
                          size: 16,
                        ),
                      )),
            ],
          ),

          ///
          /// body
          ///
          body: Column(
            children: [
              ///
              ///  Bunsess Top Profile
              ///
              BusnessProfile(data: widget.data, widget: widget, user: user),

              const SizedBox(
                height: 10,
              ),

              ///
              /// Tabs
              ///

              PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.8))),
                  child: ColoredBox(
                    color: OColors.darGrey,
                    child: _tabBar,
                  ),
                ),
              ),

              ///
              /// Tabs Viewers Start
              ///
              Expanded(
                  child: TabBarView(children: [
                ///
                /// Busness Overviewrs  Container
                ///
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),

                        // Price
                        priceShow(context),

                        //Ceremony List;
                        CeremonyList(service: service),
                        // End List of Ceremony Container

                        const SizedBox(
                          height: 10,
                        ),

                        // other Busness List
                        BusnessLst(
                          otherBsn: otherBsn,
                          ceremony: ceremony,
                          data: widget.data,
                        ),
                        const SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),

                ///
                /// Busness Description
                ///

                BsnDescr(data: widget.data, photo: photo),
              ])),
            ],
          ),
        ));
  }

  // Pricing
  Padding priceShow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0, left: 8),
      child: Column(
        children: [
          Text(
            '${widget.data.price} Tsh',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: OColors.fontColor),
          ),
          Text(
            'Price/Negotiable',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
                color: OColors.primary2),
          ),
          const SizedBox(height: 5),

          //Hire Me Botton
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HiringPage(
                            busness: widget.data,
                            ceremony: widget.ceremonyData,
                            user: user,
                          )));
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: OColors.primary,
                border: Border.all(color: OColors.primary, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: Text(
                  "Hire Me ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: OColors.fontColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Future Updating widgets
// -> feeds Tabs
// -> Busness members Tabs
