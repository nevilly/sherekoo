import 'package:flutter/material.dart';

import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../detailScreen/livee.dart';

class MyCrmn extends StatefulWidget {
  final String userId;
  const MyCrmn({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyCrmn> createState() => _MyCrmnState();
}

class _MyCrmnState extends State<MyCrmn> {
  final Preferences _preferences = Preferences();

  String token = '';

  List<CeremonyModel> myCeremony = [];
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        getAllCeremony(widget.userId);
      });
    });
    super.initState();
  }

  getAllCeremony(id) async {
    AllCeremonysModel(payload: [], status: 0)
        .getDayCeremony(token, urlGetCeremonyByUserId, id)
        .then((value) {
      setState(() {
        myCeremony = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: myCeremony.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: myCeremony.length.toString() != '0'
                ? Card(
                    child: Column(
                      children: [
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.red)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Livee(
                                                ceremony: myCeremony[index],
                                              )));
                                },
                                child: ClipRRect(
                                  child: Center(
                                      child: myCeremony[index].cImage != ''
                                          ? Image.network(
                                              api +
                                                  'public/uploads/' +
                                                  myCeremony[index].u1 +
                                                  '/ceremony/' +
                                                  myCeremony[index].cImage,
                                              height: 60,
                                              width: 65,
                                              fit: BoxFit.cover,
                                            )
                                          : const SizedBox(height: 1)),
                                ),
                              ),

                              const SizedBox(
                                width: 20,
                              ),
                              //Details Ceremony
                              Column(
                                children: [
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),

                                  // Title
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                        myCeremony[index]
                                            .ceremonyType
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1)),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            text: 'On: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Colors.grey)),
                                        TextSpan(
                                            text:
                                                myCeremony[index].ceremonyDate,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.black))
                                      ]),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Livee(
                                                    ceremony: myCeremony[index],
                                                  )));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(105)),
                                        child: Text(
                                          'Code: ' + myCeremony[index].codeNo,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(105)),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'No Ceremony',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
          );
        },
      ),
    );
  }
}
