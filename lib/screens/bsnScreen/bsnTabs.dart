import 'package:flutter/material.dart';

import '../../model/allData.dart';
import '../../model/busness/allBusness.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../detailScreen/DetailPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BsnTab extends StatefulWidget {
  final String bsnType;
  final CeremonyModel ceremony;
  const BsnTab({Key? key, required this.bsnType, required this.ceremony})
      : super(key: key);

  @override
  _BsnTabState createState() => _BsnTabState();
}

class _BsnTabState extends State<BsnTab> {
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
    u2g: '',
  );

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAllBusness();
      });
    });

    // print('cehek on bsn mc Tabs');
    // print(widget.ceremony.codeNo);
    super.initState();
  }

  getAllBusness() async {
    if (widget.bsnType != 'all') {
      AllBusnessModel(payload: [], status: 0)
          .onBusnessType(token, urlBusnessByType, widget.bsnType)
          .then((value) {
        setState(() {
          // print(value.payload);
          data = value.payload.map<BusnessModel>((e) {
            return BusnessModel.fromJson(e);
          }).toList();

          // print(data);
        });
      });
    } else {
      AllUsersModel(payload: [], status: 0)
          .get(token, urlAllBusnessList)
          .then((value) {
        setState(() {
          data = value.payload.map<BusnessModel>((e) {
            return BusnessModel.fromJson(e);
          }).toList();

          // print(data);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          itemCount: data.length,
          // staggeredTileBuilder: (int index) =>
          //     StaggeredTile.fit(index == 0 ? 2 : 1),
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          crossAxisCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => BsnDetails(
                                  data: data[index],
                                  ceremonyData: widget.ceremony)));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Background Image
                          Stack(children: [
                            // Image(
                            //   image: AssetImage(data[index].coProfile),
                            // ),

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
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(height: 1)),

                            Positioned(
                                top: 1,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        data[index].busnessType,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )))
                          ]),
                          //Details
                          const SizedBox(height: 5.0),

                          Container(
                            alignment: Alignment.center,
                            // padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              data[index].price + ' Tsh',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              data[index].knownAs,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ),

                          const SizedBox(height: 3.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, bottom: 4.0),
                                child: Row(children: const [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.grey,
                                  )
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 8.0, bottom: 4.0),
                                child: Row(children: const [
                                  Icon(
                                    Icons.heart_broken,
                                    size: 16,
                                    color: Colors.red,
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )));
          },
          staggeredTileBuilder: (index) {
            return const StaggeredTile.fit(2);
          }),
    );
  }
}
