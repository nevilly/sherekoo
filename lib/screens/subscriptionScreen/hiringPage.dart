import 'package:flutter/material.dart';
import 'package:sherekoo/model/requests/requests.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/allData.dart';
import '../../model/userModel.dart';
import '../../model/services/postServices.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../admin/crmAdmin.dart';

class HiringPage extends StatefulWidget {
  final BusnessModel busness;
  final CeremonyModel ceremony;
  const HiringPage({Key? key, required this.busness, required this.ceremony})
      : super(key: key);

  @override
  State<HiringPage> createState() => _HiringPageState();
}

class _HiringPageState extends State<HiringPage> {
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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
        getAllCeremony();
      });
    });

    bsn = widget.busness;
    crm = widget.ceremony;

    if (crm!.ceremonyType != "") ceremonyType = crm!.ceremonyType;
    if (crm!.ceremonyType != "") ceremonyId = crm!.cId;
    if (crm!.cId != "") ceremonyId = crm!.cId;
    if (crm!.codeNo != "") ceremonyCodeNo = crm!.codeNo;
    if (crm!.ceremonyDate != "") ceremonyDate = crm!.ceremonyDate;
    if (crm!.contact != "") ceremonyContact = crm!.contact;
    if (crm!.fId != "") ceremonyFid = crm!.fId;
    if (crm!.sId != "") ceremonySid = crm!.sId;

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
  String creatorId = "";

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

    if (currentUser.id == ceremonyFid) creatorId = ceremonyFid;
    if (currentUser.id == ceremonySid) creatorId = ceremonySid;
    if (currentUser.id == ceremonyAdimnId) creatorId = ceremonyAdimnId;

    if (ceremonyId != "") {
      if (creatorId.isNotEmpty) {
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
                             userFid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
                        userSid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: ClipRRect(
                  child: Center(
                      child: bsn!.coProfile != ''
                          ? Image.network(
                              '${api}public/uploads/${bsn!.user.username}/busness/${bsn!.coProfile}',
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(height: 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 1.0, bottom: 8.0, left: 2.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bsn!.busnessType,
                        style: TextStyle(
                          fontSize: 19,
                          color: OColors.fontColor,
                        )),
                    Text(
                      bsn!.companyName,
                      style: TextStyle(
                        fontSize: 15,
                        color: OColors.fontColor,
                      ),
                    ),
                    const SizedBox(height: 5),
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
              )
            ],
          ),

          Padding(
            padding:
                const EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 10),
            child: Divider(
              height: 1.0,
              color: Colors.white.withOpacity(.50),
              thickness: 1.0,
            ),
          ),

          //ceremony Info
          // Container(
          //   height: 45,
          //   padding: const EdgeInsets.only(left: 20, right: 10),
          //   margin: const EdgeInsets.only(
          //       left: 10, right: 10, bottom: 15, top: 10),
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 1.5, color: Colors.grey),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child:
          // ),

          Padding(
            padding: const EdgeInsets.only(
                top: 2.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              'Your Ceremony Info.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: OColors.fontColor),
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Container(
            color: OColors.darGrey,
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Column(
              children: [
                ceremonDetails(
                    'Ceremony ID', ceremonyCodeNo, 'Ceremony CodeNo'),
                ceremonDetails('Ceremony Date', ceremonyDate, 'Eg: 2022/1/1 '),
                ceremonDetails(
                    'Contact', ceremonyContact, 'Enter Your Contact Pls...'),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),

          // Contact Enter
          Container(
            color: OColors.darGrey,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: Text('Change Contact',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                      controller: phoneNo,
                      // autocorrect: true,
                      // autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.call,
                            size: 28,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Use Another Contact',
                        hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          fontSize: 15, color: OColors.fontColor, height: 1.5),
                      onChanged: _onChanged),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 2,
          ),
          // Post Button
          GestureDetector(
            onTap: () {
              post();
            },
            child: Container(
              width: 100,
              height: 40,
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Text(
                'Hire',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
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
          child: Container(
        color: OColors.transparent,
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
                : Container(
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
                                color: Colors.white, fontSize: 14, height: 2),
                            hintText: "Ceremony CodeNo..",
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        );
                      },
                      onSelected: (CeremonyModel selection) {
                        setState(() {
                          ceremonyType = selection.ceremonyType;
                          ceremonyId = selection.cId;
                          ceremonyCodeNo = selection.codeNo;
                          ceremonyDate = selection.ceremonyDate;
                          ceremonyContact = selection.contact;

                          ceremonyAdimnId = selection.admin;
                          ceremonyFid = selection.fId;
                          ceremonySid = selection.sId;
                        });

                        // print('Selected: ${selection.codeNo}');
                        // print('fid: ${selection.fId}');
                        // print('sid: ${selection.sId}');
                        // print('Selected: ${selection.admin}');
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<CeremonyModel> onSelected,
                          Iterable<CeremonyModel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: 400,
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
            // const NotifyWidget()
          ],
        ),
      )),
    );
  }
}
