import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherekoo/model/InvCards/cards.dart';
import 'package:sherekoo/model/InvCards/invCards.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/gradientBorder.dart';
import '../../widgets/imgWigdets/boxImg.dart';
import '../../widgets/mimiAdmin.dart';
import '../uploadScreens/ceremonyUpload.dart';

class SherekoCards extends StatefulWidget {
  final CeremonyModel crm;
  final User user;
  const SherekoCards({Key? key, required this.crm, required this.user})
      : super(key: key);

  @override
  State<SherekoCards> createState() => _SherekoCardsState();
}

class _SherekoCardsState extends State<SherekoCards> {
 

  final TextEditingController _body = TextEditingController();
  final TextEditingController _invDateController = TextEditingController();
  final TextEditingController _secInvDateController = TextEditingController();

  final TextEditingController _initialtotal = TextEditingController();

  String cId = '';
  String cImg = '';
  String username = '';
  String crmType = '';
  String crmDate = '';
  StateSetter? _setState;
  List<CeremonyModel> myCrm = [];
  List<CardsModel> cards = [];

  User currentUser = User(
    id: '',
    username: '',
    firstname: '',
    lastname: '',
    avater: '',
    phoneNo: '',
    email: '',
    gender: '',
    role: '',
    isCurrentUser: '',
    address: '',
    bio: '',
    meritalStatus: '',
    totalPost: '',
    isCurrentBsnAdmin: '',
    isCurrentCrmAdmin: '',
    totalFollowers: '',
    totalFollowing: '',
    totalLikes: '');

    CeremonyModel ceremony = CeremonyModel(
  cId: '',
  codeNo: '',
  ceremonyType: '',
  cName: '',
  fId: '',
  sId: '',
  cImage: '',
  ceremonyDate: '',
  admin: '',
  contact: '',
  isInFuture: '',
  isCrmAdmin: '',
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
  youtubeLink: '',
);


  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getCeremony();
        if (widget.crm.cId.isNotEmpty) {
          cId = widget.crm.cId;
          cImg = widget.crm.cImage;
          username = widget.crm.userFid.username!;
          crmType = widget.crm.ceremonyType;
          crmDate = widget.crm.ceremonyDate;
        } else {
          getAllCeremony(widget.user.id);
        }

        getAllCards();
      });
    });
    super.initState();
  }

  getAllCeremony(userid) async {
    CrmCall(payload: [], status: 0)
        .getCeremonyByUserId(token, urlGetByUserId, userid)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          myCrm = value.payload
              .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  getAllCards() async {
    InvCards(payload: [], status: 0).get(token, urlGetInvCards).then((value) {
      if (value.status == 200) {
        setState(() {
          cards = value.payload
              .map<CardsModel>((e) => CardsModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  orderCard(
      BuildContext context,
      TextEditingController date,
      TextEditingController suggestedCardMsg,
      crm,
      totalQnty,
      totalPrice,
      cardId,
      crmId) {
    if (cId != '') {
      String dedline = '';
      InvCards(payload: [], status: 0)
          .orderPost(token, urlOrderInvCards, dedline, suggestedCardMsg.text,
              totalQnty, totalPrice, cardId, crmId)
          .then((v) {
        if (v.status == 200) {
          Navigator.of(context).pop();
        
        }
      });
    } else {
      if (date.text.isNotEmpty) {
        InvCards(payload: [], status: 0)
            .orderPost(token, urlOrderInvCards, date.text,
                suggestedCardMsg.text, totalQnty, totalPrice, cardId, crmId)
            .then((v) {
          if (v.status == 200) {
            Navigator.of(context).pop();
       
          }
        });
      } else {
        errorAlertDialog(
            context, 'Enter CeremonyDate', 'Fill Ceremony Date info Please!..');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Ceremony Cards', style: header14)),
      body: Column(
        children: [
          const SizedBox(height: 8),
          topHeader(context),
          const SizedBox(height: 8),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: cards.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.8),
                      itemCount: cards.length,
                      itemBuilder: (context, i) {
                        final itm = cards[i];
                        return Container(
                            decoration: BoxDecoration(
                              color: OColors.darGrey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            margin: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                fadeImg(
                                    itm,
                                    context,
                                    '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}',
                                    MediaQuery.of(context).size.height / 7.1),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        prevCardDialog(context, itm);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 2,
                                            bottom: 2),
                                        decoration: BoxDecoration(
                                            color: OColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'prev',
                                          style: header11,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        bookingCard(context, itm);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 2,
                                            bottom: 2),
                                        decoration: BoxDecoration(
                                            color: OColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'Order',
                                          style: header10,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No Invitation Cards',
                            style: header14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: 
      
      Container(
        height: 60,
        color: OColors.primary.withOpacity(.2),
        child: 
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: cId.isNotEmpty
                    ? Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                         
                          LiveBorder(
                              live: const SizedBox.shrink(),
                              radius: 30,
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    '${api}public/uploads/$username/ceremony/$cImg',
                                  ))),

                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  crmType,
                                  style: header12.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  crmDate,
                                  style: header10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : myCrm.isNotEmpty
                        ? Center(
                            child: Text(
                              'Select Ceremony',
                              style: header12,
                            ),
                          )
                        : Center(
                            child: Text(
                            'Create Ceremony',
                            style: header12,
                          ))
                          ),
            Row(
              children: [
                // Change Ceremony
                myCrm.isNotEmpty && myCrm.length > 1
                    ? GestureDetector(
                        onTap: () {
                          showAlertDialog(
                              context, 'Select Ceremony ', '', '', '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.change_circle,
                            size: 30,
                            color: OColors.primary,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 5),
                // Add Ceremony
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CeremonyUpload(
                                getData: ceremony,
                                getcurrentUser: widget.user)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: OColors.fontColor,
                      ),
                    ),
                  ),
                ),

                //Cancel/ remove Ceremony
                cId.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            cId = '';
                            crmDate = '';
                            crmType = '';
                            _invDateController.clear();
                            _secInvDateController.text = '';
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.cancel_rounded,
                            size: 30,
                            color: OColors.primary,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    
    );
  }

  FadeInImage fadeImg(CardsModel itm, BuildContext context, url, double h) {
    return FadeInImage(
      image: NetworkImage(url),
      fadeInDuration: const Duration(milliseconds: 100),
      placeholder: const AssetImage('assets/logo/noimage.png'),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/logo/noimage.png', fit: BoxFit.fitWidth);
      },
      height: h,
      fit: BoxFit.fitWidth,
    );
  }

  Padding topHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'All',
            style: header12,
          ),
          Text(
            '- choose Selemony -',
            style: header12,
          ),
          Text(
            '- Price -',
            style: header12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MkweriWaMaisha(
                            crm: ceremony,
                            from: 'Home',
                          )));
            },
            child: Text(
              ' GoAdmin ',
              style: header12,
            ),
          ),
        ],
      ),
    );
  }

  // Alert Widget
  showAlertDialog( 
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Create",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CeremonyUpload(
                    getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: const Text("Done"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: header18),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myCrm.length,
            itemBuilder: (context, i) {
              final itm = myCrm[i];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    cId = itm.cId;
                    cImg = itm.cImage;
                    username = itm.userFid.username!;
                    crmType = itm.ceremonyType;
                    crmDate = itm.ceremonyDate;
                    _secInvDateController.text = itm.ceremonyDate;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Column(
                    children: [
                      Text(
                        itm.ceremonyType,
                        style: header12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Img(
                            avater: itm.cImage,
                            url: '/ceremony/',
                            username: itm.userFid.username!,
                            width: 55,
                            height: 55,
                          )),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        itm.ceremonyDate,
                        style: header10,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
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

  prevCardDialog(BuildContext context, CardsModel itm) async {
    String imgUrl =
        '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}';
    double h = 50;
    double w = 50;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const SizedBox(),
      onPressed: () {
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ),
      ),
      content: StatefulBuilder(builder: (BuildContext context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: fadeImg(
                  itm, context, imgUrl, MediaQuery.of(context).size.height),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.font}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.font}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'fontSide',
                        style: header10,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.middle}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.middle}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'Middle',
                        style: header10,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.back}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.back}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'fontSide',
                        style: header10,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      }),
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

  bookingCard(BuildContext context, CardsModel itm) async {
    int card = int.parse(itm.quantity);

    int price = int.parse(itm.price);

    int cardsPrice = int.parse(itm.price) * int.parse(itm.quantity);
    int totalPrice = cardsPrice;

    // final TextEditingController _intTotal = TextEditingController();
    _initialtotal.text = itm.quantity;

    // ignore: unused_local_variable
    String invCardCrmId = '';

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 10, right: 10),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: header12,
      ),
      child: const Text("Buy"),
      onPressed: () {
        if (card >= int.parse(itm.quantity)) {
          orderCard(context, _invDateController, _body, widget.crm,
              _initialtotal.text, totalPrice, itm.id, cId);
        } else {
          errorAlertDialog(context, 'Lower Card Quanity',
              'lower card quantity than needed, add More card Please..');
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
      backgroundColor: OColors.secondary,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Icon(
              Icons.close,
              size: 20,
              color: OColors.fontColor,
            ),
          ),
        ),
      ),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        _setState = setState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 5.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      fadeImg(
                          itm,
                          context,
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}',
                          MediaQuery.of(context).size.height / 5.5),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.only(left: 18),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Price',
                          style: header18.copyWith(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        cardsPrice.toString(),
                        style: header18,
                      ),
                      Text(
                        'per ${itm.quantity} card',
                        style: header10,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('${itm.price} Tsh / card', style: header10)
                    ],
                  ),
                ),
              ],
            ),

            if (cId.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, bottom: 0, top: 15),
                    child: Text('On Ceremony', style: header13),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            cId.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _setState!(() {
                                        cId = '';
                                        crmDate = '';
                                        crmType = '';
                                        _invDateController.clear();
                                        _secInvDateController.text = '';

                                        invCardCrmId = '';
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        size: 20,
                                        color: OColors.primary,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            LiveBorder(
                                live: const SizedBox.shrink(),
                                radius: 10,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      '${api}public/uploads/$username/ceremony/$cImg',
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),

                            //CeremonyDetails
                            Container(
                              margin: const EdgeInsets.only(top: 13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    crmType,
                                    style: header12.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ceremonyDate('Update Ceremony Date',
                                      _secInvDateController)
                                ],
                              ),
                            ),
                          ],
                        ),

                        //Buttons
                        Container(
                          margin: const EdgeInsets.only(top: 13.0),
                          child: Column(
                            children: [
                              myCrm.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context,
                                            'Select Ceremony ', '', '', '');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.change_circle,
                                          size: 25,
                                          color: OColors.primary,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CeremonyUpload(
                                                  getData: ceremony,
                                                  getcurrentUser:
                                                      widget.user)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: OColors.fontColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

            if (crmDate.isEmpty)
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                ),
                padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('On Ceremony Date', style: header13),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ceremonyDate(
                              'Enter Ceremony Date', _invDateController),
                          Row(
                            children: [
                              myCrm.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          showAlertDialog(context,
                                              'Select Ceremony ', '', '', '');
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.change_circle,
                                          size: 25,
                                          color: OColors.primary,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CeremonyUpload(
                                                  getData: ceremony,
                                                  getcurrentUser:
                                                      widget.user)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: OColors.fontColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(
              height: 8,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 5),
              child: Text(
                'Write your card Message',
                style: header14,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 60,
              padding: const EdgeInsets.only(
                top: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _body,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "Yuor Message \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),

            if (cId.isEmpty) const Spacer(),

            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child:
                            Text('Amount of Card You Order', style: header13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          card >= int.parse(itm.quantity)
                              ? GestureDetector(
                                  onTap: () {
                                    _setState!(() {
                                      card--;
                                      _initialtotal.text = card.toString();
                                      totalPrice = card * price;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: OColors.fontColor),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.exposure_minus_1,
                                      size: 16,
                                      color: OColors.fontColor,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 50,
                            height: 30,
                            padding: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: OColors.fontColor)),
                            child: TextField(
                              controller: _initialtotal,
                              maxLines: null,
                              expands: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                border: InputBorder.none,
                              ),
                              style: header16.copyWith(
                                  color: Colors.grey, height: 1.3),
                              onChanged: (value) {
                                setState(() {
                                  //_email = value;
                                  _initialtotal.text = value;
                                  card = int.parse(value);
                                  totalPrice = card * price;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              _setState!(() {
                                card++;
                                _initialtotal.text = card.toString();
                                totalPrice = card * price;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 1, color: OColors.fontColor),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.plus_one,
                                size: 16,
                                color: OColors.fontColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Total price',
                        style: header15,
                      ),
                      card >= int.parse(itm.quantity)
                          ? Text(
                              totalPrice.toString(),
                              style: header16,
                            )
                          : Text(
                              totalPrice.toString(),
                              style: header16.copyWith(color: OColors.danger),
                            )
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }),
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

  Column cardsView(url, double w, double h, String exp) {
    return Column(
      children: [
        SizedBox(
          width: w,
          height: w,
          child: Image.asset(
            url,
          ),
        ),
        Text(
          exp,
          style: header10,
        )
      ],
    );
  }

  ceremonyDate(title, dateController) {
    return SizedBox(
        width: 160,
        // color: OColors.fontColor,
        // margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.topLeft,
              child: Text(title, style: header11),
            ),
            Container(
              height: 30,
              margin: const EdgeInsets.only(left: 0, right: 20, bottom: 1),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: dateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: OColors.primary,
                    ),
                  ),
                  hintText: 'Date ( DD/MM/YYY )',
                  hintStyle: header12.copyWith(color: Colors.grey, height: 1.1),
                ),
                style: header12.copyWith(color: Colors.grey, height: 1.1),
                onTap: () {
                  _selectDate(context, dateController);
                },
              ),
            ),
          ],
        ));
  
  }

  DateTime? _selectedDate;
  // Date Selecting Function
  _selectDate(BuildContext context, textEditingController) async {
    DateTime? newSelectedDate = await showDatePicker(
        locale: const Locale('en', 'IN'),
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        fieldHintText: 'yyyy/mm/dd',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: OColors.darkGrey,
                onPrimary: Colors.white,
                surface: OColors.secondary,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: OColors.darGrey,
            ),
            child: child as Widget,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat('yyyy/MM/dd').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

 
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
