import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';

import '../../model/allData.dart';
import '../../model/bigMontTvShow/bigMonth-call.dart';
import '../../model/bigMontTvShow/bigMonth-registeredMembers.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class BigMonthRegistered extends StatefulWidget {
  const BigMonthRegistered({Key? key}) : super(key: key);

  @override
  State<BigMonthRegistered> createState() => _BigMonthRegisteredState();
}

class _BigMonthRegisteredState extends State<BigMonthRegistered> {
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        getShow(urlGetBigMonthRegistration, 'all');
      });
    });
    super.initState();
  }

  List<BigMonthRegisteredModel> registered = [];

  getShow(url, tvShow) {
    BigMonthShowCall(payload: [], status: 0).get(token, url).then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          print(e);
          registered = value.payload
              .map<BigMonthRegisteredModel>(
                  (e) => BigMonthRegisteredModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
  }

  selectMembers(BuildContext context, itmid, isSelected) {
    BigMonthShowCall(payload: [], status: 0)
        .isRegistered(token, urlisSelectedInBiMonthMembers, itmid, isSelected)
        .then((value) {
      if (value.status == 200) {
        final v = value.payload;
        print('Slelected');
        setState(() {
          setState(() {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const BigMonthRegistered()));
          });

          // pck = v.map<CrmPckModel>((e) => CrmPckModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: osec,
      appBar: AppBar(
        title: const Text('Big Month '),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: registered.length,
                  itemBuilder: (context, i) {
                    final itm = registered[i];
                    return Column(
                      children: [
                        ListTile(
                          tileColor: itm.status == 'true'
                              ? Colors.red
                              : OColors.darGrey,
                          leading: SizedBox(
                            height: 60,
                            width: 70,
                            child: fadeImg(
                                context,
                                urlBigShowImg + itm.showImage,
                                size.width / 1,
                                size.height / 1.5),
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
                                    // activatePackage(context, itm);
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
                                            style:
                                                header10.copyWith(color: prmry),
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
                                      // removePackage(context, itm);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Icon(Icons.delete),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: itm.registerMembersInfo.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int x) {
                                final itm2 = itm.registerMembersInfo[x];
                                final iUser = itm2.userInfo;
                                final urlImg =
                                    '${api}public/uploads/${iUser.username!}/profile/${iUser.avater!}';

                                return itm2.id.isNotEmpty
                                    ? ListTile(
                                        leading: personProfileClipOval(
                                            context,
                                            itm2.userInfo.avater!,
                                            urlImg,
                                            const SizedBox.shrink(),
                                            20,
                                            pPbigMnthWidth,
                                            pPbigMnthHeight,
                                            prmry),
                                        title: Text(iUser.username!,
                                            style: header12),
                                        subtitle: Text(
                                          itm2.contact,
                                          style: header10,
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                        
                                            selectMembers(
                                                context, itm2.id, itm2.status);
                                          },
                                          child: Column(
                                            children: [
                                              itm2.status == '0'
                                                  ? Container(
                                                      width: 85,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: prmry)),
                                                      child: Center(
                                                        child: Text('Select',
                                                            style: header13),
                                                      ))
                                                  : Container(
                                                      width: 85,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: prmry)),
                                                      child: Center(
                                                        child: Text('Selected',
                                                            style: header13
                                                                .copyWith(
                                                                    color:
                                                                        prmry)),
                                                      )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Text('No REgistered', style: header14);
                              }),
                        ),
                      ],
                    );
                    ;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
