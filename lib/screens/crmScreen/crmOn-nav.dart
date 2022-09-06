import 'package:flutter/material.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Ceremony.dart';
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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getCeremony();
      });
    });
    super.initState();
  }

  getCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .getDayCeremony(token, urlCrmByDay, 'Today')
        .then((value) {
      setState(() {
        if (value.status == 200) {
          setState(() {
            todayCrm = value.payload
                .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
                .toList();
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
        body: Column(
          children: [
            //Live Ceremony
            todayCrm.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CrmSlide(todayCrm: todayCrm),
                  )
                : const SizedBox(),

            //Tabs ..
            TabBar(
                labelColor: OColors.primary,
                unselectedLabelColor: OColors.darkGrey,
                indicatorColor: OColors.primary,
                padding: const EdgeInsets.all(8),
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
        // Bottom Section
        // bottomNavigationBar: BottomToolbar()
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: OColors.secondary,
      elevation: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
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
                    left: 10, right: 10, bottom: 15, top: 10),
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
