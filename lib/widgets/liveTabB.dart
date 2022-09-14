import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/model/requests/requests.dart';
import 'package:sherekoo/model/requests/requestsModel.dart';

import '../model/allData.dart';
import '../model/profileMode.dart';
import '../model/services/postServices.dart';
import '../model/services/svModel.dart';
import '../screens/hireRequset/InvCeremony.dart';
import '../screens/bsnScreen/bsnScrn.dart';
import '../util/Preferences.dart';
import '../util/colors.dart';
import '../util/util.dart';
import 'listTile_widget.dart';

class TabB extends StatefulWidget {
  final CeremonyModel ceremony;
  final User user;
  const TabB({Key? key, required this.ceremony, required this.user})
      : super(key: key);

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
      totalPost: '');

  List<RequestsModel> bsnInfo = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // print('ceremony id');
        // print(widget.ceremony.cId);
        // print(widget.ceremony.fId);
        // print(widget.ceremony.admin);

        // print('user id');
        // print(widget.user.id);
        getUser();
        getInvatation();
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

  getInvatation() async {
    Requests(
            hostId: '',
            busnessId: '',
            contact: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'ceremony')
        .getInvataions(token, urlGetInvatation, widget.ceremony.cId)
        .then((v) {
      print('check the payload brother');
      print(v.payload);
      if (v.status == 200) {
        setState(() {
          bsnInfo = v.payload.map<RequestsModel>((e) => SvModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: OColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 4, bottom: 4),
                      child: cardFotter(
                          const Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 14,
                          ),
                          '124'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: OColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 4, bottom: 4),
                      child: cardFotter(
                          const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 14,
                          ),
                          '99k'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      oneButtonPressed();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 4, bottom: 4),
                        child: Row(children: const [
                          Text(
                            'Comette',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('50',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ]),
                      ),
                    ),
                  )
                ]),
          ),

          //***TEMPORY , suppose to be in FAB BUTTON */

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: bsnInfo.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    tileColor: OColors.darGrey,
                    horizontalTitleGap: 8,
                    leading: Image.network(
                      '${api}public/uploads/${bsnInfo[i].bsnUsername}/busness/${bsnInfo[i].coProfile}',
                      height: 70,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      '${bsnInfo[i].price} Tsh',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: OColors.fontColor),
                    ),
                    subtitle: Text(
                      '${bsnInfo[i].busnessType} : ${bsnInfo[i].knownAs} ',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: OColors.fontColor),
                    ),
                    trailing: Text(
                      'Pending',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: OColors.primary),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Row cardFotter(Icon icon, String no) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        Text(
          no,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  void oneButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 560,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: buildBottomNavigationMenu()),
          );
        });
  }

  Column buildBottomNavigationMenu() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Commetee && Participants',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        // SizedBox(height: 5),

        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemCount: 150,
              itemBuilder: (BuildContext context, index) {
                return const SingleChildScrollView(child: ListMembers());
              }),
        ),
      ],
    );
  }
}
