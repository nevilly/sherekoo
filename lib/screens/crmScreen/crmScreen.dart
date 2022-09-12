import 'package:flutter/material.dart';

import '../../model/allData.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Ceremony.dart';
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

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: const [
            Tab(
              text: 'inv. Cards',
            ),
            Tab(
              text: 'Shereko',
            ),
            Tab(
              text: 'Past',
            ),
          ]);

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
              child: Text(
                "It's Great Day To Cerebrate.",
                style: TextStyle(
                    fontSize: 20,
                    color: OColors.fontColor,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w400),
                // ,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CeremonyUpload(
                            getData: ceremonyData,
                            getcurrentUser: currentUser,
                          )));
            },
            extendedPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            label: const Text('Ceremony +'),
            // child: const Icon(Icons.upload, color: Colors.white),
            backgroundColor: OColors.primary),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: OColors.secondary,
      elevation: 0,
      toolbarHeight: 70,
      // automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
          child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(
                    left: 45, right: 10, bottom: 15, top: 10),
                decoration: BoxDecoration(
                  color: OColors.darGrey,
                  border: Border.all(width: 1.5, color: OColors.darGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SearchCeremony(),
              ),
            ),
            const NotifyWidget()
          ],
        ),
      )),
    );
  }
}
