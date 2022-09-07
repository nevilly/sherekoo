import 'package:flutter/material.dart';

import '../../model/busness/busnessModel.dart';
import '../../screens/detailScreen/DetailPage.dart';
import '../../screens/subscriptionScreen/hiringPage.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class BusnessProfile extends StatelessWidget {
  const BusnessProfile({
    Key? key,
    required this.data,
    required this.widget,
  }) : super(key: key);

  final BusnessModel data;
  final BsnDetails widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: Center(
              child: data.coProfile != ''
                  ? Image.network(
                      '${api}public/uploads/${data.username}/busness/${data.coProfile}',
                      height: 165,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 1)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // margin: const EdgeInsets.only(top: 135, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8, right: 10, bottom: 8),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${data.busnessType}: ',
                          style: TextStyle(
                              color: OColors.fontColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: data.knownAs,
                          style: TextStyle(color: OColors.fontColor)),
                    ])),
                  ),
                ),
                //Hire Me Botton
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HiringPage(
                                  busness: data,
                                  ceremony: widget.ceremonyData,
                                )));
                  },
                  child: Container(
                    width: 65,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: OColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Hire",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: OColors.fontColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
