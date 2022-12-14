import 'package:flutter/material.dart';
import 'package:sherekoo/screens/uploadScreens/ceremonyUpload.dart';
import '../../model/allData.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/modInstance.dart';
import '../../util/colors.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/ourServiceWidg/sherkoSvcWdg.dart';
import '../../widgets/searchBar/search_Ceremony.dart';
import '../drawer/navDrawer.dart';
import 'crmDay-Slide.dart';
import 'crmDay.dart';

class CrmOnNav extends StatefulWidget {
  const CrmOnNav({Key? key}) : super(key: key);

  @override
  CrmOnNavState createState() => CrmOnNavState();
}

class CrmOnNavState extends State<CrmOnNav> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<CeremonyModel> todayCrm = [];

  User user = User(
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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        // getCeremony();
      });
    });
    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  // getCeremony() async {
  //   AllCeremonysModel(payload: [], status: 0)
  //       .getDayCeremony(token, urlCrmByDay, 'Today')
  //       .then((value) {

  //     setState(() {
  //       if (value.status == 200) {
  //         setState(() {
  //           todayCrm = value.payload
  //               .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
  //               .toList();
  //         });
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: topBar(),
        drawer: const NavDrawer(),
        body: Column(
          children: [
            const SherekooServices(),
            const SizedBox(
              height: 8,
            ),

            //Live Ceremony
            todayCrm.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 4, bottom: 4),
                    child: CrmSlide(todayCrm: todayCrm),
                  )
                : const SizedBox(),

            const SizedBox(
              height: 2,
            ),
            //Tabs ..
            TabBar(
                labelColor: OColors.primary,
                unselectedLabelColor: OColors.darkGrey,
                indicatorColor: OColors.primary,
                labelPadding:
                    const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 1),
                tabs: const [
                  Tab(
                    text: 'UpComing',
                  ),
                  Tab(
                    text: 'Past',
                  )
                ]),

            const Expanded(
                child: TabBarView(children: [
              CeremonyDay(
                day: 'Upcoming',
              ),
              CeremonyDay(
                day: 'Past',
              ),
            ]))
          ],
        ),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: OColors.secondary,
      elevation: 1.0,
      toolbarHeight: 75,
      flexibleSpace: SafeArea(
          child: Container(
        color: OColors.secondary,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showAlertDialog(context, 'Search busness ', '', '', '');
                },
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 12, left: 55, right: 10, bottom: 7),
                    height: 45,
                    decoration: BoxDecoration(
                      color: OColors.darGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 6),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Text(
                          'Search Ceremony',
                          style: header12,
                        )
                      ],
                    )),
              ),
              //const SearchCeremony()),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CeremonyUpload(
                              getData: emptyCrmModel,
                              getcurrentUser: user,
                            )));
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 5, right: 5, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: OColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.add,
                    color: OColors.primary,
                    size: 22,
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

  // Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 5),
      backgroundColor: OColors.secondary,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              size: 35,
              color: OColors.fontColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0, top: 8, bottom: 8),
          child: Text('Search',
              style:
                  header18.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ]),
      content: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const SearchCeremony())
        ],
      ),
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
