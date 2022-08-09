import 'package:flutter/material.dart';
import 'package:sherekoo/screens/bsnScreen/bsnScrn.dart';

import '../../model/busness/allBusness.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../screens/detailScreen/DetailPage.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class CategoryBody extends StatefulWidget {
  final String busnessType;
  final String title;
  final double heights;

  final int crossAxisCountx;
  final String hotStatus;
  final CeremonyModel ceremony;

  const CategoryBody(
      {Key? key,
      required this.ceremony,
      required this.busnessType,
      required this.title,
      required this.heights,
      required this.crossAxisCountx,
      required this.hotStatus})
      : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
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
  String bsnType = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAll();
      });
    });
    bsnType = widget.busnessType;
    super.initState();
  }

  getAll() async {
    AllBusnessModel(payload: [], status: 0)
        .onBusnessType(token, urlBusnessByType, widget.busnessType)
        .then((value) {
      setState(() {
        data = value.payload.map<BusnessModel>((e) {
          return BusnessModel.fromJson(e);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Top Header
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 5,
                  left: 10,
                ),
                child: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BusnessScreen(
                              bsnType: widget.busnessType,
                              ceremony: ceremony)));
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 5,
                    right: 25,
                  ),
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Body
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: widget.heights,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCountx),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BsnDetails(
                                          data: data[index],
                                          ceremonyData: widget.ceremony,
                                        )));
                          },
                          child: Column(children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(1.0),
                                  topRight: Radius.circular(1.0),
                                ),
                                child: data[index].coProfile != ''
                                    ? Image.network(
                                        api +
                                            'public/uploads/' +
                                            data[index].username +
                                            '/busness/' +
                                            data[index].coProfile,
                                        height: 45,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(height: 1)),
                            Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(top: 1),
                              child: Center(
                                child: Text(
                                  data[index].knownAs,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ));
                  })),
        ), //Top Header
      ],
    );
  }
}
