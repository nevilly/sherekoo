import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';

import '../../model/ceremony/crm-model.dart';
import '../../model/services/servicexModel.dart';
import '../../model/user/userModel.dart';
import '../../screens/detailScreen/livee.dart';
import '../../util/util.dart';

class CeremonyList extends StatelessWidget {
  const CeremonyList({
    Key? key,
    required this.service,
  }) : super(key: key);

  final List<ServicexModel> service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (service.isNotEmpty)
          // Header: Ceremony List.
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ceremony List',
                      style: header14,
                    ),
                    IconButton(
                        icon: const Icon(Icons.more_horiz),
                        color: OColors.primary,
                        iconSize: 20.0,
                        onPressed: () {
                          otherCeremony(context);
                        })
                  ],
                )),
          ),
        if (service.isNotEmpty)
          SizedBox(
            height: 110,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: service.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  final itm = service[index];
                  final ib = itm.bsnInfo!;
                  final ic = itm.crmInfo!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Livee(ceremony: crmMdl(index))));
                    },
                    child: Container(
                      color: OColors.darGrey,
                      child: Column(
                        children: [
                          ic.cImage != ''
                              ? ClipRRect(
                                  child: Center(
                                    child: Image.network(
                                      '${api}public/uploads/${ic.userFid.username}/ceremony/${ic.cImage}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9.5,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 4,
                          ),

                          // Details
                          ic.cName.length >= 4
                              ? Text(
                                  '${service[index].crmInfo!.cName.substring(0, 4)}..',
                                  style: TextStyle(
                                      color: OColors.fontColor,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold))
                              : Text(ic.userFid.username!,
                                  style: TextStyle(
                                      color: OColors.fontColor,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 4),
                            child: Text(ic.ceremonyDate,
                                style: header10),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
      ],
    );
  }

  CeremonyModel crmMdl(int index) {
    return CeremonyModel(
      cId: service[index].crmInfo!.cId,
      codeNo: service[index].crmInfo!.codeNo,
      ceremonyType: service[index].crmInfo!.ceremonyType,
      cName: service[index].crmInfo!.codeNo,
      fId: '',
      sId: '',
      cImage: service[index].crmInfo!.cImage,
      ceremonyDate: '',
      admin: '',
      contact: '',
      isCrmAdmin: '',
      likeNo: '',
      chatNo: '',
      viwersNo: '',
      isInFuture: '',
      userFid: User(
          id: '',
          username: '',
          firstname: service[index].crmInfo!.userFid.username,
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
  }

  Future<dynamic> otherCeremony(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            // color: OColors.secondary,
            height: 460,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Center(
                          child: Text('Our Ceremony',
                              style: header14.copyWith(
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: GridView.builder(
                            itemCount: service.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              // childAspectRatio: 0.9
                            ),
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              Livee(ceremony: crmMdl(index))));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: OColors.darGrey,
                                    // borderRadius:
                                    //     BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Column(
                                    children: [
                                      service[index].crmInfo!.cImage != ''
                                          ? ClipRRect(
                                              child: Center(
                                                child: Image.network(
                                                  '${api}public/uploads/${service[index].crmInfo!.userFid.username}/ceremony/${service[index].crmInfo!.cImage}',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      9.5,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 4,
                                      ),

                                      // Details
                                      service[index].crmInfo!.cName.length >= 4
                                          ? Text(
                                              '${ service[index].crmInfo!.cName.substring(0, 4)}..',
                                              style: TextStyle(
                                                  color: OColors.fontColor,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold))
                                          : Text(service[index].crmInfo!.userFid.username!,
                                              style: TextStyle(
                                                  color: OColors.fontColor,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 4),
                                        child: Text(service[index].crmInfo!.ceremonyDate,
                                            style: header10),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
