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
import '../../widgets/detailsWidg/BsnProfile.dart';
import '../../widgets/detailsWidg/bsnDescr.dart';
import '../../widgets/detailsWidg/busnessList.dart';
import '../../widgets/detailsWidg/ceremonyList.dart';
import '../subscriptionScreen/hiringPage.dart';

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
    u2g: '',
    youtubeLink: '',
  );

  List<ServicesModel> service = [];
  List<BusnessModel> info = [];
  List<BusnessModel> otherBsn = [];
  List<BusnessPhotoModel> photo = [];
  List<BusnessMembersModel> members = [];
  String getMemberResult = "";

  bool go = false;

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getOther();

        // getPhoto();
        // getMembers();
        crmWorkWithBsn();
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

  //All Ceremony work With Busness
  crmWorkWithBsn() async {
    GetAll(id: data.bId, status: 0, payload: [])
        .get(token, urlGetBsnToCrmnServices)
        .then((value) {
      setState(() {
        service = value.payload
            .map<ServicesModel>((e) => ServicesModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text(data.companyName),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Top Profile

              BusnessProfile(data: data, widget: widget),

              //Tabs
              const TabBar(
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  tabs: [
                    Tab(
                      text: 'OverView',
                    ),
                    Tab(
                      text: 'Description',
                    )
                  ]),

              //Tabs Views
              Expanded(
                  child: TabBarView(children: [
                //OverView Container
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),

                        // Price
                        priceShow(context),

                        //Ceremony List;
                        CeremonyList(service: service),
                        // End List of Ceremony Container

                        const SizedBox(
                          height: 10,
                        ),

                        // other Busness List
                        BusnessLst(
                          otherBsn: otherBsn,
                          ceremony: ceremony,
                          data: data,
                        ),
                      ],
                    ),
                  ),
                ),

                //Description
                BsnDescr(data: data, photo: photo),
              ])),
            ],
          ),
        ));
  }

  // Pricing
  Padding priceShow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0, left: 8),
      child: Column(
        children: [
          Text(
            '${data.price} Tsh',
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const Text(
            'Price/Negotiable',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
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
              width: 200,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
    );
  }
}

//Future Updating widgets
  // -> feeds Tabs
  // -> Busness members Tabs

