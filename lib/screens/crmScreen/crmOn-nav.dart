import 'package:flutter/material.dart';
import 'package:sherekoo/screens/ourServices/sherekoService.dart';
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ourServices(context, 'Order Cards'),
                  ourServices(context, 'Dress Design'),
                  ourServices(context, 'Mc Booking'),
                  ourServices(context, 'Production'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SherekoService(
                                      from: 'MyBdayShow',
                                    )));
                      },
                      child: ourServices(context, 'MyBday Tv Show')),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SherekoService(
                                      from: 'Mr&MrsMy',
                                    )));
                      },
                      child: ourServices(context, 'Mr&Mrs Wangu Tv Show')),
                  ourServices(context, 'Documentary make'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SherekoService(
                                      from: 'crmBundle',
                                    )));
                      },
                      child: ourServices(context, 'Ceremony Bundle')),
                  ourServices(context, 'Tranport Bandle'),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
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
              height: 8,
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
        // Bottom Section
        // bottomNavigationBar: BottomToolbar()
      ),
    );
  }

  Container ourServices(BuildContext context, String prod) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      height: 20,
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1.3, color: OColors.primary),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          prod,
          style: header12.copyWith(color: OColors.primary),
        ),
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
