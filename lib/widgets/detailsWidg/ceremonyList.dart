import 'package:flutter/material.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../model/services/ServicesModelModel.dart';
import '../../screens/detailScreen/livee.dart';
import '../../util/util.dart';

class CeremonyList extends StatelessWidget {
  const CeremonyList({
    Key? key,
    required this.service,
  }) : super(key: key);

  final List<ServicesModel> service;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
                              youtubeLink: '',
                            ))));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Card(
                  child: Column(
                    children: [
                      service[index].cImage != ''
                          ? ClipRRect(
                              child: Center(
                                child: FadeInImage(
                                  height: 55,
                                  image: NetworkImage(api +
                                      'public/uploads/' +
                                      service[index].fIdUname +
                                      '/ceremony/' +
                                      service[index].cImage),
                                  // fadeInDuration:
                                  //     const Duration(
                                  //         milliseconds:
                                  //             100),
                                  placeholder: const AssetImage(
                                      'assets/logo/noimage.png'),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/logo/noimage.png',
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(service[index].cName,
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 4),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.remove_red_eye,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text('134',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.message,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('25k',
                                      style: TextStyle(
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
    );
  }
}
