import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../model/allData.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../model/userModel.dart';
import '../model/services/postServices.dart';
import '../model/services/svModel.dart';
import '../util/Preferences.dart';
import '../util/colors.dart';
import '../util/func.dart';
import '../util/util.dart';
import 'imgWigdets/defaultAvater.dart';
import 'imgWigdets/userAvater.dart';

class TabB extends StatefulWidget {
  final CeremonyModel ceremony;

  final User user;
  const TabB({
    Key? key,
    required this.ceremony,
    required this.user,
  }) : super(key: key);

  @override
  State<TabB> createState() => _TabBState();
}

class _TabBState extends State<TabB> {
  final Preferences _preferences = Preferences();
  String token = '';

  TextEditingController phoneNo = TextEditingController();
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

  List<SvModel> bsnInfo = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // print('ceremony id');
        // print(widget.ceremony.u1Avt);

        getUser();
        getservices();
        getHashTagPhoto();
      });
    });

    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
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
        .getService(token, urlGetGoldService, widget.ceremony.cId)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          bsnInfo =
              value.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
        });
      }
    });
  }

  List<SherekooModel> tagHome = [];
  List<SherekooModel> tagChurch = [];
  List<SherekooModel> tagWedding = [];
  List<SherekooModel> tagBeach = [];

  getHashTagPhoto() async {
    Post(
      payload: [],
      status: 0,
      pId: '',
      avater: '',
      body: '',
      ceremonyId: widget.ceremony.cId,
      createdBy: '',
      username: '',
      vedeo: '',
      hashTag: '',
    ).getPostByCeremonyId(token, urlGetSherekooByCeremonyId).then((value) {
      if (value.status == 200) {
        setState(() {
          tagHome = tagFanc(value, 'Home').toList();
          tagHome.removeWhere((element) => element.hashTag.isEmpty);

          tagChurch = tagFanc(value, 'Church').toList();
          tagChurch.removeWhere((element) => element.hashTag.isEmpty);

          tagBeach = tagFanc(value, 'Beach').toList();
          tagBeach.removeWhere((element) => element.hashTag.isEmpty);

          tagWedding = tagFanc(value, 'Wedding').toList();
          tagWedding.removeWhere((element) => element.hashTag.isEmpty);
        });
      }
    });
  }

  tagFanc(Post value, String typ) {
    return value.payload.map<SherekooModel>((e) {
      if (e['hashTag'] == typ) {
        return SherekooModel.fromJson(e);
      }
      return SherekooModel.fromJson({
        'pId': '',
        'createdBy': '',
        'body': '',
        'vedeo': '',
        'userId': '',
        'username': '',
        'avater': '',
        'createdDate': '',
        'commentNumber': '',
        'ceremonyId': '',
        'cImage': '',
        'crmUsername': '',
        'crmFid': '',
        'crmYoutubeLink': '',
        'totalLikes': '',
        'isLike': '',
        'totalShare': '',
        'hashTag': '',
        'crmViewer': ''
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 1),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  if (widget.ceremony.ceremonyType == 'Wedding')
                    weddingProfile(context),
                  if (widget.ceremony.ceremonyType == 'Birthday')
                    birthdayProfile(context),
                  if (widget.ceremony.ceremonyType == 'kigodoro')
                    kigodoroProfile(context),
                  if (widget.ceremony.ceremonyType == 'Kitchen Part')
                    kichernPartProfile(context),
                  if (widget.ceremony.ceremonyType == 'SendOff')
                    sendProfile(context),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    outlilneButton(
                        Icon(
                          Icons.group,
                          size: 16,
                          color: OColors.primary,
                        ),
                        Text(
                          'Viewers',
                          style: header12.copyWith(color: OColors.primary),
                        ),
                        MediaQuery.of(context).size.width / 2.5, // borderRadius
                        OColors.primary,
                        16),
                    GestureDetector(
                      onTap: () {
                        oneButtonPressed(context);
                      },
                      child: outlilneButton(
                          Icon(
                            Icons.group,
                            size: 16,
                            color: OColors.primary,
                          ),
                          Text(
                            'Commetee',
                            style: header12.copyWith(color: OColors.primary),
                          ),
                          MediaQuery.of(context).size.width / 2.5,
                          OColors.primary,
                          16),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 8,
              child: Divider(
                height: 1.0,
                color: OColors.darkGrey,
                thickness: 1.0,
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            //hashTag Circle
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ceremony Hosts',
                    style: header15.copyWith(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    ' our Ceremony',
                    style: header10,
                  ),
                ],
              ),
            ),

            GridView.builder(
              padding: const EdgeInsets.all(0.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.8),
              itemCount: bsnInfo.length,
              itemBuilder: (context, i) {
                return Container(
                    decoration: BoxDecoration(
                      color: OColors.darGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        bsnInfo[i].payed == '0'
                            ? ClipRect(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    tileMode: TileMode.mirror,
                                    sigmaX: 7.0,
                                    sigmaY: 7.0,
                                  ),
                                  child: Image.network(
                                    '${api}public/uploads/${bsnInfo[i].bsnUsername}/busness/${bsnInfo[i].coProfile}',
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                '${api}public/uploads/${bsnInfo[i].bsnUsername}/busness/${bsnInfo[i].coProfile}',
                                height: MediaQuery.of(context).size.height / 9,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                        Text(
                          bsnInfo[i].busnessType,
                          style: ef,
                        ),
                        bsnInfo[i].payed != '0'
                            ? Text(
                                bsnInfo[i].knownAs,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: OColors.fontColor),
                              )
                            : const SizedBox(),
                        bsnInfo[i].payed == '0'
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    if (currentUser.id == widget.ceremony.fId ||
                                        currentUser.id == widget.ceremony.sId ||
                                        currentUser.id == widget.ceremony.admin)
                                      GestureDetector(
                                        onTap: () {
                                          //                            Navigator.push(
                                          // context,
                                          // MaterialPageRoute(
                                          //     builder: (BuildContext context) => MyService(
                                          //           req: req,
                                          //         )));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            'Pay',
                                            style: bttnfontprimary,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Confirm',
                                  style: bttnfontprimary,
                                ),
                              ),
                      ],
                    ));
              },
            ),

            const SizedBox(height: 35),
            tagHome.isNotEmpty
                ? tagContainer('Home', 'At home', tagHome)
                : const SizedBox.shrink(),

            tagBeach.isNotEmpty
                ? tagContainer('Beach', 'At Beach', tagBeach)
                : const SizedBox.shrink(),

            tagChurch.isNotEmpty
                ? tagContainer('Church', 'At church', tagChurch)
                : const SizedBox.shrink(),

            tagWedding.isNotEmpty
                ? tagContainer('Wedding', 'At wedding', tagWedding)
                : const SizedBox.shrink(),

            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Column weddingProfile(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.ceremony.userFid.gender == 'male' && widget.ceremony.userFid.avater.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: UserAvater(
                        avater: widget.ceremony.userFid.avater,
                        url: '/profile/',
                        username: widget.ceremony.userFid.username,
                        height: 80,
                        width: 80),
                  )
                : const DefaultAvater(height: 80, radius: 20, width: 80),
            widget.ceremony.userSid.gender == 'female' && widget.ceremony.userSid.avater.isNotEmpty
                ? ClipRRect(
                    child: UserAvater(
                        avater: widget.ceremony.userSid.avater,
                        url: '/profile/',
                        username: widget.ceremony.userSid.username,
                        height: 80,
                        width: 80),
                  )
                : const ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: DefaultAvater(height: 80, radius: 20, width: 80)),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          child: Column(
            children: [
              Text(
                'Mr&Mrs  ${widget.ceremony.cName}',
                style: header14.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                widget.ceremony.ceremonyType,
                style: header13.copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.ceremony.ceremonyDate,
                style: header12.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }

  Row kichernPartProfile(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child:
              widget.ceremony.userFid.gender== 'male' && widget.ceremony.userFid.avater.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: UserAvater(
                          avater: widget.ceremony.userFid.avater,
                          url: '/profile/',
                          username: widget.ceremony.userFid.username,
                          height: 35,
                          width: 35),
                    )
                  : const DefaultAvater(height: 35, radius: 15, width: 35),
        ),
        Expanded(
          flex: 1,
          child: widget.ceremony.userSid.gender == 'female' &&
                  widget.ceremony.userSid.avater.isNotEmpty
              ? ClipRRect(
                  child: UserAvater(
                      avater: widget.ceremony.userSid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userSid.username,
                      height: 35,
                      width: 35),
                )
              : const DefaultAvater(height: 35, radius: 15, width: 35),
        )
      ],
    );
  }

  Row sendProfile(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child:
              widget.ceremony.userFid.gender == 'male' && widget.ceremony.userFid.avater.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: UserAvater(
                          avater: widget.ceremony.userFid.avater,
                          url: '/profile/',
                          username: widget.ceremony.userFid.username,
                          height: 35,
                          width: 35),
                    )
                  : const DefaultAvater(height: 35, radius: 15, width: 35),
        ),
        Expanded(
          flex: 1,
          child: widget.ceremony.userSid.gender== 'female' &&
                  widget.ceremony.userSid.avater.isNotEmpty
              ? ClipRRect(
                  child: UserAvater(
                      avater: widget.ceremony.userSid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userSid.username,
                      height: 35,
                      width: 35),
                )
              : const DefaultAvater(height: 35, radius: 15, width: 35),
        )
      ],
    );
  }

  Row birthdayProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          child: UserAvater(
              avater: widget.ceremony.cImage,
              url: '/ceremony/',
              username: widget.ceremony.userFid.username,
              height: 100,
              width: 90),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.8,
          height: 80,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.ceremony.ceremonyType,
                style: header18.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                widget.ceremony.userFid.username,
                style: header14,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.ceremony.ceremonyDate,
                style: header10.copyWith(color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row kigodoroProfile(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: UserAvater(
                    avater: widget.ceremony.cImage,
                    url: '/ceremony/',
                    username: widget.ceremony.userFid.username,
                    height: 100,
                    width: 90),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                height: 80,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ceremony.ceremonyType,
                      style: header18.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.ceremony.userFid.username,
                      style: header14,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.ceremony.ceremonyDate,
                      style: header10.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Column tagContainer(String title, String subtitle, List<SherekooModel> tg) {
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  hashTagCircle(),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: header13.copyWith(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        subtitle,
                        style: header10,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '${tg.length} photo',
                    style: header12.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: OColors.primary,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        GridView.builder(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 6, childAspectRatio: 0.8),
          itemCount: tg.length,
          itemBuilder: (context, i) {
            final tag = tg[i];
            return Container(
                decoration: BoxDecoration(
                  color: OColors.darGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned.fill(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Image.network(
                              '${api}public/uploads/${tag.username}/posts/${tag.vedeo}',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Image.network(
                          '${api}public/uploads/${tag.username}/posts/${tag.vedeo}',
                          fit: BoxFit.contain,
                        )
                      ],
                    )));
          },
        ),
      ],
    );
  }
}
