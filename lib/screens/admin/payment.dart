import 'package:flutter/material.dart';
import 'package:sherekoo/model/userModel.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../model/requests/requestsModel.dart';
import '../../model/services/postServices.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import 'crmAdmin.dart';

class MyService extends StatefulWidget {
  final RequestsModel req;
  const MyService({Key? key, required this.req}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  final Preferences _preferences = Preferences();

  String token = '';

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });
  }

  addservices(bsnId, crmId, requestId, payedStatus) async {
    Services(
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
                          likeNo:'',
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
                        youtubeLink: ''))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          title: const Text('My Service'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 18.0),
                  child: Column(
                    children: [
                      Text('My Wallet',
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
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.req.ceremonyId!,
                style: const TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),

            // Busness Profile
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    '${api}public/uploads/${widget.req.bsnInfo!.user.username}/busness/${widget.req.bsnInfo!.coProfile}',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Text(
                          widget.req.bsnInfo!.knownAs,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.req.bsnInfo!.price,
                          style: const TextStyle(color: Colors.white),
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
                    addservices(widget.req.busnessId, widget.req.ceremonyId,
                        widget.req.hostId, '0');
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
        ));
  }
}
