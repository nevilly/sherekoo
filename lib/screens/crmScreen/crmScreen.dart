import 'package:flutter/material.dart';

import '../../model/allData.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../uploadScreens/ceremonyUpload.dart';
import 'crmDay.dart';

class CeremonyScreen extends StatefulWidget {
  const CeremonyScreen({Key? key}) : super(key: key);

  @override
  _CeremonyScreenState createState() => _CeremonyScreenState();
}

class _CeremonyScreenState extends State<CeremonyScreen> {
  final Preferences _preferences = Preferences();

  User currentUser = User(
      id: '',
      username: '',
      avater: '',
      phoneNo: '',
      role: '',
      gender: '',
      email: '',
      firstname: '',
      lastname: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '');
  String token = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        getUser();
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

  CeremonyModel ceremonyData = CeremonyModel(
      cId: '',
      codeNo: '',
      ceremonyType: '',
      cName: '',
      fId: '',
      sId: '',
      cImage: '',
      ceremonyDate: '',
      contact: '',
      admin: '',
      u1: '',
      u1Avt: '',
      u1Fname: '',
      u1Lname: '',
      u1g: '',
      u2: '',
      u2Avt: '',
      u2Fname: '',
      u2Lname: '',
      u2g: '',
      youtubeLink: '');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: topBar(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 10.0),
              alignment: Alignment.topLeft,
              child: const Text(
                "It's Great Day To Cerebrate.",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w400),
                // ,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'inv. Cards',
                  ),
                  Tab(
                    text: 'Shereko',
                  ),
                  Tab(
                    text: 'Past',
                  ),
                ]),
            const Expanded(
                child: TabBarView(children: [
              CeremonyDay(
                day: 'Upcoming',
              ),
              CeremonyDay(
                day: 'Today',
              ),
              CeremonyDay(
                day: 'Past',
              ),
            ]))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CeremonyUpload(
                            getData: ceremonyData,
                            getcurrentUser: currentUser,
                          )));
            },
            child: const Icon(Icons.upload, color: Colors.white),
            backgroundColor: Colors.red),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: OColors.appBarColor,
      elevation: 1.0,
      toolbarHeight: 70,
      flexibleSpace: SafeArea(
          child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 18, left: 10, right: 18, bottom: 7),
                width: 70,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[500]!.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextField(
                      cursorColor: Colors.grey[500]!.withOpacity(0.2),
                      decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.0),
                            child: Icon(
                              Icons.search,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Search..',
                          hintStyle: TextStyle(fontSize: 14)),
                      onChanged: (value) {
                        setState(() {
                          //_email = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const NotifyWidget()
          ],
        ),
      )),
    );
  }
}
