import 'package:flutter/material.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/colors.dart';
import '../../util/textStyle-pallet.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/ourServiceWidg/sherkoSvcWdg.dart';
import '../../widgets/searchBar/search_Busness.dart';
import 'bsnTabs.dart';
import '../uploadScreens/busnessUpload.dart';

class BusnessScreen extends StatefulWidget {
  final String bsnType;
  final CeremonyModel ceremony;
  const BusnessScreen({Key? key, required this.bsnType, required this.ceremony})
      : super(key: key);

  @override
  State<BusnessScreen> createState() => _BusnessScreenState();
}

class _BusnessScreenState extends State<BusnessScreen> {
  CeremonyModel ceremony = CeremonyModel(
    cId: '',
    codeNo: '',
    ceremonyType: '',
    cName: '',
    fId: '',
    sId: '',
    cImage: '',
    ceremonyDate: '',
    admin: '',
    contact: '',
    isCrmAdmin: '',
    isInFuture: '',
      likeNo:'',
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
    youtubeLink: '',
  );

  BusnessModel busness = BusnessModel(
      location: '',
      bId: '',
      knownAs: '',
      coProfile: '',
      busnessType: '',
      companyName: '',
      price: '',
      contact: '',
      hotStatus: '',
      aboutCEO: '',
      aboutCompany: '',
      createdDate: '',
      ceoId: '',
      subcrlevel: '',
      createdBy: '',
      isBsnAdmin:'',
      user: User(
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
          totalLikes: ''));
  @override
  void initState() {
    ceremony = widget.ceremony;
    // print('cehek on bsn Screeen');
    // print(ceremony.codeNo);
    super.initState();
  }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: [
            Tab(
              text: 'All ${widget.bsnType}',
            ),
            Tab(
              text: 'Best ${widget.bsnType}',
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: topBar(),
        body: Column(
          children: [
            const SherekooServices(),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'ADS AREA',
              style: TextStyle(color: Colors.white),
            ),
            PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 0.8))),
                    child: ColoredBox(color: OColors.darGrey, child: _tabBar))),
            Expanded(
                child: TabBarView(children: [
              BsnTab(
                bsnType: widget.bsnType,
                ceremony: ceremony,
              ),
              BsnTab(
                bsnType: widget.bsnType,
                ceremony: ceremony,
              ),
            ])),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: OColors.primary,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BusnessUpload(
                          getData: busness,
                        )));
          },
          label: const Text('Busness +'),
          // child: const Icon(
          //   Icons.add,
          //   color: Colors.white,

          // ),
        ), // This trailing comm
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
                          'Search Busness',
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
                        builder: (BuildContext context) => BusnessUpload(
                              getData: busness,
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
              child: SearchBusness(
                ceremony: ceremony,
              ))
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
