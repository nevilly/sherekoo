import 'package:flutter/material.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';
import '../../model/busness/busness-call.dart';
import '../../model/user/user-call.dart';
import '../../model/busness/bsn-call.dart';
import '../../model/busness/busnessMembers.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/busness/busnessPhotoModel.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/getAll.dart';
import '../../model/user/userModel.dart';
import '../../model/services/service-call.dart';
import '../../model/services/servicexModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/util.dart';
import '../../widgets/detailsWidg/BsnProfile.dart';
import '../../widgets/detailsWidg/bsnDescr.dart';
import '../../widgets/detailsWidg/busnessList.dart';
import '../../widgets/detailsWidg/ceremonyList.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../bsnScreen/bsn-admin.dart';
import '../bsnScreen/media-add.dart';
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
        // print(widget.data.isBsnAdmin);
        getUser(urlGetUser);
        getOther();
        getservices(widget.data.bId);
      });
    });

    ceremony = widget.ceremonyData;

    super.initState();
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

  deletePoto(i) {
    String lstStr = i.substring(47);
    BusnessCall(
      busnessType: widget.data.busnessType,
      knownAs: widget.data.knownAs,
      coProfile: widget.data.coProfile,
      price: widget.data.price,
      contact: widget.data.contact,
      location: widget.data.location,
      companyName: widget.data.companyName,
      ceoId: widget.data.ceoId,
      aboutCEO: widget.data.aboutCEO,
      aboutCompany: widget.data.aboutCompany,
      createdBy: widget.data.createdBy,
      hotStatus: '0',
      status: 0,
      payload: [],
      subscrlevel: '',
      bId: widget.data.bId,
    ).deletePhoto(token, urlDeletePhoto, lstStr, widget.data.work, i).then((v) {
      if (v.status == 200) {
        setState(() {
          widget.data.work = v.payload['work'];
          widget.data.works.removeWhere((element) => element == i);
        });

        alertMessage(v.payload['message']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('System Error, Try Again'),
        ));
      }
    });

    // print('---i--');
    // print(i);
    // String str = i;
    // String start = 'works/';
    // String end = '.jpg';

    // print(lstStr.endsWith('.jpg'));
    // final startIndex = str.indexOf(start);
    // final endIndex = str.indexOf(end, startIndex + start.length);

    // print(str.substring(startIndex + start.length, endIndex));
    // print('----Work to array');
    // print(widget.data.work.split(','));
    // var re = RegExp(r'(?<=")(.*)(?=")');
    // var match = re.firstMatch(widget.data.work)?.group(0);
    // print('---- Match');
    // print(match);

    // final splitted = widget.data.work.split(' ');
    // print(splitted.runtimeType);
    // splitted.forEach((element) {
    //   element.matchAsPrefix;
    //   print('---Elemten---');

    //   print(element);
    // });
    // splitted.removeWhere((element) {
    //   print(element.length);
    //   return element == lstStr;
    // });
    // print('--after Remove');
    // print(splitted);
  }

  alertMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

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
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.person_add,
                                size: 20,
                              ),
                            ),
                          )),
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
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share_rounded,
                            size: 16,
                          ),
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

                        // Works photoos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recient works',
                              style: header14,
                            ),
                            Row(
                              children: [
                                widget.data.isBsnAdmin == 'true'
                                    ? IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddBsnMediaUpload(
                                                        bsn: widget.data,
                                                        fromPage: 'bsnDetails',
                                                      )));
                                        },
                                        icon: Icon(Icons.add_a_photo),
                                        color: OColors.primary,
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  width: 4,
                                ),
                                IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    color: OColors.primary,
                                    iconSize: 20.0,
                                    onPressed: () {
                                      // otherCeremony(context);
                                    }),
                              ],
                            )
                          ],
                        ),
                        widget.data.work != ''
                            ? SizedBox(
                                child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.data.works.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemBuilder: (context, index) {
                                      final itm = widget.data.works[index];
                                      // print('work list');
                                      // print(itm);
                                      return Container(
                                        color: OColors.darGrey,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                                child: GestureDetector(
                                              onTap: () {
                                                prevPhotoDialog(
                                                    context, '${api}${itm}');
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: fadeImg(
                                                    context,
                                                    '${api}${itm}',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                    BoxFit.fill),
                                              ),
                                            )),
                                            widget.data.isBsnAdmin == 'true'
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showAlertDialog(
                                                            context,
                                                            'Delete',
                                                            'Are you sure?',
                                                            'bsnDetails',
                                                            itm);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ))
                                                : SizedBox.shrink()
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),

                ///
                /// Busness Description
                ///

                BsnDescr(data: widget.data, photo: photo),
              ])),
              BusnessLst(
                otherBsn: otherBsn,
                ceremony: ceremony,
                data: widget.data,
              ),
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
                color: OColors.primary),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Call me",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: OColors.fontColor),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(
      BuildContext context, String title, String msg, String from, i) async {
    // set up the buttons
    Widget noButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        // textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: Text("No", style: header13),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget yesButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: Text(
        "Yes ",
        style: header13,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        deletePoto(i);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      actions: [
        Column(
          children: [
            Center(
              child: Text(
                msg,
                style: header16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                noButton,
                yesButton,
              ],
            ),
            const SizedBox(
              height: 8,
            ),
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

  ///
  /// Preview Photos
  ///

  prevPhotoDialog(BuildContext context, photoUrl) async {
    double h = 50;
    double w = 50;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const SizedBox(),
      onPressed: () {
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ),
      ),
      content: StatefulBuilder(builder: (BuildContext context, setState) {
        return SizedBox(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1,
          child: FadeInImage(
            image: NetworkImage(photoUrl),
            fadeInDuration: const Duration(milliseconds: 100),
            placeholder: const AssetImage('assets/logo/noimage.png'),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/logo/noimage.png',
                  fit: BoxFit.fitWidth);
            },
            fit: BoxFit.cover,
          ),
        );
      }),
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

//Future Updating widgets
// -> feeds Tabs
// -> Busness members Tabs
