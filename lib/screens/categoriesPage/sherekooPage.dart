import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/searchBar/search_Ceremony.dart';

import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/categoriesWidgets/crmCtgr.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';

class Sherekoo extends StatefulWidget {
  const Sherekoo({Key? key}) : super(key: key);

  @override
  _SherekooState createState() => _SherekooState();
}

class _SherekooState extends State<Sherekoo> {
  final Preferences _preferences = Preferences();
  String token = '';
  late String ceremonyType = "";
  late String ceremonyId = "";
  late String ceremonyCodeNo = "";
  late String ceremonyDate = "";
  late String ceremonyContact = "";

  late String ceremonyAdimnId = "";
  late String ceremonyFid = "";
  late String ceremonySid = "";

  List<CeremonyModel> _allCeremony = [];
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        getAllCeremony();
      });
    });

    super.initState();
  }

  getAllCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .get(token, urlGetCeremony)
        .then((value) {
      setState(() {
        _allCeremony = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: Row(
        children: [
          const CategoryMenu(
            rangi: Colors.white,
            title: 'Sherekoo',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  CrmCategoriesWidget(
                    dataType: 'Birthday',
                    heights: 80,
                    crossAxisCountx: 3,
                    title: 'Birthday',
                    hotStatus: '0',
                  ),
                  CrmCategoriesWidget(
                    dataType: 'Wedding',
                    heights: 80,
                    crossAxisCountx: 3,
                    title: 'Wedding',
                    hotStatus: '0',
                  ),
                  CrmCategoriesWidget(
                    dataType: 'SendOff',
                    heights: 80,
                    crossAxisCountx: 3,
                    title: 'SendOff',
                    hotStatus: '0',
                  ),
                  CrmCategoriesWidget(
                    dataType: 'Kitchen Part',
                    heights: 80,
                    crossAxisCountx: 3,
                    title: 'Kitchen Part',
                    hotStatus: '0',
                  ),
                  CrmCategoriesWidget(
                    dataType: 'Kigodoro',
                    heights: 80,
                    crossAxisCountx: 3,
                    title: 'Kigodoro',
                    hotStatus: '0',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
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
                      top: 18, left: 15, right: 18, bottom: 7),
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[500]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const SearchCeremony()),
            ),
            const NotifyWidget()
          ],
        ),
      )),
    );
  }
}
