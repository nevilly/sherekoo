import 'package:flutter/material.dart';
import 'package:sherekoo/screens/uploadScreens/ceremonyUpload.dart';
import '../../model/user/user-call.dart';
import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/modInstance.dart';
import '../../util/colors.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/gradientBorder.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/ourServiceWidg/sherkoSvcWdg.dart';
import '../../widgets/scrollText.dart';
import '../../widgets/searchBar/search_Ceremony.dart';
import '../detailScreen/livee.dart';
import '../drawer/navDrawer.dart';
import 'crmDay.dart';
import 'crmDoor.dart';

class CrmOnNav extends StatefulWidget {
  const CrmOnNav({Key? key}) : super(key: key);

  @override
  CrmOnNavState createState() => CrmOnNavState();
}

class CrmOnNavState extends State<CrmOnNav> {
  int page = 0, limit = 8, offset = 0;
  final _controller = ScrollController();
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
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        getCeremony(offset: page, limit: limit);
      });
    });

    _controller.addListener(() {
      // print("scrolling....");
      if (_controller.hasClients &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        onPage(page);
      }
    });
    super.initState();
  }

  onPage(int pag) {
    // print("Pages");

    // print(pag);

    if (mounted) {
      setState(() {
        // bottom = true;
        if (page > pag) {
          page--;
        } else {
          page++;
        }
        offset = page * limit;
      });
    }

    // print("Select * from table where data=all limit $offset,$limit");
    //page = pag;
    // print('post Length :');
    // print(crm.length);
    getCeremony(offset: offset, limit: limit);
    if (pag == todayCrm.length - 1) {
      //offset = page;
      //print("Select * from posts order by id limit ${offset}, ${limit}");
    }
  }

  Future getUser(String dirUrl) async {
    return await UsersCall(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  getCeremony({int? offset, int? limit}) async {
    CrmCall(payload: [], status: 0)
        .getDayCeremony(token, urlCrmByDay, 'Today', offset, limit)
        .then((value) {
      setState(() {
        if (value.status == 200) {
          setState(() {
            todayCrm.addAll(value.payload
                .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
                .toList());
          });
        }
      });
    });
  }

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
                    child: mytodayCrm(),
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

  Column mytodayCrm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live',
                  style: header14.copyWith(fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 4),
                child: Icon(
                  Icons.live_tv,
                  size: 20,
                  color: OColors.primary,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 80.0,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: todayCrm.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6),
                child: SizedBox(
                  width: 65,
                  // color: OColors.darGrey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CrmDoor(
                                        crm: todayCrm[index],
                                      )));
                        },
                        child: todayCrm[index].cImage != ''
                            ? LiveBorder(
                                live: liveBar(),
                                radius: 30,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    '${api}public/uploads/${todayCrm[index].userFid.username}/ceremony/${todayCrm[index].cImage}',
                                  ),
                                ))
                            : const SizedBox(height: 1),
                      ),

                      //Details Ceremony
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Livee(ceremony: todayCrm[index])));
                        },
                        child: todayCrm[index].codeNo.length >= 8
                            ? SizedBox(
                                height: 20,
                                width: 70,
                                child: ScrollingText(
                                  text: todayCrm[index].codeNo,
                                  textStyle: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ))
                            : Text(todayCrm[index].codeNo,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
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

  Positioned liveBar() {
    return Positioned(
      bottom: 0,
      left: 4,
      width: 49,
      height: 15,
      child: Container(
          padding: const EdgeInsets.only(left: 3.5, right: 3.5),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OColors.primary,
                  OColors.primary,
                  Colors.red,
                ],
              ),
              color: OColors.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(width: 4),
              Icon(Icons.live_tv, size: 13, color: OColors.fontColor),
              const SizedBox(width: 5),
              Text(
                'live',
                style: header10,
              )
            ],
          )),
    );
  }

}
