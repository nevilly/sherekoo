import 'package:flutter/material.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../screens/bsnScreen/bsn-screen.dart';
import '../../screens/detailScreen/bsn-details.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class BusnessLst extends StatelessWidget {
  const BusnessLst({
    Key? key,
    required this.data,
    required this.otherBsn,
    required this.ceremony,
  }) : super(key: key);

  final BusnessModel data;
  final List<BusnessModel> otherBsn;
  final CeremonyModel ceremony;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Other Busness Type
        if (otherBsn.isNotEmpty)

          // Header: Other Busness
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Other ${data.busnessType}',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // fontStyle: FontStyle.italic,
                          color: OColors.fontColor),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: Container(
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey, width: 2),
                    //         borderRadius: BorderRadius.circular(50),
                    //       ),
                    //       child: Icon(
                    //         Icons.more_horiz_rounded,
                    //         size: 15,
                    //         color: OColors.fontColor,
                    //       )),
                    // ),

                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: OColors.primary,
                        iconSize: 20.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BusnessScreen(
                                        bsnType: data.busnessType,
                                        ceremony: ceremony,
                                      )));
                        })
                  ],
                )),
          ),

        if (otherBsn.isNotEmpty)
          SizedBox(
            // color: OColors.darGrey,
            height: 95,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: otherBsn.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BsnDetails(
                                    data: otherBsn[index],
                                    ceremonyData: ceremony,
                                  )));
                    },
                    child: Container(
                      // width: 100,
                      // height: 100,
                      color: OColors.darGrey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 25.0,
                                child: ClipOval(
                                    child: otherBsn[index].coProfile != ''
                                        ? Image.network(
                                            '${api}public/uploads/${otherBsn[index].user.username}/busness/${otherBsn[index].coProfile}',
                                            fit: BoxFit.cover,
                                            width: 90.0,
                                            height: 90.0,
                                          )
                                        : Image.asset(
                                            'assets/logo/noimage.png',
                                            fit: BoxFit.fitWidth,
                                            width: 90.0,
                                            height: 90.0,
                                          )),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(otherBsn[index].knownAs,
                                style: const TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
      ],
    );
  }
}
