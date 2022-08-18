import '../../../model/ceremony/ceremonyModel.dart';
import '../../../util/Preferences.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import 'package:flutter/material.dart';

import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/searchBar/search_Busness.dart';

class ProductionCategory extends StatefulWidget {
  const ProductionCategory({Key? key}) : super(key: key);

  @override
  _ProductionCategoryState createState() => _ProductionCategoryState();
}

class _ProductionCategoryState extends State<ProductionCategory> {
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
            title: 'Production',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryBody(
                    title: 'Hot Production',
                    heights: 65,
                    crossAxisCountx: 3,
                    hotStatus: '1',
                    ceremony: ceremony,
                    busnessType: 'Production',
                  ),
                  CategoryBody(
                    title: 'Production',
                    heights: 390,
                    crossAxisCountx: 3,
                    hotStatus: '0',
                    ceremony: ceremony,
                    busnessType: 'Production',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
