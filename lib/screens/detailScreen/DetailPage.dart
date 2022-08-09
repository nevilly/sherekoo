import 'package:flutter/material.dart';
import '../../model/busness/allBusness.dart';
import '../../model/busness/busnessMembers.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/busness/busnessPhotoModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/getAll.dart';
import '../../model/services/ServicesModelModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../bsnScreen/bsnScrn.dart';
import '../subscriptionScreen/hiringPage.dart';
import '../subscriptionScreen/subscription.dart';

class BsnDetails extends StatefulWidget {
  final BusnessModel data;
  final CeremonyModel ceremonyData;

  const BsnDetails({Key? key, required this.data, required this.ceremonyData})
      : super(key: key);

  @override
  _BsnDetailsState createState() => _BsnDetailsState();
}

class _BsnDetailsState extends State<BsnDetails> {
  late String token = '';
  final Preferences _preferences = Preferences();

  late BusnessModel data;
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
    u1: '',
    u1Avt: '',
    u1Fname: '',
    u1Lname: '',
    u1g: '',
    u2: '',
    u2Avt: '',
    u2Fname: '',
    u2Lname: '',
    u2g: '', youtubeLink: '',
  );

  List<ServicesModel> hostLIstData = [];
  List<BusnessModel> info = [];
  List<BusnessModel> otherBsn = [];
  List<BusnessPhotoModel> photo = [];
  List<BusnessMembersModel> members = [];
  String getMemberResult = "";
  int tabsNu = 3;

  bool go = false;

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getOther();

        getPhoto();
        getMembers();

        // print('getMemberResult.................................');
        // print(go);
        // if (members.isNotEmpty && go) {
        //   tabsNu = 4;
        // }
        getAll();
      });
    });

    data = widget.data;
    ceremony = widget.ceremonyData;

    super.initState();
  }

  getOther() async {
    AllBusnessModel(payload: [], status: 0)
        .onBusnessType(token, urlBusnessByType, data.busnessType)
        .then((value) {
      setState(() {
        // print(value.payload);
        otherBsn = value.payload.map<BusnessModel>((e) {
          return BusnessModel.fromJson(e);
        }).toList();

        // print(data);
      });
    });
  }

  getPhoto() async {
    GetAll(
      payload: [],
      status: 0,
      id: data.bId,
    ).get(token, urlBusnessPhoto).then((value) {
      // print('Get Photo view..');
      // print(value.payload);

      setState(() {
        photo = value.payload.map<BusnessPhotoModel>((e) {
          return BusnessPhotoModel.fromJson(e);
        }).toList();

        // print(data);
      });
    });
  }

  getMembers() async {
    GetAll(
      payload: [],
      status: 0,
      id: data.bId,
    ).get(token, urlBusnessMembers).then((value) {
      // print('Get member view........................');
      // print(value.payload);

      if (value.payload != 'No content') {
        setState(() {
          go = true;
          members = value.payload.map<BusnessMembersModel>((e) {
            return BusnessMembersModel.fromJson(e);
          }).toList();

          // print(data);
        });
      } else {
        setState(() {
          go = false;
          getMemberResult = value.payload;
        });
      }
    });
  }

  getAll() async {
    GetAll(id: data.bId, status: 0, payload: [])
        .get(token, urlGetServices)
        .then((value) {
      // print('HOostList view..');
      // print(value.payload);
      setState(() {
        hostLIstData = value.payload
            .map<ServicesModel>((e) => ServicesModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabsNu,
        child: Scaffold(
          appBar: AppBar(
            title: Text(data.companyName),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Top Profile

              Stack(
                children: [
                  ClipRRect(
                    child: Center(
                        child: data.coProfile != ''
                            ? Image.network(
                                api +
                                    'public/uploads/' +
                                    data.username +
                                    '/busness/' +
                                    data.coProfile,
                                height: 185,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(height: 1)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 135, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8, right: 10, bottom: 8),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: '${data.busnessType}: ',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: data.knownAs),
                            ])),
                          ),
                        ),
                        Icon(Icons.favorite_sharp, color: Colors.red.shade500),
                      ],
                    ),
                  ),
                ],
              ),

              //Tabs
              const TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'OverView',
                    ),
                    Tab(
                      text: 'Description',
                    ),
                    Tab(
                      text: 'Feedback',
                    ),
                    // ignore: unrelated_type_equality_checks
                    // if (members.isNotEmpty && go)
                    //   const Tab(
                    //     text: 'Staff',
                    //   ),
                  ]),

              //TabVies
              Expanded(
                  child: TabBarView(children: [
                //OverView Container
                SizedBox(
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12.0,
                        ),

                        // Price
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 10.0, left: 8),
                          child: Column(
                            children: [
                              Text(
                                '${data.price} Tsh',
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const Text(
                                'Price/Negotiable',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              //Hire Me Botton
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HiringPage(
                                                busness: data,
                                                ceremony: widget.ceremonyData,
                                              )));
                                },
                                child: Container(
                                  width: 400,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Hire Me ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 12.0,
                        ),

                        // Ceremony List.
                        if (hostLIstData.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'List Ceremon Host',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.more_horiz),
                                        color: Colors.blueGrey,
                                        iconSize: 20.0,
                                        onPressed: () {
                                          oneButtonPressed('sema', '234234');
                                        })
                                  ],
                                )),
                          ),

                        //List of Ceremony Container
                        if (hostLIstData.isNotEmpty)
                          SizedBox(
                            height: 120,
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: hostLIstData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) =>
                                      //              LiveCeremony(data: hostLIstData[index],)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: SizedBox(
                                        width: 120,
                                        child: Card(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                child: Center(
                                                  child: Image(
                                                    image: AssetImage(
                                                        hostLIstData[index]
                                                            .cImage),
                                                    height: 55,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                child: Text(
                                                    hostLIstData[index].codeNo,
                                                    style: const TextStyle(
                                                        fontSize: 9)),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(hostLIstData[index].cName,
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    bottom: 4),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            size: 10,
                                                          ),
                                                          Text('134',
                                                              style: TextStyle(
                                                                  fontSize: 7,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: const [
                                                          Icon(
                                                            Icons.photo,
                                                            size: 10,
                                                          ),
                                                          Text('13k',
                                                              style: TextStyle(
                                                                  fontSize: 7,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: const [
                                                          Icon(
                                                            Icons.message,
                                                            size: 10,
                                                          ),
                                                          Text('25k',
                                                              style: TextStyle(
                                                                  fontSize: 7,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        // End List of Ceremony Container

                        const SizedBox(
                          height: 20,
                        ),

                        // Other Busness Type
                        if (otherBsn.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          BusnessScreen(
                                                            bsnType: data
                                                                .busnessType,
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
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                          '/public/uploads/' +
                                                          otherBsn[index]
                                                              .username +
                                                          '/busness/' +
                                                          otherBsn[index]
                                                              .coProfile,
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
                                                  child: Text(
                                                      otherBsn[index].knownAs,
                                                      style: const TextStyle(
                                                          color: Colors.grey)),
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
                    ),
                  ),
                ),

                //Description
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      //Contact Button => Subscription Page
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                child: Text('Name',
                                    style: TextStyle(
                                        color: Colors.black,
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Get Contact',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            height: 1),
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
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
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //Origin
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text('Origin',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                    text: 'Region: ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Mnyakyusa',
                                    style: TextStyle(
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

                      //Location
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text('Address',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Location: ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text('Bio ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: data.aboutCEO,
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
                      ),

                      //Co Bio
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text('company Bio ',
                                  style: TextStyle(
                                      color: Colors.black,
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
                                      text: data.aboutCompany,
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
                      ),

                      //Picture

                      if (photo.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text('Photos / Facilites',
                                style: TextStyle(
                                    color: Colors.black,
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

                //Feeds From Ceremony
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Card(
                                  child: Column(
                                    children: [
                                      //header

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/login/02.jpg'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.0),
                                                child: Text('Karium',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('12:00 pm'),
                                          ),
                                        ],
                                      ),

                                      //body Photo
                                      const Image(
                                          image: AssetImage(
                                              'assets/login/04.jpg')),

                                      //body Message
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                            textAlign: TextAlign.justify,
                                            text: const TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      'Nakutakia maisha yenye Amani na upendo rafik wa kweri',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0,
                                                      color: Colors.grey)),
                                              TextSpan(
                                                  text:
                                                      ' @koosafi-MrsMwakanyaga0xsd',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12.0,
                                                      color: Colors.grey)),
                                            ])),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //footer

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    Icons.reply,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text('234'),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: const [
                                                Icon(
                                                  Icons.favorite,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text('139'),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    Icons.send,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text('Text'),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Card(
                                  child: Column(
                                    children: [
                                      //header
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/login/01.png'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.0),
                                                child: Text('Nehemia',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('12:00 pm'),
                                          ),
                                        ],
                                      ),

                                      //body Photo
                                      // Image(
                                      //     image: AssetImage(
                                      //         'assets/login/02.jpg')),

                                      //body Message
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                            textAlign: TextAlign.justify,
                                            text: const TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      'Nakutakia maisha yenye Amani na upendo rafik wa kweri',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0,
                                                      color: Colors.grey)),
                                              TextSpan(
                                                  text: ' @koosafi-MrsMusa0xsd',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12.0,
                                                      color: Colors.grey)),
                                            ])),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //footer

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    Icons.reply,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text('234'),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: const [
                                                Icon(
                                                  Icons.favorite,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text('139'),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    Icons.send,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text('Text'),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                //staff
                // if (members.isNotEmpty && go)
                //   SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Container(
                //               margin: const EdgeInsets.only(left: 25),
                //               child: const Text('Co Members',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 16)),
                //             ),

                //             // GestureDetector(
                //             //   onTap: () {
                //             //     // oneButtonPressed();
                //             //   },
                //             //   child: Container(
                //             //       margin:
                //             //           const EdgeInsets.only(right: 14, top: 10.0),
                //             //       decoration: const BoxDecoration(
                //             //         color: Colors.red,
                //             //         borderRadius:
                //             //             BorderRadius.all(Radius.circular(10)),
                //             //       ),
                //             //       child: const Padding(
                //             //           padding: EdgeInsets.all(8.0),
                //             //           child: Text('Insert Members',
                //             //               style: TextStyle(
                //             //                   fontWeight: FontWeight.bold,
                //             //                   color: Colors.white)))),
                //             // ),
                //           ],
                //         ),
                //         SizedBox(
                //           height: 400,
                //           child: ListView.builder(
                //               itemCount: members.length,
                //               itemBuilder: (BuildContext context, index) {
                //                 return Container(
                //                   margin: const EdgeInsets.only(
                //                       top: 1, left: 10, right: 10),
                //                   child: Card(
                //                     child: ListTile(
                //                         leading: CircleAvatar(
                //                           backgroundImage:
                //                               AssetImage(members[index].avater),
                //                         ),
                //                         title: Text(members[index].username),
                //                         subtitle: Text(members[index].position),
                //                         trailing: const Icon(Icons.select_all)),
                //                   ),
                //                 );
                //               }),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(
                //               top: 1, left: 10, right: 10),
                //           child: const Card(
                //             child: ListTile(
                //                 leading: CircleAvatar(
                //                     backgroundImage: AssetImage(
                //                         'assets/busness/profile.jpg')),
                //                 title: Text('User Name'),
                //                 subtitle: Text('Sub tile'),
                //                 trailing: Icon(Icons.select_all)),
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(
                //               top: 1, left: 10, right: 10),
                //           child: const Card(
                //             child: ListTile(
                //                 leading: CircleAvatar(
                //                   backgroundImage:
                //                       AssetImage('assets/busness/profile.jpg'),
                //                 ),
                //                 title: Text('User Name'),
                //                 subtitle: Text('Sub tile'),
                //                 trailing: Icon(Icons.select_all)),
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(
                //               top: 1, left: 10, right: 10),
                //           child: const Card(
                //             child: ListTile(
                //                 leading: CircleAvatar(
                //                     backgroundImage: AssetImage(
                //                         'assets/busness/profile.jpg')),
                //                 title: Text('User Name'),
                //                 subtitle: Text('Sub tile'),
                //                 trailing: Icon(Icons.select_all)),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ])),
            ],
          ),
        ));
  }

  void oneButtonPressed(title, price) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 460,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                        child: Text('List Of Ceremony',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                          itemCount: hostLIstData.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0)),
                                    child: Image(
                                      image: AssetImage(
                                          hostLIstData[index].cImage),
                                      width: 100,
                                      height: 60,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Text(hostLIstData[index].cName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54)),
                                      Text(hostLIstData[index].codeNo,
                                          style: const TextStyle(fontSize: 10)),
                                    ]),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                )),
          );
        });
  }
}
