import 'package:flutter/material.dart';

import '../../model/busness/busnessModel.dart';
import '../../model/busness/busnessPhotoModel.dart';
import '../../screens/subscriptionScreen/subscription.dart';
import '../../util/colors.dart';

class BsnDescr extends StatelessWidget {
  const BsnDescr({
    Key? key,
    required this.data,
    required this.photo,
  }) : super(key: key);

  final BusnessModel data;
  final List<BusnessPhotoModel> photo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            //Contact Button => Subscription Page
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('Name',
                          style: TextStyle(
                              color: OColors.fontColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold))),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SubscriptionPage())),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: OColors.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Get Contact',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: OColors.fontColor,
                                  height: 1),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            //Name
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.companyName,
                    style: TextStyle(
                      fontSize: 14,
                      color: OColors.fontColor,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            //Origin
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Column(
                children: [
                  
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Origin',
                        style: TextStyle(
                            color: OColors.fontColor,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                 

                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Region: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: OColors.fontColor,
                          ),
                        ),
                        TextSpan(
                          text: data.location,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: OColors.fontColor,
                          ),
                        ),
                      ])),
                    ),
                  ),
                ],
              ),
            ),

            //Location
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Address',
                        style: TextStyle(
                            color: OColors.fontColor,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Location: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: OColors.fontColor,
                          ),
                        ),
                        TextSpan(
                          text: data.location,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ])),
                    ),
                  ),
                ],
              ),
            ),

            //Bio
            descrInfo('Ceo Bio ', data.aboutCEO),

            //Co Bio
            descrInfo('company Bio ', data.aboutCompany),

            //Picture

            if (photo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Photos / Facilites',
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ),
              ),

            if (photo.isNotEmpty)
              SizedBox(
                height: 600,
                // color: Colors.red,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: photo.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Image(
                          image: AssetImage(photo[index].photo),
                          fit: BoxFit.fill,
                        ),
                      );
                    }),
              ),

            // Column(children: [
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       alignment: Alignment.topLeft,
            //       child: const Text('Photos / Facilites',
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontStyle: FontStyle.italic,
            //               fontWeight: FontWeight.bold)),
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 10,
            //   ),
            //   const SizedBox(
            //     height: 120,
            //     child: Image(
            //       image: AssetImage('assets/login/03.jpg'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 10,
            //   ),
            //   const SizedBox(
            //     height: 120,
            //     child: Image(
            //       image: AssetImage('assets/login/04.jpg'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ])
          ],
        ),
      ),
    );
  }

  Padding descrInfo(String label, String dscr) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(label,
                style: TextStyle(
                    color: OColors.fontColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                softWrap: true,
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  TextSpan(
                    text: dscr,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const TextSpan(
                    text: ' @RealCount',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
