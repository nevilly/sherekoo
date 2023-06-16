import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';

import '../../model/crmBundle/bundle.dart';
import '../../model/crmBundle/crmbundle-call.dart';
import '../../model/crmPackage/crmPackage.dart';
import '../../model/crmPackage/crmPackageModel.dart';
import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/util.dart';
import '../../widgets/searchBar/search_bundle.dart';
import '../admin/crmBundleAdmin.dart';
import '../admin/crmPackageAdd.dart';
import '../admin/crmPckSelect.dart';
import '../admin/crnBundleOrders.dart';
import '../drawer/navDrawer.dart';
import '../ourServices/srvDetails.dart';

class SherekooBundle extends StatefulWidget {
  const SherekooBundle({Key? key}) : super(key: key);

  @override
  State<SherekooBundle> createState() => _SherekooBundleState();
}

class _SherekooBundleState extends State<SherekooBundle> {
  double clrWidht = 35;
  double clrHeight = 35;
  double clrRadius = 10;

  User currentUser = User(
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
      totalLikes: '');
  CrmPckModel pck = CrmPckModel(
      id: '',
      title: '',
      descr: '',
      status: '',
      colorCode: [],
      createdDate: '',
      inYear: '',
      pImage: '',
      colorDesigner: '');

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        getlatestPackage();
        getCrmBundle();
        getHotCrmBundle();
      });
    });
    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await UsersCall(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
  }

  getlatestPackage() {
    CrmPackage(payload: [], status: 0)
        .get(token, '$urlGetCrmPackage/status/true')
        .then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          pck = CrmPckModel.fromJson(e);
        });
      }
    });
  }

  List<Bundle> bundle = [];
  List<Bundle> bundleCrmHotBundle = [];
  getCrmBundle() async {
    CrmBundleCall(payload: [], status: 0)
        .get(token, urlGetCrmBundle)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          bundle =
              value.payload.map<Bundle>((e) => Bundle.fromJson(e)).toList();
        });
      }
    });
  }

  getHotCrmBundle() async {
    CrmBundleCall(payload: [], status: 0)
        .get(token, urlGetCrmBundleHot)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          bundleCrmHotBundle =
              value.payload.map<Bundle>((e) => Bundle.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: OColors.darGrey,
        appBar: topBar(),
        drawer: const NavDrawer(),
        body: currentUser.id != ''
            ? SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      /// Color Codes
                      ///
                      colorCode(context),
                      const SizedBox(
                        height: 16,
                      ),

                      ///
                      ///Header Hot Package
                      ///
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 8.0, bottom: 8),
                        child: Text(
                          'Hot Bundle',
                          style: header18.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      hotPackage(size),
                      const SizedBox(
                        height: 35,
                      ),

                      //Header Hot Package
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, top: 8.0, bottom: 8),
                        child: Text(
                          'Sherekoo Bundle',
                          style: header18.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      sherekooBundle(size),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: loadingFunc(40, prmry)),
                ],
              ));
  }

  ///
  /// Top Bar
  ///
  AppBar topBar() {
    return AppBar(
        backgroundColor: osec,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Buy ceremony',
              style: header16,
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(context, 'Search busness ', '', '', '');
              },
              child: Icon(
                Icons.search,
                color: OColors.white,
              ),
            ),
          ],
        ),
        actions: [
          const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          currentUser.role == 'a'
              ? GestureDetector(
                  onTap: () {
                    adminOnly();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ]);
  }

  Padding sherekooBundle(Size size) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: StaggeredGridView.countBuilder(
          //  controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          crossAxisCount: 6,
          shrinkWrap: true,
          itemCount: bundle.length,
          staggeredTileBuilder: (index) {
            return const StaggeredTile.fit(2);
          },
          itemBuilder: (BuildContext context, i) {
            final itm = bundle[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ServiceDetails(
                            crm: emptyCrmModel,
                            bundle: itm,
                            currentUser: currentUser)));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: OColors.darGrey,
                      borderRadius: BorderRadius.circular(10)),
                  // width: 135,
                  height: 135,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: fadeImg(
                            context,
                            '${api}public/uploads/sherekooAdmin/crmBundle/${itm.bImage}',
                            size.width,
                            size.height,
                            BoxFit.fill),
                      )),
                      Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                color: prmry,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                              child: Text('New',
                                  style: header12.copyWith(
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: 100,
                            height: 45,
                            color: OColors.secondary.withOpacity(.6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('${itm.price} Tsh',
                                      style: header12.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Center(
                                    child: Text('Sherekoo', style: header12)),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///
  /// Hot Bundles
  ///
  SizedBox hotPackage(Size size) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bundleCrmHotBundle.length,
          itemBuilder: (BuildContext context, i) {
            final itm = bundleCrmHotBundle[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ServiceDetails(
                            crm: emptyCrmModel,
                            bundle: itm,
                            currentUser: currentUser)));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: OColors.darGrey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 135,
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: fadeImg(
                            context,
                            '${api}public/uploads/sherekooAdmin/crmBundle/${itm.bImage}',
                            size.width,
                            size.height,
                            BoxFit.cover),
                      )),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: prmry,
                                // border: Border.all(color: osec, width: 2.5),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                              child: Text(itm.bundleType,
                                  style: header12.copyWith(
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 6),
                            width: size.width / 2.4,
                            height: 45,
                            color: OColors.secondary.withOpacity(.6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${itm.price} Tsh',
                                    style: header14.copyWith(
                                        fontWeight: FontWeight.bold)),
                                Text(itm.ownerName,
                                    style: header12.copyWith(
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///
  /// Color Codes
  ///
  Container colorCode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: OColors.secondary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
      padding:
          const EdgeInsets.only(bottom: 12.0, top: 10, left: 12, right: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Ceremony',
                        style: header15.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Colors ',
                        style: header14.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                    Text(pck.inYear,
                        style: header13.copyWith(
                          fontWeight: FontWeight.w200,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width / 2.0,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pck.colorCode.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, i) {
                    final itm = pck.colorCode[i];
                    String clrName = itm['colorName'].toString().length > 5
                        ? '${itm['colorName'].toString().substring(0, 4)}..'
                        : itm['colorName'].toString();

                    return GestureDetector(
                      onTap: () {
                        colorViewerBuilder(
                            Color(int.parse(itm['color'])),
                            clrRadius,
                            150,
                            100,
                            itm['colorName'].toString(),
                            header13);
                      },
                      child: crmColorCode(
                          context,
                          Color(int.parse(itm['color'])),
                          clrRadius,
                          clrWidht,
                          clrHeight,
                          clrName,
                          header13),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 1),
              Row(
                children: [
                  Text('createdBy',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white12,
                          fontStyle: FontStyle.italic)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(pck.colorDesigner,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: prmry,
                          fontSize: 11,
                          fontStyle: FontStyle.italic)),
                  SizedBox(
                    width: 6,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  ///
  /// Alert Widget
  ///

  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
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
              child: SearchBundle(
                currentUser: currentUser,
                inYear: pck.inYear,
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

  ///
  /// Color view
  ///
  void colorViewerBuilder(
      Color clr, double r, double w, double h, String title, TextStyle header) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 200,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            colorViewer(context, clr, r, w, h, title, header)
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }

  ///
  /// Admin only
  ///
  void adminOnly() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 250,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            ///
                            ///Add Package
                            ///
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const CrmPackageAdd()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: const Icon(Icons.add,
                                            size: 20, color: Colors.green),
                                      ),
                                      Text('Add Package', style: header14),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),

                            ///
                            /// Add bundle
                            ///
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CrmBundleAdmin(
                                                crmPackageInfo: pck,
                                              )));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, bottom: 8, right: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: const Icon(Icons.add,
                                              size: 20, color: Colors.green),
                                        ),
                                        Text('add bundle', style: header14)
                                      ],
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const CrmPckList()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: const Icon(Icons.remove_red_eye,
                                            size: 20, color: Colors.green),
                                      ),
                                      Text('View Package', style: header14),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const CrmBundleOrders()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: const Icon(Icons.book_online,
                                            size: 20, color: Colors.green),
                                      ),
                                      Text('Booking Orders', style: header14),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }
}
