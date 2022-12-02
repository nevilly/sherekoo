import 'package:flutter/material.dart';
import 'package:sherekoo/screens/ourServices/mshengaWar-TvShow.dart';
import 'package:sherekoo/util/colors.dart';
import '../../model/bigMontTvShow/bigMonth-Model.dart';
import '../../model/bigMontTvShow/bigMonth-call.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class BigMonthShowList extends StatefulWidget {
  const BigMonthShowList({Key? key}) : super(key: key);

  @override
  State<BigMonthShowList> createState() => _BigMonthShowListState();
}

class _BigMonthShowListState extends State<BigMonthShowList> {
  List<BigMonthModel> shows = [];

  BigMonthModel show = BigMonthModel(
      id: '',
      title: '',
      description: '',
      season: '',
      episode: '',
      showImage: '',
      dedline: '',
      showDate: '',
      judgesId: '',
      superStarsId: '',
      status: '',
      isRegistered: '',
      judgesInfo: [
        User(
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
            totalLikes: '')
      ],
      superStarInfo: [
        User(
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
            totalLikes: '')
      ],
      createdDate: '');

  String tvShow = '';

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getShow(urlGetBigMonth, 'all');
        // getCrmBundle();
      });
    });
    super.initState();
  }

  String itmstatus = '';

  getShow(url, tvShow) {
    BigMonthShowCall(payload: [], status: 0).get(token, url).then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          // print(e);
          if (tvShow == 'new') {
            show = BigMonthModel.fromJson(e);
          } else {
            shows = value.payload
                .map<BigMonthModel>((e) => BigMonthModel.fromJson(e))
                .toList();
          }
        });
      }
    });
  }

  activatePackage(
    BuildContext context,
    BigMonthModel itm,
  ) {
    BigMonthShowCall(payload: [], status: 0)
        .isActive(token, urlActivateGigMonthList, itm.id, itm.status)
        .then((value) {
      if (value.status == 200) {

        setState(() {
          setState(() {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const BigMonthShowList()));
          });

          // pck = v.map<CrmPckModel>((e) => CrmPckModel.fromJson(e)).toList();
        });
      }
    });
  }

  removePackage(
    BuildContext context,
    BigMonthModel itm,
  ) {
    BigMonthShowCall(payload: [], status: 0)
        .removeShow(token, urlRemoveBigMonthList, itm.id, itm.status)
        .then((value) {
      if (value.status == 200) {

        setState(() {
          setState(() {
            shows.remove(itm);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: osec,
      appBar: AppBar(
        backgroundColor: osec,
        title: const Text('Mshenga Shows'),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MshengaWarTvShow(
                              from: '',
                            )));
              },
              child: flatButton(
                  context, 'Show', header14, 50, 90, prmry, 10, 10, 10))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: shows.length,
                itemBuilder: (BuildContext context, i) {
                  final itm = shows[i];

                  return ListTile(
                    tileColor:
                        itm.status == 'true' ? Colors.red : OColors.darGrey,
                    leading: SizedBox(
                      height: 60,
                      width: 70,
                      child: fadeImg(context, urlBigShowImg + itm.showImage,
                          size.width / 1, size.height / 1.5),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'SE ${itm.season}',
                          style: header13,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'EP ${itm.episode}',
                          style: header13,
                        )
                      ],
                    ),
                    subtitle: Text(itm.showDate,
                        style: header11.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    trailing: Container(
                      width: 95,
                      color: fntClr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              activatePackage(context, itm);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: itm.status == 'true'
                                  ? Text('true',
                                      style: header10.copyWith(
                                        color: OColors.darGrey,
                                      ))
                                  : Text(
                                      'false',
                                      style: header10.copyWith(color: prmry),
                                    ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             AddMshengaWarTvShow(
                                //               show: itm,
                                //             )));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.edit),
                              )),
                          GestureDetector(
                              onTap: () {
                                removePackage(context, itm);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(Icons.delete),
                              )),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
