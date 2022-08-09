import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/searchBar/search_Busness.dart';
import '../../../model/ceremony/ceremonyModel.dart';
import '../../../util/Preferences.dart';
import '../../../util/util.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
import '../../widgets/navWidget/bottom_toolbar.dart';
import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import '../../widgets/navWidget/bttmNav.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';

class McCategory extends StatefulWidget {
  const McCategory({Key? key}) : super(key: key);

  @override
  _McCategoryState createState() => _McCategoryState();
}

class _McCategoryState extends State<McCategory> {
  final Preferences _preferences = Preferences();

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
                  child: SearchBusness(ceremony: ceremony),
                ),
              ),
              const NotifyWidget()
            ],
          ),
        )),
      ),

      body: Row(
        children: [
          //Left Navigation
          const CategoryMenu(
            rangi: Colors.white,
            title: 'Mc',
          ),

          //Right Navigator
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryBody(
                    title: 'Hot Mc',
                    heights: ctg_hotHeight,
                    crossAxisCountx: ctg_hotcrossAxisCountx,
                    hotStatus: '1',
                    ceremony: ceremony,
                    busnessType: 'Mc',
                  ),
                  CategoryBody(
                    title: 'Mc',
                    heights: ctg_bodyHeight,
                    crossAxisCountx: ctg_crossAxisCountx,
                    hotStatus: '0',
                    ceremony: ceremony,
                    busnessType: 'Mc',
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


//Inspiration
// https://stackoverflow.com/questions/57554659/stream-for-api-coming-from-php-in-flutter-not-firebase