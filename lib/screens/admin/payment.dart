import 'package:flutter/material.dart';
import 'package:sherekoo/model/user/userModel.dart';

import '../../model/ceremony/crm-model.dart';
import '../../model/requests/requestsModel.dart';
import '../../model/services/service-call.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import 'crmAdmin.dart';

class MyService extends StatefulWidget {
  final RequestsModel req;
  final User user;
  const MyService({Key? key, required this.req,required this.user}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String imgUrl = '';

  @override
  void initState() {
    super.initState();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        imgUrl =
            '${api}public/uploads/${widget.req.bsnInfo!.user.username}/busness/${widget.req.bsnInfo!.coProfile}';
     
      });
    });
  }



  addservices(bsnId, crmId, requestId, payedStatus) async {
    ServicesCall(
            svId: '',
            busnessId: bsnId,
            hId: '',
            payed: '',
            ceremonyId: crmId,
            createdBy: '',
            status: 0,
            payload: [],
            type: '')
        .addService(token, urlPostService, requestId, payedStatus)
        .then((value) {
      if (value.status == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CrmnAdmin(
                    crm: CeremonyModel(
                        cId: widget.req.ceremonyId!,
                        codeNo: '',
                        ceremonyType: '',
                        cName: '',
                        fId: '',
                        sId: '',
                        cImage: '',
                        ceremonyDate: '',
                        contact: '',
                        admin: '',
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
                        youtubeLink: ''), user: widget.user,)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: Text('Service Payment',
              style: header16.copyWith(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          actions: const [NotifyWidget()],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  //wallet Profile
                  GestureDetector(
                    onTap: () {
                      //Mchango directory
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 8),
                            child: Row(
                              children: [
                                //Avater
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: OColors.secondary,
                                  ),
                                  child: widget.user.avater != ''
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: UserAvater(
                                              avater: widget.user.avater!,
                                              url: '/profile/',
                                              username: widget.user.username!,
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          ))
                                      : const ClipOval(
                                          child: DefaultAvater(
                                              height: 45,
                                              radius: 35,
                                              width: 45)),
                                ),

                                //username && Followers
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Username
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          '@${widget.user.username}',
                                          style: header12,
                                        ),
                                      ),

                                      //Fan
                                      Text(
                                        widget.user.whatYouDo!,
                                        style: header10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 15.0),
                            child: Column(
                              children: [
                                Text('Mchango',
                                    style: TextStyle(color: OColors.fontColor)),
                                Text('2,000,000 Tsh',
                                    style: TextStyle(
                                        color: OColors.fontColor,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: OColors.darGrey,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0))),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              widget.req.bsnInfo!.busnessType,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 19),
                            ),
                          ),

                          // Busness Profile
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 10, bottom: 8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                fadeImg(context, imgUrl, 100.0, 100.0),

                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.req.bsnInfo!.knownAs,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        widget.req.bsnInfo!.price,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),

                          const Spacer(),
                          // footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addservices(
                                      widget.req.busnessId,
                                      widget.req.ceremonyId,
                                      widget.req.hostId,
                                      '0');
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: OColors.primary),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Select',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: OColors.primary),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Payment',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
