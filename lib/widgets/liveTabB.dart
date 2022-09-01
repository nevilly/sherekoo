import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../model/allData.dart';
import '../model/profileMode.dart';
import '../model/services/postServices.dart';
import '../model/services/svModel.dart';
import '../screens/hireRequset/InvCeremony.dart';
import '../screens/bsnScreen/bsnScrn.dart';
import '../util/Preferences.dart';
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

  List<SvModel> bsnInfo = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
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
    Services(
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
      // print('check the payload brother');
      // print(v.payload);
      if (v.status == 200) {
        setState(() {
          bsnInfo = v.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
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
                      color: Colors.red,
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
                      color: Colors.red,
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

          if (currentUser.id == widget.ceremony.fId ||
              currentUser.id == widget.ceremony.sId ||
              currentUser.id == widget.ceremony.admin)
            Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                              bsnType: 'Mc', ceremony: widget.ceremony)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 4, bottom: 4),
                    child: Row(children: const [
                      Text('Mc',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                              bsnType: 'Production',
                              ceremony: widget.ceremony)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 4, bottom: 4),
                    child: Row(children: const [
                      Text('Production',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                                bsnType: 'Singer',
                                ceremony: widget.ceremony,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 4, bottom: 4),
                    child: Row(children: const [
                      Text('Singers',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
              )
            ]),

          //*** END TEMPORY , suppose to be in FAB BUTTON */

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, child) => const Divider(
                height: 5,
              ),
              padding: const EdgeInsets.all(0.0),
              itemCount: bsnInfo.length,
              itemBuilder: (context, i) {
                return SizedBox(
                    height: 120,
                    width: double.infinity,
                    // color: Colors
                    //     .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey.shade400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Our ${bsnInfo[i].busnessType}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                if (currentUser.id == widget.ceremony.fId ||
                                    currentUser.id == widget.ceremony.sId ||
                                    currentUser.id == widget.ceremony.admin)
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 73, 23, 20),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0,
                                              bottom: 4.0,
                                              left: 8,
                                              right: 8),
                                          child: Text(
                                            'Choose ${bsnInfo[i].busnessType}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                ),
                                child:
                                    // Image(
                                    //     height: 50,
                                    //     image: AssetImage(
                                    //         ('assets/ceremony/b1.png')))

                                    Image.network(
                                  '${api}public/uploads/${bsnInfo[i].bsnUsername}/busness/${bsnInfo[i].coProfile}',
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    // margin: EdgeInsets.only(top: 1),
                                    child: Center(
                                      child: Text(
                                        '${bsnInfo[i].busnessType}: ${bsnInfo[i].knownAs}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (currentUser.id == widget.ceremony.fId ||
                                      currentUser.id == widget.ceremony.sId ||
                                      currentUser.id == widget.ceremony.admin)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        InvatationCeremony(
                                                            id: widget.ceremony
                                                                .cId)));
                                      },
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 73, 23, 20),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                top: 4.0,
                                                bottom: 4.0,
                                                left: 8,
                                                right: 8),
                                            child: Text(
                                              'Bagain Now',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
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
