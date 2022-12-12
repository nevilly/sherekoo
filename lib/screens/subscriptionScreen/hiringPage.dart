import 'package:flutter/material.dart';
import 'package:sherekoo/model/requests/requests.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/allData.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/gradientBorder.dart';
import '../../widgets/imgWigdets/boxImg.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../admin/crmAdmin.dart';
import '../uploadScreens/ceremonyUpload.dart';

class HiringPage extends StatefulWidget {
  final BusnessModel busness;
  final CeremonyModel ceremony;
  final User user;
  const HiringPage(
      {Key? key,
      required this.user,
      required this.busness,
      required this.ceremony})
      : super(key: key);

  @override
  State<HiringPage> createState() => _HiringPageState();
}

class _HiringPageState extends State<HiringPage> {
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
      meritalStatus: '',
      address: '',
      bio: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  BusnessModel? bsn;
  late CeremonyModel? crm;
  // This list holds all users

  List<CeremonyModel> _allCeremony = [];

  late String ceremonyType = "";
  late String ceremonyId = "";
  late String ceremonyCodeNo = "";
  late String ceremonyDate = "";
  late String ceremonyContact = "";

  late String ceremonyAdimnId = "";
  late String ceremonyFid = "";
  late String ceremonySid = "";
  late String ceremonyAvater = "";
  late String ceremonyUsername = "";
  late String isCrmnInFuture = "";
  late String isCrmnAdmin = "";

  String creatorId = "";
  List<CeremonyModel> myCrm = [];
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
        getAllCeremony();
        getCeremony(widget.user.id);

        bsn = widget.busness;
        crm = widget.ceremony;

        if (crm!.ceremonyType != "") ceremonyType = crm!.ceremonyType;
        if (crm!.ceremonyType != "") ceremonyId = crm!.cId;
        if (crm!.cId != "") ceremonyId = crm!.cId;
        if (crm!.codeNo != "") ceremonyCodeNo = crm!.codeNo;
        if (crm!.ceremonyDate != "") ceremonyDate = crm!.ceremonyDate;
        if (crm!.contact != "") ceremonyContact = crm!.contact;
        if (crm!.userFid.username != "") {
          ceremonyUsername = crm!.userFid.username!;
        }
        if (crm!.cImage != "") ceremonyAvater = crm!.cImage;
        if (crm!.fId != "") ceremonyFid = crm!.fId;
        if (crm!.sId != "") ceremonySid = crm!.sId;
        if (crm!.isInFuture != "") isCrmnInFuture = crm!.isInFuture;
        if (crm!.isCrmAdmin != "") isCrmnAdmin = crm!.isCrmAdmin;
      });
    });

    super.initState();
  }

  void _onChanged(String value) {
    setState(() => ceremonyContact = value);
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  getCeremony(userid) async {
    AllCeremonysModel(payload: [], status: 0)
        .getCeremonyByUserId(token, urlGetByUserId, userid)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          myCrm = value.payload
              .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  getAllCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .get(token, urlGetCeremony)
        .then((value) {
      setState(() {
        _allCeremony = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  String phone = '';

  Future<void> post() async {
    if (phoneNo.text != '') {
      if (phoneNo.text != ceremonyContact) {
        phone = phoneNo.text;
      } else {
        phone = ceremonyContact;
      }
    } else {
      phone = ceremonyContact;
    }

    if (isCrmnAdmin == 'true') creatorId = currentUser.id!;
    if (ceremonyId != "") {
      if (creatorId != '') {
        Requests(
                hostId: '',
                busnessId: bsn!.bId,
                ceremonyId: ceremonyId,
                contact: phone,
                payload: [],
                status: 0,
                createdBy: creatorId,
                type: '')
            .post(token, urlPostRequests)
            .then((value) {
          if (value.status == 200) {
            setState(() {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CrmnAdmin(
                            crm: CeremonyModel(
                                cId: ceremonyId,
                                codeNo: '',
                                ceremonyType: '',
                                cName: '',
                                fId: '',
                                sId: '',
                                cImage: '',
                                ceremonyDate: '',
                                contact: '',
                                admin: '',
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
                                youtubeLink: ''),
                          )));
            });
          } else {
            fillMessage(
              value.payload,
            );
          }
        });
      } else {
        fillMessage(
          'Your not Admin in this Ceremony..',
        );
      }
    } else {
      fillMessage(
        'Search your celemony Code No Please... ',
      );
    }
  }

  // Empty Input Messages
  fillMessage(String arg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: OColors.danger,
      content: Text(
        arg,
        style: TextStyle(color: OColors.dangerFontColor),
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: topBar(),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: ClipRRect(
                    child: fadeImg(
                        context,
                        '${api}public/uploads/${bsn!.user.username}/busness/${bsn!.coProfile}',
                        150,
                        100)),
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
                    Text(bsn!.busnessType,
                        style: header18.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      bsn!.companyName,
                      style: header16,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 15),
          //Divider
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 1,
            ),
            child: Divider(
              height: 1.0,
              color: Colors.white.withOpacity(.50),
              thickness: 1.0,
            ),
          ),

          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Price',
                  style: header18,
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Column(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: bsn!.price,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const TextSpan(
                          text: ' Tsh',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.red)),
                    ])),
                    const Text(
                      'Negotiable ',
                      style: TextStyle(
                          color: Colors.green, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Divider
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 1,
            ),
            child: Divider(
              height: 1.0,
              color: Colors.white.withOpacity(.50),
              thickness: 1.0,
            ),
          ),

          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(
                top: 12.0, left: 15.0, right: 8.0, bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Ceremony.',
                  textAlign: TextAlign.center,
                  style: header14.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox()
              ],
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LiveBorder(
                          live: const SizedBox.shrink(),
                          radius: 30,
                          child: fadeImg(
                              context,
                              '${api}public/uploads/$ceremonyUsername/ceremony/$ceremonyAvater',
                              50,
                              50)),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 6),
                        child: ceremonyId != ''
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ceremonyType,
                                    style: header12.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ceremonyCodeNo,
                                    style: header11.copyWith(
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    ceremonyDate,
                                    style: header10,
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  showAlertDialog(
                                      context, 'Select Ceremony ', '', '', '');
                                },
                                child: Center(
                                    child: Text(
                                  'Select your Ceremony',
                                  style: header12.copyWith(
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  myCrm.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            showAlertDialog(
                                context, 'Select Ceremony ', '', '', '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.change_circle,
                              size: 30,
                              color: OColors.primary,
                            ),
                          ),
                        )
                      :
                      // Add Ceremony
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CeremonyUpload(
                                            getData: ceremony,
                                            getcurrentUser: widget.user)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: OColors.fontColor,
                              ),
                            ),
                          ),
                        ),
                ],
              )),

          // Contact Enter
          ceremonyId != ''
              ? SizedBox(
                  width: 220,
                  child: Container(
                    height: 40,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        controller: phoneNo,
                        // autocorrect: true,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.call,
                              size: 16,
                              color: OColors.primary,
                            ),
                          ),
                          hintText: 'Change Contact',
                          hintStyle: const TextStyle(
                              fontSize: 13, color: Colors.grey, height: 1.5),
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 15,
                            color: OColors.fontColor,
                            height: 1.5),
                        onChanged: _onChanged),
                  ),
                )
              : const SizedBox.shrink(),
          const Spacer(),

          // Post Button
          isCrmnInFuture != ''
              ? GestureDetector(
                  onTap: () {
                    if (isCrmnInFuture == 'true') post();
                  },
                  child: Container(
                    width: isCrmnInFuture == 'true' ? 100 : 200,
                    height: 40,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 4, bottom: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: OColors.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: isCrmnInFuture == 'true'
                        ? Text(
                            'Invite',
                            style:
                                header14.copyWith(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Ceremony Expired Date',
                            style:
                                header14.copyWith(fontWeight: FontWeight.bold),
                          ),
                  ))
              : const SizedBox.shrink(),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Sherekea ,furahia sherehe yako katika ubora wa kitaifa na kimataifa',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container ceremonDetails(String idHeader, String arg1, msg) {
    return Container(
        color: OColors.darGrey,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),

            //header ..
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(idHeader,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: OColors.fontColor),
                      textAlign: TextAlign.start),
                ),
                Container(
                    // height: 25,
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: arg1 != ""
                        ? Text(
                            arg1,
                            style: TextStyle(
                                color: OColors.fontColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )
                        : Text(
                            msg,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: OColors.fontColor, fontSize: 13),
                          )),
              ],
            ),
          ],
        ));
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: OColors.appBarColor,
      elevation: 0,
      toolbarHeight: 70,
      flexibleSpace: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.ceremony.cId.isNotEmpty
              ? Center(
                  child: Text(
                  widget.busness.busnessType,
                  style: TextStyle(
                      color: OColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))
              : Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(
                        left: 45, right: 10, bottom: 15, top: 8),
                    decoration: BoxDecoration(
                      color: OColors.darGrey,
                      border: Border.all(width: 1.5, color: OColors.darGrey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Autocomplete<CeremonyModel>(
                      optionsBuilder: (TextEditingValue value) {
                        // When the field is empty
                        if (value.text.isEmpty) {
                          return [];
                        }

                        // The logic to find out which ones should appear
                        return _allCeremony
                            .where((ceremony) => ceremony.codeNo
                                .toLowerCase()
                                .contains(value.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (CeremonyModel option) =>
                          option.codeNo,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: OColors.primary,
                              size: 25,
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 13, height: 2),
                            hintText: "Ceremony CodeNo..",
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        );
                      },
                      onSelected: (CeremonyModel selection) {
                        setState(() {
                          ceremonyAvater = selection.cImage;
                          ceremonyUsername = selection.userFid.username!;

                          ceremonyType = selection.ceremonyType;
                          ceremonyId = selection.cId;
                          ceremonyCodeNo = selection.codeNo;
                          ceremonyDate = selection.ceremonyDate;
                          ceremonyContact = selection.contact;

                          ceremonyAdimnId = selection.admin;
                          ceremonyFid = selection.fId;
                          ceremonySid = selection.sId;
                          isCrmnInFuture = selection.isInFuture;
                          isCrmnAdmin = selection.isCrmAdmin;
                        });
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<CeremonyModel> onSelected,
                          Iterable<CeremonyModel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              color: OColors.secondary,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final CeremonyModel option =
                                      options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: option.cImage != ''
                                                  ? Image.network(
                                                      '${api}public/uploads/${option.userFid.username}/ceremony/${option.cImage}',
                                                      fit: BoxFit.cover,
                                                      height: 45,
                                                    )
                                                  : const SizedBox(height: 1),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(option.codeNo,
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(option.ceremonyType,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic))
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          height: 1.0,
                                          color: Colors.black.withOpacity(0.24),
                                          thickness: 1.0,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          const NotifyWidget()
        ],
      )),
    );
  }

  // Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(8),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: header15,
      ),
      child: const Text("Create Ceremony"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CeremonyUpload(
                    getData: ceremony, getcurrentUser: currentUser)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(left: 10, right: 10),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: header18),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.9,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myCrm.length,
            itemBuilder: (context, i) {
              final itm = myCrm[i];
              return myCrm.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          ceremonyId = itm.cId;
                          ceremonyAvater = itm.cImage;
                          ceremonyUsername = itm.userFid.username!;
                          ceremonyType = itm.ceremonyType;
                          ceremonyDate = itm.ceremonyDate;
                          ceremonyDate = itm.ceremonyDate;
                          ceremonyCodeNo = itm.codeNo;
                          isCrmnInFuture = itm.isInFuture;
                          isCrmnAdmin = itm.isCrmAdmin;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(
                          children: [
                            Text(
                              itm.ceremonyType,
                              style: header12,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Img(
                                  avater: itm.cImage,
                                  url: '/ceremony/',
                                  username: itm.userFid.username!,
                                  width: 55,
                                  height: 55,
                                )),
                            const SizedBox(
                              height: 4,
                            ),
                            itm.isInFuture == 'true'
                                ? Text(
                                    itm.ceremonyDate,
                                    style: header10,
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        itm.ceremonyDate,
                                        style: header10.copyWith(
                                            color: OColors.danger),
                                      ),
                                      Text(
                                        'Not valid',
                                        style: header10.copyWith(
                                            color: OColors.danger),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      'Dont Have Ceremony',
                      style: header13.copyWith(fontWeight: FontWeight.bold),
                    );
            }),
      ),
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
