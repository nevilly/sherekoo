import 'dart:async';

import 'package:flutter/material.dart';

import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/Preferences.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../widgets/categoriesWidgets/ctgrWigets.dart';
import '../../widgets/categoriesWidgets/hotCtgry.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../../widgets/ourServiceWidg/sherkoSvcWdg.dart';
import '../../widgets/searchBar/search_Busness.dart';
import '../drawer/navDrawer.dart';
import '../uploadScreens/busnessUpload.dart';

class Sherekoo extends StatefulWidget {
  const Sherekoo({Key? key}) : super(key: key);

  @override
  _SherekooState createState() => _SherekooState();
}

class _SherekooState extends State<Sherekoo> {
  late String dataType = '';
  late String title = '';
  late Color rangi;

  final StreamController<String> _controller = StreamController<String>();
  final StreamController<String> _controller2 = StreamController<String>();

  String page = '';
  String page2 = '';
  String crmTypee = '';

  @override
  void initState() {
    super.initState();
    preferences.init();
    page = 'Mc';
    page2 = 'Mc';
    rangi = OColors.darkGrey;
    title = 'Mc';
    dataType = 'Mc';

    _controller.add(page);
    _controller2.add(page2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: topBar(),
      drawer: const NavDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SherekooServices(),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Row(
              children: [
                // Side Menu
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey.shade300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // //Sherekoo
                        // GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         rangi = OColors.darkGrey;
                        //         title = 'Sherekoo';
                        //         dataType = 'Sherekoo';
                        //         crmTypee = 'Sherekoo';
                        //       });
                        //     },
                        //     child: sizedBoxMenu('Sherekoo', title)),

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
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HotCategoryBody(
                      stream: _controller.stream,
                      title: 'Hot $title',
                      heights: 65,
                      crossAxisCountx: 3,
                      hotStatus: '1',
                      ceremony: emptyCrmModel,
                      sType: dataType,
                      crm: false,
                    ),
                    CategoryBody(
                      stream: _controller2.stream,
                      title: title,
                      heights: MediaQuery.of(context).size.height / 1.7,
                      crossAxisCountx: 3,
                      hotStatus: '0',
                      ceremony: emptyCrmModel,
                      sType: dataType,
                      crm: false,
                    ),
                  ],
                )))
              ],
            ),
          ),
        ],
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
                              getData: emptyBsnMdl,
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

  Widget sizedBoxMenu(String value, title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 13,
      child: Container(
          margin: const EdgeInsets.only(bottom: 1.0),
          alignment: Alignment.center,
          color: title == value ? rangi : OColors.darGrey,
          // padding: const EdgeInsets.only(
          //     top: 15.0, bottom: 15.0, left: 10, right: 10),
          child: Text(
            value,
            style: header12.copyWith(fontWeight: FontWeight.w400),
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
                ceremony: emptyCrmModel,
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

  // @override
  // void dispose() {
  //   _controller.close();
  //   super.dispose();
  // }
}
