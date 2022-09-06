import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/searchBar/search_Ceremony.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/colors.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/categoriesWidgets/crmCtgr.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
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
      u2g: '',
      youtubeLink: '');

  late String dataType = '';
  late String title = '';

  late Color rangi;

  final StreamController<String> _controller = StreamController<String>();
  final StreamController<String> _controller2 = StreamController<String>();
  String page = '';
  String page2 = '';

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
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: topBar(),
      body: Row(
        children: [
          // CategoryMenu(
          //   rangi: OColors.darkGrey,
          //   title: 'Sherekoo',
          // ),
          SizedBox(
            width: 100,
            // color: Colors.grey.shade300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Sherekoo
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Sherekoo';
                          dataType = 'Sherekoo';
                        });
                      },
                      child: sizedBoxMenu('Sherekoo', title)),
                  // Mc
                  GestureDetector(
                      onTap: () {
                        page = 'Mc'; // Mc
                        page2 = 'Mc';
                        _controller.add(page);
                        _controller2.add(page2);

                        if (mounted) {
                          setState(() {
                            rangi = OColors.darkGrey;
                            title = 'Mc';
                            dataType = 'Mc';
                          });
                        }
                      },
                      child: sizedBoxMenu('Mc', title)),
                  //Halls
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          page = 'Hall'; // Mc
                          page2 = 'Hall'; // Mc
                          _controller.add(page);
                          _controller2.add(page);
                          rangi = OColors.darkGrey;
                          title = 'Halls';
                          dataType = 'Hall';
                        });
                      },
                      child: sizedBoxMenu('Halls', title)),
                  //Decorators
                  GestureDetector(
                      onTap: () {
                        page = 'Decorator';
                        page2 = 'Decorator';
                        _controller.add(page);
                        _controller2.add(page2);

                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Decorators';
                          dataType = 'Decorators';
                        });

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             const DecoratorsCategory()));
                      },
                      child: sizedBoxMenu('Decorators', title)),
                  //Saloon
                  GestureDetector(
                      onTap: () {
                        page = 'Saloon';
                        page2 = 'Saloon';
                        _controller.add(page);
                        _controller2.add(page2);

                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Saloons';
                          dataType = 'Saloons';
                        });
                      },
                      child: sizedBoxMenu('Saloons', title)),
                  // Cake Bake
                  GestureDetector(
                      onTap: () {
                        page = 'Cake Bakery';
                        page2 = 'Cake Bakery';
                        _controller.add(page);
                        _controller2.add(page2);

                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Cake Bakers';
                          dataType = 'Cake Bakers';
                        });
                      },
                      child: sizedBoxMenu('Cake Bakers', title)),
                  // Dancers
                  GestureDetector(
                      onTap: () {
                        page = 'Dancer';
                        page2 = 'Dancer';
                        _controller.add(page);
                        _controller2.add(page2);
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Dancers';
                          dataType = 'Dancers';
                        });
                      },
                      child: sizedBoxMenu('Dancers', title)),
                  //Production
                  GestureDetector(
                      onTap: () {
                        page = 'Production';
                        page2 = 'Production';
                        _controller.add(page);
                        _controller2.add(page2);
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Productions';
                          dataType = 'Productions';
                        });
                      },
                      child: sizedBoxMenu('Productions', title)),
                  //Cars
                  GestureDetector(
                      onTap: () {
                        page = 'Car';
                        page2 = 'Car';
                        _controller.add(page);
                        _controller2.add(page2);
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Cars';
                          dataType = 'Cars';
                        });
                      },
                      child: sizedBoxMenu('Cars', title)),
                  //Cooker
                  GestureDetector(
                      onTap: () {
                        page = 'Cooker';
                        page2 = 'Cooker';
                        _controller.add(page);
                        _controller2.add(page2);
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Cookers';
                          dataType = 'Cookers';
                        });
                      },
                      child: sizedBoxMenu('Cookers', title)),

                  //Singers
                  GestureDetector(
                      onTap: () {
                        page = 'Singer';
                        page2 = 'Singer';
                        _controller.add(page);
                        _controller2.add(page2);
                        setState(() {
                          rangi = OColors.darkGrey;
                          title = 'Singers';
                          dataType = 'Singers';
                        });
                      },
                      child: sizedBoxMenu('Singers', title)),

                  const SizedBox(
                    height: 35,
                  )
                ],
              ),
            ),
          ),

          Expanded(
              child: SingleChildScrollView(
                  child: dataType == 'Sherekoo'
                      ? Column(
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
                        )
                      : Column(
                          children: [
                            CategoryBody(
                              stream: _controller.stream,
                              title: 'Hot $title',
                              heights: 65,
                              crossAxisCountx: 3,
                              hotStatus: '1',
                              ceremony: ceremony,
                              busnessType: dataType,
                            ),
                            CategoryBody(
                              stream: _controller2.stream,
                              title: title,
                              heights: 380,
                              crossAxisCountx: 3,
                              hotStatus: '0',
                              ceremony: ceremony,
                              busnessType: dataType,
                            )
                          ],
                        )))
        ],
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: OColors.secondary,
      elevation: 1.0,
      toolbarHeight: 70,
      flexibleSpace: SafeArea(
          child: Container(
        color: OColors.secondary,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 18, left: 15, right: 18, bottom: 7),
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    color: OColors.darGrey,
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

  Widget sizedBoxMenu(String value, title) {
    return SizedBox(
      width: 100,
      child: Container(
          margin: const EdgeInsets.only(bottom: 1.0),
          alignment: Alignment.center,
          color: title == value ? rangi : OColors.darGrey,
          padding: const EdgeInsets.only(
              top: 15.0, bottom: 15.0, left: 10, right: 10),
          child: Text(
            value,
            style: TextStyle(color: OColors.fontColor),
          )),
    );
  }

  // @override
  // void dispose() {
  //   _controller.close();
  //   super.dispose();
  // }
}
