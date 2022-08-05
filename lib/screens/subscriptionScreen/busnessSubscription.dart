import 'package:flutter/material.dart';
import 'package:sherekoo/screens/bsnScreen/bsnScrn.dart';

import '../../model/busness/postBusness.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class BusnessSubscription extends StatefulWidget {
  final String busnessType,
      knownAs,
      coProfile,
      price,
      contact,
      location,
      companyName,
      ceoId,
      aboutCEO,
      aboutCompany,
      createdBy,
      hotStatus;
  const BusnessSubscription(
      {Key? key,
      required this.busnessType,
      required this.knownAs,
      required this.coProfile,
      required this.price,
      required this.contact,
      required this.location,
      required this.companyName,
      required this.ceoId,
      required this.aboutCEO,
      required this.aboutCompany,
      required this.createdBy,
      required this.hotStatus})
      : super(key: key);

  @override
  State<BusnessSubscription> createState() => _BusnessSubscriptionState();
}

class _BusnessSubscriptionState extends State<BusnessSubscription> {
  Color _color = Colors.white;
  Color _shdwColor1 = Colors.black.withOpacity(0.1);
  Color _shdwColor2 = Colors.black.withOpacity(0.1);
  Color _shdwColor3 = Colors.black.withOpacity(0.1);
  final Preferences _preferences = Preferences();
  String token = '';

  CeremonyModel ceremony = CeremonyModel(
      cId: '',
      codeNo: '',
      ceremonyType: '',
      cName: '',
      fId: '',
      sId: '',
      cImage: '',
      ceremonyDate: '',
      contact: '',
      admin: '',
      u1: '',
      u1Avt: '',
      u1Fname: '',
      u1Lname: '',
      u1g: '',
      u2: '',
      u2Avt: '',
      u2Fname: '',
      u2Lname: '',
      u2g: '');
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });

    super.initState();
  }

  selectSubscription(lvl) async {
    PostBusness(
      busnessType: widget.busnessType,
      knownAs: widget.knownAs,
      coProfile: widget.coProfile,
      price: widget.price,
      contact: widget.contact,
      location: widget.location,
      companyName: widget.companyName,
      ceoId: widget.ceoId,
      aboutCEO: widget.aboutCEO,
      aboutCompany: widget.aboutCompany,
      createdBy: widget.createdBy,
      hotStatus: '0',
      status: 0,
      payload: [],
      subscrlevel: lvl,
      bId: '',
    ).get(token, urlPostBusness).then((v) {
      if (v.status == 200) {
        alertMessage(v.payload);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BusnessScreen(
                      bsnType: widget.busnessType,
                      ceremony: ceremony,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('System Error, Try Again'),
        ));
      }
    });
  }

  alertMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage("assets/subscription/subscription.png"),
            height: 150,
            fit: BoxFit.cover,
          ),

          const Padding(
            padding:
                EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Center(
                child: Text(
              'Follow Instruction Step By Step for clear Payment..',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black),
            )),
          ),

          const SizedBox(
            height: 10,
          ),

          //Our package list
          Expanded(
            child: ListView(scrollDirection: Axis.horizontal, children: [
              //free offer
              Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, left: 8, right: 4.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    selectSubscription('Free');
                    // oneButtonPressed('Free', '0 Tsh');
                    setState(() {
                      _color = Colors.white;
                      _shdwColor1 = Colors.red.withOpacity(0.5);
                      _shdwColor2 = Colors.black.withOpacity(0.1);
                      _shdwColor3 = Colors.black.withOpacity(0.1);
                    });
                  },
                  child: Container(
                    // height: 160,
                    // width: 120,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: _shdwColor1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Free',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        const SizedBox(height: 7),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    ' Offer',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '- We bagain for you',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- post Live Ceremony ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- Your Contact not shown ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: '0 ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Tsh',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Select',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    oneButtonPressed('Silver', '60,000 Tsh / month');
                    setState(() {
                      _color = Colors.white;
                      _shdwColor1 = Colors.black.withOpacity(0.1);
                      _shdwColor2 = Colors.red.withOpacity(0.5);
                      _shdwColor3 = Colors.black.withOpacity(0.1);
                    });
                  },
                  child: Container(
                    height: 160,
                    // width: 120,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: _shdwColor2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Silver',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        const SizedBox(height: 7),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    ' Offer',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '- Live Ceremony',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- view ten Contact',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- View All Schedule',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- send alert Message',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- Be in Magazine',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: '60,000 ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Tsh',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                        ),

                        const Spacer(),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Select',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, left: 4, right: 8.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    oneButtonPressed('Gold', '120,000 Tsh');
                    setState(() {
                      _color = Colors.white;
                      _shdwColor1 = Colors.black.withOpacity(0.1);
                      _shdwColor2 = Colors.black.withOpacity(0.1);
                      _shdwColor3 = Colors.red.withOpacity(0.5);
                    });
                  },
                  child: Container(
                    height: 160,
                    // width: 120,
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: _shdwColor3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Gold',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    ' Offer',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '- Access for bagain',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '- view Contact',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- view All Schedule',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- we advartise you',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- Be in Magazine',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, right: 8.0, bottom: 8.0),
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: '120,000 ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Tsh',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Select',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),

          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Sherekea ,furahia sherehe yako katika ubora wa kitaifa na kimataifa',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
            ),
          )
        ],
      ),
    );
  }

  void oneButtonPressed(title, price) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 280,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: buildBottomNavigationMenu(title, price)),
          );
        });
  }

  Column buildBottomNavigationMenu(title, price) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        // SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Price: ',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 18)),
            TextSpan(
                text: price,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20)),
          ])),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 100,
                  height: 35,
                  color: Colors.red,
                  child: const Image(
                    image: AssetImage("assets/subscription/download.jpg"),
                    // fit: BoxFit.cover,
                  )),
              Container(
                  width: 100,
                  height: 35,
                  color: Colors.red,
                  child: const Image(
                    image: AssetImage("assets/subscription/mpesa.png"),
                    // fit: BoxFit.cover,
                  )),
              Container(
                  width: 100,
                  height: 35,
                  color: Colors.red,
                  child: const Image(
                    image: AssetImage("assets/subscription/hpesa.png"),
                    // fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
        Row(
          children: const [
            Expanded(
              child: SizedBox(
                  width: 100,
                  height: 35,
                  child: Image(
                    image: AssetImage("assets/subscription/hpesa.png"),
                    // fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: SizedBox(
                  width: 100,
                  height: 35,
                  child: Image(
                    image: AssetImage("assets/subscription/apesa.png"),
                    // fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 2.0),
          child: RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Payment No: ',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14)),
            TextSpan(
                text: '+255 686 520 133',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14)),
          ])),
        ),

        GestureDetector(
          onTap: () {
            selectSubscription(title);
          },
          child: Container(
            width: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
