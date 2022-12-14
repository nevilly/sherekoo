import 'package:flutter/material.dart';
import 'package:sherekoo/screens/bsnScreen/bsn-screen.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/busness/busness-call.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/textStyle-pallet.dart';
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

  double cWdth = 120;
  double cHgt = 140;

  String alerTitle = 'Alert: Payment..!!';
  String alertBody = 'Payment Function on progress ... !';

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });

    super.initState();
  }

  selectSubscription(lvl) async {
    BusnessCall(
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
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BusnessScreen(
                      bsnType: widget.busnessType,
                      ceremony: CeremonyModel(
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
                          isCrmAdmin: '',
                          isInFuture: '',
                          likeNo: '',
                          chatNo: '',
                          viwersNo: '',
                          userFid: User(
                              id: '',
                              username: '',
                              firstname: '',
                              lastname: '',
                              avater: '',
                              phoneNo: '',
                              email: '',
                              gender: '',
                              role: '',
                              address: '',
                              meritalStatus: '',
                              bio: '',
                              totalPost: '',
                              isCurrentUser: '',
                              isCurrentCrmAdmin: '',
                              isCurrentBsnAdmin: '',
                              totalFollowers: '',
                              totalFollowing: '',
                              totalLikes: ''),
                          userSid: User(
                              id: '',
                              username: '',
                              firstname: '',
                              lastname: '',
                              avater: '',
                              phoneNo: '',
                              email: '',
                              gender: '',
                              role: '',
                              address: '',
                              meritalStatus: '',
                              bio: '',
                              totalPost: '',
                              isCurrentUser: '',
                              isCurrentCrmAdmin: '',
                              isCurrentBsnAdmin: '',
                              totalFollowers: '',
                              totalFollowing: '',
                              totalLikes: ''),
                          youtubeLink: ''),
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: const Text('Subscription'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image(
            image: const AssetImage("assets/subscription/subscription.png"),
            height: size.height / 5,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // color: Colors.red,
                height: 240,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      //free offer
                      Padding(
                        padding: const EdgeInsets.all(
                          4.0,
                        ),
                        child: Container(
                          height: cHgt,
                          width: cWdth,
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
                          child: freePackage(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: cHgt,
                          width: cWdth,
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
                          child: silverPackage(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 4, right: 8.0, bottom: 8.0),
                        child: Container(
                          height: cWdth,
                          width: cHgt,
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
                          child: goldPackage(),
                        ),
                      ),
                    ]),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Sherekea ,furahia sherehe yako katika ubora wa kitaifa na kimataifa',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            ),
          ),
        ),
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

  Column goldPackage() {
    return Column(
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
                children: [
                  Text(
                    ' Offer',
                    style: header13.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '- Access for bagain',
                    style: header10,
                  ),
                  Text('- view Contact', style: header10),
                  Text(
                    '- view All Schedule',
                    style: header10,
                  ),
                  Text(
                    '- we advartise you',
                    style: header10,
                  ),
                  Text(
                    '- Be in Magazine',
                    style: header10,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
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
        GestureDetector(
          onTap: () {
            setState(() {
              _color = Colors.white;
              _shdwColor1 = Colors.black.withOpacity(0.1);
              _shdwColor2 = Colors.black.withOpacity(0.1);
              _shdwColor3 = Colors.red.withOpacity(0.5);
            });

            showAlertDialog(
              context,
              alerTitle,
              alertBody,
              'Gold',
            );

            // oneButtonPressed('Gold', '120,000 Tsh');
          },
          child: Container(
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
          ),
        )
      ],
    );
  }

  Column silverPackage() {
    return Column(
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
                children: [
                  Text(
                    ' Offer',
                    style: header13.copyWith(
                        color: OColors.textColor, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '- Live Ceremony',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- view ten Contact',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- View All Schedule',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- send alert Message',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- Be in Magazine',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
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
        GestureDetector(
          onTap: () {
            setState(() {
              _color = Colors.white;
              _shdwColor1 = Colors.black.withOpacity(0.1);
              _shdwColor2 = Colors.red.withOpacity(0.5);
              _shdwColor3 = Colors.black.withOpacity(0.1);
            });

            showAlertDialog(context, alerTitle, alertBody, 'Silver');
          },
          child: Container(
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
          ),
        )
      ],
    );
  }

  Column freePackage() {
    return Column(
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
                children: [
                  Text(
                    ' Offer',
                    style: header13.copyWith(
                        fontSize: 13,
                        color: OColors.darkGrey,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '- We bagain for you',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- post Live Ceremony ',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                  Text(
                    '- Your Contact not shown ',
                    style: header10.copyWith(color: OColors.textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
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
        GestureDetector(
          onTap: () {
            setState(() {
              _color = Colors.white;
              _shdwColor1 = Colors.red.withOpacity(0.5);
              _shdwColor2 = Colors.black.withOpacity(0.1);
              _shdwColor3 = Colors.black.withOpacity(0.1);
            });
            selectSubscription('Free');
            // showAlertDialog(context, alerTitle, alertBody, 'Free');
          },
          child: Container(
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
          ),
        )
      ],
    );
  }

  showAlertDialog(BuildContext context, String title, String msg, req) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("cancel",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
        // removeSelected(req.svId);
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: const Text("Pay"),
      onPressed: () {
        selectSubscription(req);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      content: Text(msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: OColors.fontColor)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
