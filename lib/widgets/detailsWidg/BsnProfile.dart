import 'package:flutter/material.dart';
import 'package:sherekoo/screens/bsnScreen/adminBsn.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/userModel.dart';
import '../../screens/detailScreen/DetailPage.dart';
import '../../screens/subscriptionScreen/hiringPage.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class BusnessProfile extends StatelessWidget {
  const BusnessProfile(
      {Key? key, required this.data, required this.widget, required this.user})
      : super(key: key);

  final BusnessModel data;
  final BsnDetails widget;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///
        /// Busness Picture
        ///
        ClipRRect(
          child: Center(
              child: data.coProfile != ''
                  ? Image.network(
                      '${api}public/uploads/${data.user.username}/busness/${data.coProfile}',
                      height: 165,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 1)),
        ),

        ///
        /// Only Admin Button
        ///

        Positioned(
          top: 5,
          right: 0,
          child: data.createdBy == user.id || data.ceoId == user.id
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AdminBsn(
                                  bsn: data,
                                )));
                  },
                  child: Container(
                    // width: 30,
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
                        "Admin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: OColors.fontColor),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),

        ///
        /// Busness Name
        /// && Hiring Buuton
        ///

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
                    color: Color.fromARGB(137, 235, 211, 211),
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

                ///
                ///Hire Button
                ///
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
