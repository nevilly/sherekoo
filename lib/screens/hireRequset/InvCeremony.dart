import 'package:flutter/material.dart';
import 'package:sherekoo/model/services/postServices.dart';

import '../../../model/allData.dart';
import '../../../model/profileMode.dart';
import '../../../model/services/svModel.dart';
import '../../../util/Preferences.dart';
import '../../../util/util.dart';
import '../drawer/navDrawer.dart';

class InvatationCeremony extends StatefulWidget {
  final String id;
  const InvatationCeremony({Key? key, required this.id}) : super(key: key);

  @override
  State<InvatationCeremony> createState() => _InvatationCeremonyState();
}

class _InvatationCeremonyState extends State<InvatationCeremony> {
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
      role: '');
  List<SvModel> invites = [];
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
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
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
        .getInvataions(token, urlGetInvatation, widget.id)
        .then((v) {
      setState(() {
        invites = v.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54, title: const Text('Invaitation')),
      drawer: const NavDrawer(),
      body: SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: invites.length,
              itemBuilder: (BuildContext context, i) {
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
                                  child: Text('Our ' + invites[i].busnessType,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 73, 23, 20),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0,
                                            bottom: 4.0,
                                            left: 8,
                                            right: 8),
                                        child: Text(
                                          'Choose ' + invites[i].busnessType,
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
                                  api +
                                      'public/uploads/' +
                                      invites[i].bsnUsername +
                                      '/busness/' +
                                      invites[i].coProfile,
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
                                        invites[i].busnessType +
                                            ': ' +
                                            invites[i].knownAs,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder:
                                      //             (BuildContext context) =>
                                      //                 InvatationCeremony(
                                      //                     id: widget.ceremony
                                      //                         .cId)));
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
              })),
    );
  }
}
