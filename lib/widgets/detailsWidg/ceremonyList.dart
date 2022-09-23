import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../model/services/svModel.dart';
import '../../model/userModel.dart';
import '../../screens/detailScreen/livee.dart';
import '../../util/util.dart';

class CeremonyList extends StatelessWidget {
  const CeremonyList({
    Key? key,
    required this.service,
  }) : super(key: key);

  final List<SvModel> service;

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
                      'List Ceremon Host',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: OColors.fontColor),
                    ),
                    IconButton(
                        icon: const Icon(Icons.more_horiz),
                        color: OColors.primary,
                        iconSize: 30.0,
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Livee(
                                      ceremony: CeremonyModel(
                                    cId: service[index].cId,
                                    codeNo: service[index].codeNo,
                                    ceremonyType: service[index].ceremonyType,
                                    cName: service[index].codeNo,
                                    fId: '',
                                    sId: '',
                                    cImage: service[index].cImage,
                                    ceremonyDate: '',
                                    admin: '',
                                    contact: '',
                                       userFid: User(id: '', username: '', firstname: service[index].fIdUname, lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
                        userSid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
                               
                                    youtubeLink: '',
                                  ))));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        color: OColors.darGrey,
                        child: Column(
                          children: [
                            service[index].cImage != ''
                                ? ClipRRect(
                                    child: Center(
                                      child: Image.network(
                                        '${api}public/uploads/${service[index].fIdUname}/ceremony/${service[index].cImage}',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                9.5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 4,
                            ),
                            service[index].cName.length >= 4
                                ? Text(
                                    '${service[index].cName.substring(0, 4)}..',
                                    style: TextStyle(
                                        color: OColors.fontColor,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold))
                                : Text(service[index].fIdUname,
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
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          size: 15,
                                          color: OColors.primary,
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        Text('134',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: OColors.fontColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.message,
                                          size: 15,
                                          color: OColors.primary,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text('25k',
                                            style: TextStyle(
                                                color: OColors.fontColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
      ],
    );
  }

  Future<dynamic> otherCeremony(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 460,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const Center(
                          child: Text('Participate Ceremony',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 290,
                        child: ListView.builder(
                            itemCount: service.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(left: 8, right: 8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          bottomLeft: Radius.circular(5.0)),
                                      child: service[index].cImage != ''
                                          ? ClipRRect(
                                              child: Center(
                                                child: FadeInImage(
                                                  height: 55,
                                                  image: NetworkImage(
                                                      '${api}public/uploads/${service[index].fIdUname}/ceremony/${service[index].cImage}'),
                                                  // fadeInDuration:
                                                  //     const Duration(
                                                  //         milliseconds:
                                                  //             100),
                                                  placeholder: const AssetImage(
                                                      'assets/logo/noimage.png'),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/logo/noimage.png',
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 4,
                                      ),
                                      child: Column(children: [
                                        Text(service[index].cName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54)),
                                        Text(service[index].busnessType,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                color: Colors.black54))
                                      ]),
                                    )
                                  ],
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
