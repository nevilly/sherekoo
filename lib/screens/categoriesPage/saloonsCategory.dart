import 'package:flutter/material.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Busness.dart';

class SaloonsCategory extends StatefulWidget {
  const SaloonsCategory({Key? key}) : super(key: key);

  @override
  State<SaloonsCategory> createState() => _SaloonsCategoryState();
}

class _SaloonsCategoryState extends State<SaloonsCategory> {
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
            title: 'Saloon',
          ),

          //Right Navigator
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CategoryBody(
                  //   title: 'Hot Saloon',
                  //   heights: ctg_hotHeight,
                  //   crossAxisCountx: ctg_hotcrossAxisCountx,
                  //   hotStatus: '1',
                  //   ceremony: ceremony,
                  //   busnessType: 'Saloon',
                  // ),
                  // CategoryBody(
                  //   title: 'Saloon',
                  //   heights: ctg_bodyHeight,
                  //   crossAxisCountx: ctg_crossAxisCountx,
                  //   hotStatus: '0',
                  //   ceremony: ceremony,
                  //   busnessType: 'Saloon',
                  // ),
                
                ],
              ),
            ),
          )
        ],
      ),

    
    );
  }
}
