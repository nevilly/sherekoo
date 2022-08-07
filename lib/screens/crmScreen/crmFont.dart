import 'package:flutter/material.dart';

import '../../model/allData.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/navWidget/bottom_toolbar.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Ceremony.dart';
import 'crmDay.dart';
import '../detailScreen/livee.dart';

class CrmFontPage extends StatefulWidget {
  const CrmFontPage({Key? key}) : super(key: key);

  @override
  _CrmFontPageState createState() => _CrmFontPageState();
}

class _CrmFontPageState extends State<CrmFontPage> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<CeremonyModel> todayCrm = [];
  User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '', isCurrentUser: '');

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
        getCeremony();
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

  getCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .getDayCeremony(token, urlGetDayCeremony, 'Today')
        .then((value) {
      setState(() {
        todayCrm = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: topBar(),
          body: Column(
            children: [
              //Live Ceremony
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
                      child: Text('Live Ceremony'),
                    ),
                    SizedBox(
                      height: 64.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: todayCrm.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.red)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Livee(
                                                        ceremony:
                                                            todayCrm[index],
                                                      )));
                                        },
                                        child: ClipRRect(
                                          child: todayCrm[index].cImage != ''
                                              ? CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                    api +
                                                        'public/uploads/' +
                                                        todayCrm[index].u1 +
                                                        '/ceremony/' +
                                                        todayCrm[index].cImage,
                                                  ),
                                                )
                                              : const SizedBox(height: 1),
                                        ),
                                      ),

                                      //Details Ceremony
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 1.0,
                                          ),

                                          // Title
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 1),
                                            child: Text(
                                                todayCrm[index]
                                                    .ceremonyType
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => Livee(
                                                          ceremony: todayCrm[
                                                              index])));
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, left: 5),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            105)),
                                                child: Text(
                                                  todayCrm[index].codeNo,
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //Tabs ..
              const TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  padding: EdgeInsets.all(8),
                  tabs: [
                    Tab(
                      text: 'UpComing',
                    ),
                    Tab(
                      text: 'Today',
                    )
                  ]),

              const Expanded(
                  child: TabBarView(children: [
                CeremonyDay(
                  day: 'Upcoming',
                ),
                CeremonyDay(
                  day: 'Today',
                ),
              ]))
            ],
          ),
          // Bottom Section
          bottomNavigationBar: BottomToolbar()),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 70,
      flexibleSpace: SafeArea(
          child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 15, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.grey),
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
