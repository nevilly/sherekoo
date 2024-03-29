import 'package:flutter/material.dart';

import '../../model/user/user-call.dart';
import '../../model/busness/bsn-call.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../detailScreen/bsn-details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../uploadScreens/busnessUpload.dart';

class BsnTab extends StatefulWidget {
  final String bsnType;
  final CeremonyModel ceremony;
  const BsnTab({Key? key, required this.bsnType, required this.ceremony})
      : super(key: key);

  @override
  BsnTabState createState() => BsnTabState();
}

class BsnTabState extends State<BsnTab> {
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
    isInFuture: '',
    isCrmAdmin: '',
    likeNo: '',
    chatNo: '',
    viwersNo: '',
    userFid: User(
        id: '',
        username: '',
        firstname: '',
        lastname: '',
        avater: '',
        phoneNo: '',
        email: '',
        gender: '',
        role: '',
        address: '',
        meritalStatus: '',
        bio: '',
        totalPost: '',
        isCurrentUser: '',
        isCurrentCrmAdmin: '',
        isCurrentBsnAdmin: '',
        totalFollowers: '',
        totalFollowing: '',
        totalLikes: ''),
    userSid: User(
        id: '',
        username: '',
        firstname: '',
        lastname: '',
        avater: '',
        phoneNo: '',
        email: '',
        gender: '',
        role: '',
        address: '',
        meritalStatus: '',
        bio: '',
        totalPost: '',
        isCurrentUser: '',
        isCurrentCrmAdmin: '',
        isCurrentBsnAdmin: '',
        totalFollowers: '',
        totalFollowing: '',
        totalLikes: ''),
    youtubeLink: '',
  );

  late User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: null,
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAllBusness(widget.bsnType);
      });
    });

    getUser();
    super.initState();
  }

  getUser() async {
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
  }

  getAllBusness(arg) async {
    if (arg != 'all') {
      BsnCall(payload: [], status: 0)
          .onGoldenBusness(token, urlGoldBusness, widget.bsnType, '')
          .then((value) {
        if (value.status == 200) {
          setState(() {
            // print(value.payload);
            data = value.payload.map<BusnessModel>((e) {
              return BusnessModel.fromJson(e);
            }).toList();
          });
        }
      });
    } else {
      UsersCall(payload: [], status: 0)
          .get(token, urlAllBusnessList)
          .then((value) {
        if (value.status == 200) {
          setState(() {
            data = value.payload.map<BusnessModel>((e) {
              return BusnessModel.fromJson(e);
            }).toList();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      body: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          itemCount: data.length,
          // staggeredTileBuilder: (int index) =>
          //     StaggeredTile.fit(index == 0 ? 2 : 1),
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          crossAxisCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
                child: Card(
              child: ColoredBox(
                color: OColors.darGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //BackgroundImage & Busness Type
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BsnDetails(
                                    data: data[index],
                                    ceremonyData: widget.ceremony)));
                      },
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(1.0),
                              topRight: Radius.circular(1.0),
                            ),
                            child: data[index].coProfile != ''
                                ? Image.network(
                                    '${api}${data[index].mediaUrl}',
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
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
                    ),

                    //Details
                    const SizedBox(height: 5.0),

                    // Price Display
                    Container(
                      alignment: Alignment.center,
                      // padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${data[index].price} Tsh',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: OColors.fontColor),
                      ),
                    ),
                    const SizedBox(height: 3.0),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        data[index].knownAs,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: OColors.fontColor),
                      ),
                    ),

                    const SizedBox(height: 3.0),
                    // Rate Stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          child: Row(children: [
                            starsIcons(Colors.red),
                            starsIcons(Colors.red),
                            starsIcons(Colors.red),
                            starsIcons(Colors.grey),
                            starsIcons(Colors.grey),
                          ]),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(right: 8.0, bottom: 4.0),
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

                    currentUser.id == data[index].ceoId
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BusnessUpload(
                                            getData: data[index],
                                          )));
                            },
                            child: Container(
                              height: 30,
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: OColors.danger,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Edit ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ));
          },
          staggeredTileBuilder: (index) {
            return const StaggeredTile.fit(2);
          }),
    );
  }

  Icon starsIcons(Color color) {
    return Icon(
      Icons.star,
      size: 16,
      color: color,
    );
  }
}
