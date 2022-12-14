import 'package:flutter/material.dart';
import 'package:sherekoo/screens/crmScreen/Crm.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';

class CrmCategoriesWidget extends StatefulWidget {
  final String dataType;
  final String title;
  final double heights;

  final int crossAxisCountx;
  final String hotStatus;
  // final CeremonyModel ceremony;

  const CrmCategoriesWidget(
      {Key? key,
      // required this.ceremony,
      required this.dataType,
      required this.title,
      required this.heights,
      required this.crossAxisCountx,
      required this.hotStatus})
      : super(key: key);

  @override
  State<CrmCategoriesWidget> createState() => _CrmCategoriesWidgetState();
}

class _CrmCategoriesWidgetState extends State<CrmCategoriesWidget> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<CeremonyModel> data = [];

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
       isCrmAdmin:'',
      isInFuture: '',
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
      youtubeLink: '');
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
    super.initState();
  }

  getAll() async {
    CrmCall(payload: [], status: 0)
        .getCeremonyByType(token, urlGetCrmByType, widget.dataType)
        .then((value) {
      if (mounted) {
        if (value.status == 200) {
          setState(() {
            data = value.payload
                .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
                .toList();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Top Header
        Row(
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
                style: TextStyle(color: OColors.titleColor),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Crm(dataType: widget.dataType)));
              },
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 5,
                  right: 15,
                ),
                child: Text(
                  'All',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),

        //Body
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 80,
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
                                        Livee(ceremony: ceremony)));
                          },
                          child: Column(children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(1.0),
                                  topRight: Radius.circular(1.0),
                                ),
                                child: data[index].cImage != ''
                                    ? Image.network(
                                        '${api}public/uploads/${data[index].userFid.username}/ceremony/${data[index].cImage}',
                                        fit: BoxFit.cover,
                                        height: 45,
                                      )
                                    : const SizedBox(height: 1)),
                            Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(top: 1),
                              child: Center(
                                child: Text(
                                  data[index].cName,
                                  overflow: TextOverflow.clip,
                                  style: ctrgText.copyWith(
                                      color: OColors.textColor),
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
