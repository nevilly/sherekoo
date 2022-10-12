import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/gradientBorder.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/scrollText.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live',
                  style: header14.copyWith(fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 4),
                child: Icon(
                  Icons.live_tv,
                  size: 20,
                  color: OColors.primary,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 80.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todayCrm.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6),
                child: SizedBox(
                  width: 65,
                  // color: OColors.darGrey,
                  child: Column(
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
                        child: todayCrm[index].cImage != ''
                            ? LiveBorder(
                                live: liveBar(),
                                radius: 30,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    '${api}public/uploads/${todayCrm[index].userFid.username}/ceremony/${todayCrm[index].cImage}',
                                  ),
                                ))
                            : const SizedBox(height: 1),
                      ),

                      //Details Ceremony
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Livee(ceremony: todayCrm[index])));
                        },
                        child: todayCrm[index].codeNo.length >= 8
                            ? SizedBox(
                                height: 20,
                                width: 70,
                                child: ScrollingText(
                                  text: todayCrm[index].codeNo,
                                  textStyle: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ))
                            : Text(todayCrm[index].codeNo,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Positioned liveBar() {
    return Positioned(
      bottom: 0,
      left: 4,
      width: 49,
      height: 15,
      child: Container(
          padding: const EdgeInsets.only(left: 3.5, right: 3.5),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OColors.primary2,
                  OColors.primary,
                  Colors.red,
                ],
              ),
              color: OColors.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(width: 4),
              Icon(Icons.live_tv, size: 13, color: OColors.fontColor),
              const SizedBox(width: 5),
              Text(
                'live',
                style: header10,
              )
            ],
          )),
    );
  }
}
