import 'package:flutter/material.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/userModel.dart';
import '../../screens/detailScreen/bsn-details.dart';
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
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 1)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, left: 4, right: 4, bottom: 4),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data.busnessType}: ', style: header13),
                          Text(data.knownAs,
                              style: header13.copyWith(
                                  fontWeight: FontWeight.w400)),
                        ]),
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
                                  busness: widget.data,
                                  ceremony: widget.ceremonyData,
                                  user: user,
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
