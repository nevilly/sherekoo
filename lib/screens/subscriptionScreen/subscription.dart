import 'package:flutter/material.dart';

import '../../widgets/notifyWidget/notifyWidget.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Color _color = Colors.white;
  Color _shdwColor1 = Colors.black.withOpacity(0.1);
  Color _shdwColor2 = Colors.black.withOpacity(0.1);
  Color _shdwColor3 = Colors.black.withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // BackgroundImage(image: "assets/login/03.jpg"),
      Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Subscription'),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Image(
              image: AssetImage("assets/subscription/subscription.png"),
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
                    fontSize: 18,
                    color: Colors.black),
              )),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, left: 8, right: 4.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    oneButtonPressed('Basic', '25,000 Tsh');
                    setState(() {
                      _color = Colors.white;
                      _shdwColor1 = Colors.red.withOpacity(0.5);
                      _shdwColor2 = Colors.black.withOpacity(0.1);
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
                          color: _shdwColor1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Basic',
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
                                    '- Live Ceremony ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- 5 Contact each ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '- View 5 Schedule',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 19),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: '25,000 ',
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
                    oneButtonPressed('Silver', '60,000 Tsh');
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
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '- Live Ceremony',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '- view all Contact',
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
                                    '- send alert Message',
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
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
      ),
    ]);
  }

  void oneButtonPressed(title, price) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 260,
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
        const SizedBox(height: 20),
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

        RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: 'Payment Name: ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 14)),
          TextSpan(
              text: 'Chereko Company',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14)),
        ])),
      ],
    );
  }
}
