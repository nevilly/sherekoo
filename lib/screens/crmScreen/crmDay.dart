import 'package:flutter/material.dart';

import '../../model/user/user-call.dart';
import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/boxImg.dart';
import '../ourServices/sherekoCards.dart';
import '../uploadScreens/ceremonyUpload.dart';
import 'crmDoor.dart';

class CeremonyDay extends StatefulWidget {
  final String day;
  const CeremonyDay({Key? key, required this.day}) : super(key: key);

  @override
  State<CeremonyDay> createState() => _CeremonyDayState();
}

class _CeremonyDayState extends State<CeremonyDay>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();

  bool bottom = false;

  List<CeremonyModel> crm = [];
  List ourService = [
    'ceremony card',
    'Dressing Design',
    'Production',
    'Birthday Shows',
    'Dating Show'
  ];

  User currentUser = User(
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
  int page = 0, limit = 8, offset = 0;

  @override
  void initState() {
    // print("scrolling....");
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();

        getAllCeremony(offset: page, limit: limit);
      });
    });

    _controller.addListener(() {
      // print("scrolling....");
      if (!bottom &&
          _controller.hasClients &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        onPage(page);
      }
    });

    super.initState();
  }

  getUser() async {
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
  }

  onPage(int pag) {
    // print("Pages");

    // print(pag);

    if (mounted) {
      setState(() {
        // bottom = true;
        if (page > pag) {
          page--;
        } else {
          page++;
        }
        offset = page * limit;
      });
    }

    // print("Select * from table where data=all limit $offset,$limit");
    //page = pag;
    // print('post Length :');
    // print(crm.length);
    getAllCeremony(offset: offset, limit: limit);
    if (pag == crm.length - 1) {
      //offset = page;
      //print("Select * from posts order by id limit ${offset}, ${limit}");
    }
  }

  getAllCeremony({int? offset, int? limit}) {
    // String d = offset != null && limit != null ? "/$offset/$limit" : '';
    CrmCall(payload: [], status: 0)
        .getDayCeremony(token, urlCrmByDay, widget.day, offset, limit)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          // bottom = false;
          // print(value.payload);
          crm.addAll(value.payload
              .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
              .toList());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      body: ListView.builder(
        controller: _controller,
        itemCount: crm.length,
        itemBuilder: (BuildContext context, int index) {
          final itm = crm[index];

          double crmdpWdth = 30;
          double crmdphght = 30;
          double crmdpradius = 35;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              color: OColors.darGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: OColors.primary)),
                    child: Row(
                      children: [
                        // Ceremony Profile
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CrmDoor(
                                          crm: crm[index],
                                        )));
                          },
                          child: Stack(children: [
                            ClipRRect(
                              child: Center(
                                  child: itm.cImage != ''
                                      ? Img(
                                          avater: itm.cImage,
                                          url: '/ceremony/',
                                          username: itm.userFid.username!,
                                          width: 125,
                                          height: 125,
                                        )
                                      : const SizedBox(height: 1)),
                            ),

                            // Red TAGs ceremony Type
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 136, 64, 64),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0,
                                    left: 8.0,
                                    right: 10.0,
                                    bottom: 4.0),
                                child: Text(
                                  itm.ceremonyType,
                                  style: header12.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                        ),

                        //Details Ceremony
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CrmDoor(
                                                crm: itm,
                                              )));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                        color: OColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(105)),
                                    child: Text(
                                      'Code: ${itm.codeNo}',
                                      style: header10.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              const SizedBox(
                                height: 6,
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'On: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: OColors.fontColor,
                                        )),
                                    TextSpan(
                                        text: itm.ceremonyDate,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: OColors.fontColor,
                                        ))
                                  ]),
                                ),
                              ),

                              // Profile Details
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (itm.ceremonyType == 'Wedding')
                                      weddingProfileCrm(context, itm, crmdpWdth,
                                          crmdphght, crmdpradius),
                                    if (itm.ceremonyType == 'Kitchen Part')
                                      kichernPartProfileCrm(context, itm,
                                          crmdpWdth, crmdphght, crmdpradius),
                                    if (itm.ceremonyType == 'Birthday')
                                      birthdayProfileCrm(context, itm,
                                          crmdpWdth, crmdphght, crmdpradius),
                                    if (itm.ceremonyType == 'SendOff')
                                      sendProfileCrm(context, itm, crmdpWdth,
                                          crmdphght, crmdpradius),
                                    if (itm.ceremonyType == 'Kigodoro')
                                      kigodoroProfileCrm(context, itm,
                                          crmdpWdth, crmdphght, crmdpradius),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 6.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      // color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          cardFotter(
                                              Icon(
                                                Icons.group,
                                                size: 14,
                                                color: OColors.primary,
                                              ),
                                              itm.viwersNo),
                                          cardFotter(
                                              Icon(
                                                Icons.message,
                                                size: 12,
                                                color: OColors.primary,
                                              ),
                                              itm.chatNo),
                                          cardFotter(
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 12,
                                              ),
                                              itm.likeNo),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // print('Share function');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8,
                                            top: 4,
                                            bottom: 4),
                                        child: Icon(
                                          Icons.share,
                                          size: 13,
                                          color: OColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  itm.isCrmAdmin == 'true'
                      ? itm.isInFuture == 'true'
                          ? bookingPanel(itm, context, index)
                          : crmSettings(context, index)
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  GestureDetector crmSettings(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _buildPopupDialog(context, index);
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4),
        child: Icon(
          Icons.more_vert,
          size: 13,
          color: OColors.fontColor,
        ),
      ),
    );
  }

  Column bookingPanel(CeremonyModel itm, BuildContext context, int index) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Text('Booking Now',
                    style: header10.copyWith(fontStyle: FontStyle.italic)),
              ),
            ),
            const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SherekoCards(
                                    crm: CeremonyModel(
                                        cId: itm.cId,
                                        codeNo: itm.codeNo,
                                        ceremonyType: itm.ceremonyType,
                                        cName: itm.cName,
                                        fId: itm.fId,
                                        sId: itm.sId,
                                        cImage: itm.cImage,
                                        ceremonyDate: itm.ceremonyDate,
                                        contact: itm.contact,
                                        admin: itm.admin,
                                        userFid: itm.userFid,
                                        userSid: itm.userSid,
                                        youtubeLink: itm.youtubeLink,
                                        likeNo: '',
                                        chatNo: '',
                                        viwersNo: '',
                                        isCrmAdmin: itm.isCrmAdmin,
                                        isInFuture: itm.isInFuture),
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
                                        isCurrentUser: '',
                                        address: '',
                                        bio: '',
                                        meritalStatus: '',
                                        totalPost: '',
                                        isCurrentBsnAdmin: '',
                                        isCurrentCrmAdmin: '',
                                        totalFollowers: '',
                                        totalFollowing: '',
                                        totalLikes: ''),
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: OColors.primary),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 6),
                        child: Text(
                          'Order Cards',
                          style: header10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: OColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        'Design',
                        style: header10,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: OColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        'Production',
                        style: header10,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: OColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        'our Best Mc',
                        style: header10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _buildPopupDialog(context, index);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.more_vert,
                  size: 13,
                  color: OColors.fontColor,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Row cardFotter(Icon icon, String no) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        no != '0' && no.isNotEmpty
            ? Text(
                no,
                style: TextStyle(color: OColors.fontColor, fontSize: 12),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  void _buildPopupDialog(BuildContext context, index) {
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Editing Update',
                              style: header13,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CeremonyUpload(
                                            getData: crm[index],
                                            getcurrentUser: currentUser,
                                          )));
                            },
                          ),
                          ListTile(
                            title: Text('hide your ceremony', style: header13),
                            onTap: () {
                              // _preferences.logout();
                              // Navigator.of(context).pop();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => const LoginPage()));
                            },
                          ),
                          ListTile(
                            title:
                                Text('Only you see ceremony', style: header13),
                            onTap: () {
                              // _preferences.logout();
                              // Navigator.of(context).pop();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => const LoginPage()));
                            },
                          ),
                          ListTile(
                            title: Text('Delete ceremony', style: header13),
                            onTap: () {
                              // _preferences.logout();
                              // Navigator.of(context).pop();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => const LoginPage()));
                            },
                          ),
                        ],
                      ))));
        });
  }
}
