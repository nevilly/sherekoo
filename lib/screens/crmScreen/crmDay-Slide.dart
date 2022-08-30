import 'package:flutter/material.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/util.dart';
import '../detailScreen/livee.dart';
import 'crmDoor.dart';

class CrmSlide extends StatelessWidget {
  const CrmSlide({
    Key? key,
    required this.todayCrm,
  }) : super(key: key);

  final List<CeremonyModel> todayCrm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
          child: Text('Live Ceremony'),
        ),
        SizedBox(
          height: 64.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todayCrm.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.red)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CrmDoor(
                                            crm: todayCrm[index],
                                          )));
                            },
                            child: ClipRRect(
                              child: todayCrm[index].cImage != ''
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        api +
                                            'public/uploads/' +
                                            todayCrm[index].u1 +
                                            '/ceremony/' +
                                            todayCrm[index].cImage,
                                      ),
                                    )
                                  : const SizedBox(height: 1),
                            ),
                          ),

                          //Details Ceremony
                          Column(
                            children: [
                              const SizedBox(
                                height: 1.0,
                              ),

                              // Title
                              Container(
                                margin: const EdgeInsets.only(top: 1),
                                child: Text(
                                    todayCrm[index].ceremonyType.toUpperCase(),
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Livee(
                                              ceremony: todayCrm[index])));
                                },
                                child: Container(
                                    margin:
                                        const EdgeInsets.only(top: 5, left: 5),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(105)),
                                    child: Text(
                                      todayCrm[index].codeNo,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
