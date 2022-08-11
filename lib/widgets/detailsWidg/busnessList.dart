import 'package:flutter/material.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../screens/bsnScreen/bsnScrn.dart';
import '../../screens/detailScreen/DetailPage.dart';
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
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Other ' + data.busnessType,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.more_horiz,
                      ),
                      color: Colors.blueGrey,
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
          height: 120,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: otherBsn.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 15.0,
                                  child: ClipOval(
                                      child: Image.network(
                                    api +
                                        'public/uploads/' +
                                        otherBsn[index].username +
                                        '/busness/' +
                                        otherBsn[index].coProfile,
                                    fit: BoxFit.cover,
                                    width: 90.0,
                                    height: 90.0,
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(otherBsn[index].knownAs,
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
