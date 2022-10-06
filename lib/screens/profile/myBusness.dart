import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/allBusness.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';
import '../detailScreen/DetailPage.dart';
import '../uploadScreens/busnessUpload.dart';

class MyBusness extends StatefulWidget {
  final User user;
  const MyBusness({Key? key, required this.user}) : super(key: key);

  @override
  State<MyBusness> createState() => _MyBusnessState();
}

class _MyBusnessState extends State<MyBusness> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<BusnessModel> myBsn = [];

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
   userFid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
                        userSid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
    youtubeLink: '',
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

    super.initState();
  }

  getAllBusness() async {
    AllBusnessModel(payload: [], status: 0)
        .bsnByCreatorid(token, urlMyBsnByCratorId, widget.user.id!)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          // print(value.payload);
          myBsn = value.payload.map<BusnessModel>((e) {
            return BusnessModel.fromJson(e);
          }).toList();

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: myBsn.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: prefer_is_empty
            child: myBsn.length > 0
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: OColors.danger)),
                            child: Row(
                              children: [
                                // Busness Image
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BsnDetails(
                                                data: myBsn[index],
                                                ceremonyData: ceremony)));
                                  },
                                  child: ClipRRect(
                                    child: Center(
                                        child: myBsn[index].coProfile != ''
                                            ? Image.network(
                                                '${api}public/uploads/${myBsn[index].user.username}/busness/${myBsn[index].coProfile}',
                                                height: 60,
                                                width: 65,
                                                fit: BoxFit.cover,
                                              )
                                            : const SizedBox(height: 1)),
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                //Details Ceremony
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: myBsn[index].companyName,
                                              style: h4.copyWith(
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                      ),
                                    ),
                                    // Title
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                          myBsn[index]
                                              .busnessType
                                              .toUpperCase(),
                                          style: h5),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          widget.user.isCurrentUser == false
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BusnessUpload(
                                                  getData: myBsn[index],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: OColors.primary),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 10,
                                            bottom: 5,
                                            top: 5),
                                        child: Text(
                                          'Edit',
                                          style: h4.copyWith(
                                              color: OColors.primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BsnDetails(
                                                data: myBsn[index],
                                                ceremonyData: ceremony)));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: OColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(105)),
                                      child: Text(
                                        '${myBsn[index].price}/Tsh',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(105)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'No Busness',
                            style: text.copyWith(
                                color: OColors.textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
          );
        },
      ),
    );
  }
}
