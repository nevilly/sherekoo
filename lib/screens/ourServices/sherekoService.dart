import 'package:flutter/material.dart';
import 'package:sherekoo/screens/ourServices/srvDetails.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/pallets.dart';

import '../../widgets/login_widget/background-image.dart';

class SherekoService extends StatefulWidget {
  final String from;
  const SherekoService({Key? key, required this.from}) : super(key: key);

  @override
  State<SherekoService> createState() => _SherekoServiceState();
}

class _SherekoServiceState extends State<SherekoService> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            child: const BackgroundImage(image: "assets/login/03.jpg")),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.reply,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              if (widget.from == 'crmBundle') crmBundlePosition(context),
              if (widget.from == 'Mr&MrsMy')
                rowBundlePosition(
                  context,
                  'Register',
                  'Our Best Mr&Mrs My Tv Show ',
                  'Season 01',
                  "assets/ceremony/hs1.jpg",
                ),
              if (widget.from == 'MyBdayShow')
                rowBundlePosition(
                  context,
                  'Register',
                  'Our Best  MyBirthDay Tv Show ',
                  'Season 01',
                  "assets/ceremony/hs1.jpg",
                ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: OColors.secondary,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 18, top: 5),
                        child: Text(
                          'Lorem ipsum  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Excepteur sint occaecat cupidatat non proident,.',
                          style: header10,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Bundles',
                              style: header12.copyWith(
                                  color: OColors.darkGrey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.more_horiz,
                              color: OColors.primary,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ServiceDetails()));
                              },
                              child: crmBundle(
                                  context,
                                  "assets/ceremony/hs1.jpg",
                                  '2,500,000',
                                  'House Part',
                                  110),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            crmBundle(context, "assets/ceremony/hs2.jpg",
                                '20,500,000', 'Wedding', 110),
                            const SizedBox(
                              width: 10,
                            ),
                            crmBundle(context, "assets/ceremony/b1.png",
                                '1,500,000', 'SendOff', 110),
                            const SizedBox(
                              width: 10,
                            ),
                            crmBundle(context, "assets/ceremony/hs2.jpg",
                                '3,500,000', '5 years', 110),
                            const SizedBox(
                              width: 10,
                            ),
                            crmBundle(context, "assets/ceremony/hs2.jpg",
                                '3,500,000', '10 years', 110),
                            const SizedBox(
                              width: 10,
                            ),
                            crmBundle(context, "assets/ceremony/hs2.jpg",
                                '3,500,000', '15 years', 110),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Positioned crmBundlePosition(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18.0),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
            decoration: BoxDecoration(
                color: OColors.primary,
                border: Border.all(color: OColors.primary, width: 1.2),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              'Booking',
              style: header12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(left: 18.0),
            padding: const EdgeInsets.only(left: 4),
            width: MediaQuery.of(context).size.width / 1.7,
            child: Text(
              'Our Best Ceremony Service Bundle ',
              style: header18.copyWith(
                  fontSize: 19,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  wordSpacing: 4.2),
            ),
          ),
        ],
      ),
    );
  }

  Positioned rowBundlePosition(
      BuildContext context, String subtitle, String title, String season, img) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(left: 18.0),
                  padding: const EdgeInsets.only(left: 4),
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            color: OColors.primary,
                            border:
                                Border.all(color: OColors.primary, width: 1.2),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          subtitle,
                          style: header12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: header18.copyWith(
                            fontSize: 19,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            wordSpacing: 4.2),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 100,
                  height: 130,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Text(
                          season,
                          style: header12.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Stack(
                        children: [
                          InkWell(
                            child: Image.asset(
                              img,
                              // width: 90,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    color: OColors.primary.withOpacity(.8)),
                                child: Center(
                                  child: Text(
                                    'Register Now',
                                    style: header11.copyWith(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container crmBundle(
      BuildContext context, url, price, String title, double w) {
    return Container(
      width: w,
      // height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: OColors.darGrey),
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              url,
              height: 140,
              fit: BoxFit.cover,
            )),
        Positioned(
            top: 8,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: OColors.primary.withOpacity(.8)),
              child: Text(
                title,
                style: header11.copyWith(fontWeight: FontWeight.w400),
              ),
            )),
        Positioned(
            bottom: 0,
            child: Container(
              width: 120,
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: OColors.secondary.withOpacity(.8)),
              child: Center(
                child: Text(
                  price + ' Tsh/',
                  style: header12.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            )),
      ]),
    );
  }
}
