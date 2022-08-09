import 'package:flutter/material.dart';
import '../../../model/busness/busnessModel.dart';
import '../../../model/ceremony/ceremonyModel.dart';
import '../../../util/Preferences.dart';
import '../../../util/util.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
import '../../widgets/navWidget/bottom_toolbar.dart';
import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import '../../widgets/navWidget/bttmNav.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Busness.dart';

class HallsCategory extends StatefulWidget {
  const HallsCategory({Key? key}) : super(key: key);

  @override
  _HallsCategoryState createState() => _HallsCategoryState();
}

class _HallsCategoryState extends State<HallsCategory> {
  final Preferences _preferences = Preferences();
  String token = '';
  List<BusnessModel> data = [];

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
      u1: '',
      u1Avt: '',
      u1Fname: '',
      u1Lname: '',
      u1g: '',
      u2: '',
      u2Avt: '',
      u2Fname: '',
      u2Lname: '',
      u2g: '', youtubeLink: '');

  @override
  void initState() {
    _preferences.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      top: 18, left: 10, right: 18, bottom: 7),
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[500]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: SearchBusness(ceremony: ceremony)),
                  ),
                ),
              ),
              const NotifyWidget()
            ],
          ),
        )),
      ),

      body: Row(
        children: [
          const CategoryMenu(
            rangi: Colors.white,
            title: 'Halls',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryBody(
                    title: 'Hot Halls',
                    heights: ctg_hotHeight,
                    crossAxisCountx: ctg_crossAxisCountx,
                    hotStatus: '1',
                    ceremony: ceremony,
                    busnessType: 'Hall',
                  ),
                  CategoryBody(
                    title: 'Halls',
                    heights: ctg_bodyHeight,
                    crossAxisCountx: ctg_crossAxisCountx,
                    hotStatus: '0',
                    ceremony: ceremony,
                    busnessType: 'Hall',
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      //Bottom Section
      // bottomNavigationBar: const BttmNav(),
      //bottomNavigationBar: BottomToolbar(),
    );
  }
}
