import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';

import '../../model/allData.dart';
import '../../model/busness/postBusness.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../bsnScreen/bsnScrn.dart';
import '../subscriptionScreen/busnessSubscription.dart';

class BusnessUpload extends StatefulWidget {
  final BusnessModel getData;
  const BusnessUpload({Key? key, required this.getData}) : super(key: key);

  @override
  _BusnessUploadState createState() => _BusnessUploadState();
}

class _BusnessUploadState extends State<BusnessUpload> {
  final List<String> _busness = [
    'Mc',
    'Production',
    'Decorator',
    'Hall',
    'Cake Bekar',
    'Singer',
    'Dancer',
    'Cooker',
    'saloon',
    'Car',
  ];
  String selectedBusness = 'Please Choose Busness';
  final Preferences _preferences = Preferences();
  String token = '';

  // Image upload
  final _picker = ImagePicker();
  final _pickerG = ImagePicker();

  List<User> _allUsers = [];
  List<User> _foundUsers = []; //search
  late User currentUser;
  BusnessModel busness = BusnessModel(
      location: '',
      bId: '',
      knownAs: '',
      coProfile: '',
      busnessType: '',
      avater: '',
      companyName: '',
      price: '',
      contact: '',
      hotStatus: '',
      aboutCEO: '',
      aboutCompany: '',
      username: '',
      ceoId: '',
      subcrlevel: '');

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

  // for_Search Result
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user.username
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
        getAllUsers();

        if (widget.getData.bId.isNotEmpty) {
          selectedBusness = widget.getData.busnessType;

          if (widget.getData.busnessType == 'Mc') {
            mcAvater = widget.getData.avater;
            mcId = widget.getData.ceoId;
            mcUsername = widget.getData.username;
            _mcSubscription = widget.getData.subcrlevel;
            mcDefaultImg = widget.getData.coProfile;
            _mcCoKnownController.text = widget.getData.knownAs;
            _mcCoPriceController.text = widget.getData.price;
            _mcCoPhoneController.text = widget.getData.contact;
            _mcCoAboutController.text = widget.getData.aboutCompany;
            _mcCoLocationController.text = widget.getData.location;

            _mcCeobioController.text = widget.getData.aboutCEO;
            _mcCeoPhoneController.text = widget.getData.contact;
          }

          if (widget.getData.busnessType == 'Production') {
            productionAvater = widget.getData.avater;
            productionId = widget.getData.ceoId;
            productionUsername = widget.getData.username;
            productionDefaultImg = widget.getData.coProfile;
            _productionCoKnownController.text = widget.getData.knownAs;
            _productionCoPriceController.text = widget.getData.price;
            _productionCoPhoneController.text = widget.getData.contact;
            _productionCoLocationController.text = widget.getData.location;

            _productionCoAboutController.text = widget.getData.aboutCompany;

            _productionCeobioController.text = widget.getData.aboutCEO;
            _productionCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Decorator') {}
          if (widget.getData.busnessType == 'Cake Bekar') {}
          if (widget.getData.busnessType == 'Singer') {}
          if (widget.getData.busnessType == 'Dancer') {}
          if (widget.getData.busnessType == 'Cooker') {}
          if (widget.getData.busnessType == 'saloon') {}
          if (widget.getData.busnessType == 'Car') {}
        }
      });
    });
    _foundUsers = _allUsers;
    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        if (value.status == 200) {
          currentUser = User.fromJson(value.payload);
        }
      });
    });
  }

  getAllUsers() async {
    AllUsersModel(payload: [], status: 0).get(token, urlUserList).then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          _allUsers = value.payload.map<User>((e) => User.fromJson(e)).toList();
        });
      }
    });
  }

  //Mc
  String mcAvater = '';
  String mcId = "";
  String mcUsername = "";
  String _mcSubscription = '';
  String mcDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _mcCoKnownController = TextEditingController();
  final TextEditingController _mcCoPriceController = TextEditingController();
  final TextEditingController _mcCoPhoneController = TextEditingController();
  final TextEditingController _mcCoAboutController = TextEditingController();
  final TextEditingController _mcCoLocationController = TextEditingController();

  final TextEditingController _mcCeobioController = TextEditingController();
  final TextEditingController _mcCeoPhoneController = TextEditingController();

  // Production Decorators
  String productionAvater = '';
  String productionId = "";
  String productionUsername = "";
  String productionDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _productionCoKnownController =
      TextEditingController();
  final TextEditingController _productionCoPriceController =
      TextEditingController();
  final TextEditingController _productionCoPhoneController =
      TextEditingController();
  final TextEditingController _productionCoLocationController =
      TextEditingController();
  final TextEditingController _productionCoAboutController =
      TextEditingController();

  final TextEditingController _productionCeobioController =
      TextEditingController();
  final TextEditingController _productionCeoPhoneController =
      TextEditingController();

  //Decorators
  String decoratorAvater = '';
  String decoratorId = "";
  String decoratorUsername = "";
  String decoratorDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _decoratorCoKnownController =
      TextEditingController();
  final TextEditingController _decoratorCoPriceController =
      TextEditingController();
  final TextEditingController _decoratorCoPhoneController =
      TextEditingController();
  final TextEditingController _decoratorCoLocationController =
      TextEditingController();
  final TextEditingController _decoratorCoAboutController =
      TextEditingController();

  final TextEditingController _decoratorCeobioController =
      TextEditingController();
  final TextEditingController _decoratorCeoPhoneController =
      TextEditingController();

  //hall
  String hallAvater = '';
  String hallId = "";
  String hallUsername = "";
  String hallDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _hallCoKnownController = TextEditingController();
  final TextEditingController _hallCoPriceController = TextEditingController();
  final TextEditingController _hallCoPhoneController = TextEditingController();
  final TextEditingController _hallCoLocationController =
      TextEditingController();
  final TextEditingController _hallCoAboutController = TextEditingController();

  final TextEditingController _hallCeobioController = TextEditingController();
  final TextEditingController _hallCeoPhoneController = TextEditingController();

  //cake
  String cakeAvater = '';
  String cakeId = "";
  String cakeUsername = "";
  String cakeDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _cakeCoKnownController = TextEditingController();
  final TextEditingController _cakeCoPriceController = TextEditingController();
  final TextEditingController _cakeCoPhoneController = TextEditingController();
  final TextEditingController _cakeCoLocationController =
      TextEditingController();
  final TextEditingController _cakeCoAboutController = TextEditingController();

  final TextEditingController _cakeCeobioController = TextEditingController();
  final TextEditingController _cakeCeoPhoneController = TextEditingController();

  //singers
  String singersAvater = '';
  String singersId = "";
  String singersUsername = "";
  String singersDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _singersCoKnownController =
      TextEditingController();
  final TextEditingController _singersCoPriceController =
      TextEditingController();
  final TextEditingController _singersCoPhoneController =
      TextEditingController();
  final TextEditingController _singersCoLocationController =
      TextEditingController();
  final TextEditingController _singersCoAboutController =
      TextEditingController();

  final TextEditingController _singersCeobioController =
      TextEditingController();
  final TextEditingController _singersCeoPhoneController =
      TextEditingController();

  //dancers
  String dancersAvater = '';
  String dancersId = "";
  String dancersUsername = "";
  String dancersDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _dancersCoKnownController =
      TextEditingController();
  final TextEditingController _dancersCoPriceController =
      TextEditingController();
  final TextEditingController _dancersCoPhoneController =
      TextEditingController();
  final TextEditingController _dancersCoLocationController =
      TextEditingController();
  final TextEditingController _dancersCoAboutController =
      TextEditingController();

  final TextEditingController _dancersCeobioController =
      TextEditingController();
  final TextEditingController _dancersCeoPhoneController =
      TextEditingController();

  //cooker
  String cookerAvater = '';
  String cookerId = "";
  String cookerUsername = "";
  String cookerDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _cookerCoKnownController =
      TextEditingController();
  final TextEditingController _cookerCoPriceController =
      TextEditingController();
  final TextEditingController _cookerCoPhoneController =
      TextEditingController();
  final TextEditingController _cookerCoLocationController =
      TextEditingController();
  final TextEditingController _cookerCoAboutController =
      TextEditingController();

  final TextEditingController _cookerCeobioController = TextEditingController();
  final TextEditingController _cookerCeoPhoneController =
      TextEditingController();

  //saloon
  String saloonAvater = '';
  String saloonId = "";
  String saloonUsername = "";
  String saloonDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _saloonCoKnownController =
      TextEditingController();
  final TextEditingController _saloonCoPriceController =
      TextEditingController();
  final TextEditingController _saloonCoPhoneController =
      TextEditingController();
  final TextEditingController _saloonCoLocationController =
      TextEditingController();
  final TextEditingController _saloonCoAboutController =
      TextEditingController();

  final TextEditingController _saloonCeobioController = TextEditingController();
  final TextEditingController _saloonCeoPhoneController =
      TextEditingController();

  //Cars
  String carsAvater = '';
  String carsId = "";
  String carsUsername = "";
  String carsDefaultImg = "assets/busness/mc/mc2.png";
  final TextEditingController _carsCoKnownController = TextEditingController();
  final TextEditingController _carsCoPriceController = TextEditingController();
  final TextEditingController _carsCoPhoneController = TextEditingController();
  final TextEditingController _carsCoLocationController =
      TextEditingController();
  final TextEditingController _carsCoAboutController = TextEditingController();

  final TextEditingController _carsCeobioController = TextEditingController();
  final TextEditingController _carsCeoPhoneController = TextEditingController();

  File? _generalimage;

  // Implementing the image Camera picker
  _openImagePickerG(arg) async {
    final pickG = _pickerG.pickImage(source: ImageSource.gallery);
    XFile? pickedImage = await pickG;

    if (pickedImage != null) {
      setState(() {
        _generalimage = File(pickedImage.path);
      });
    }
  }

  // Implementing the image Camera picker
  _openImagePickerC(arg) async {
    final pickC = _picker.pickImage(source: ImageSource.camera);
    XFile? pickedImage = await pickC;

    if (pickedImage != null) {
      setState(() {
        _generalimage = File(pickedImage.path);
      });
    }
  }

  dynamic imaged;

// for Posting
  _postBusness(bType, knwnAs, coPro, defaultImg, price, no, adress, coName,
      ceoId, abtCeo, abtCo, msg1, msg2, msg3, msg4, msg5) async {
    if (coPro == null) {
      imaged = defaultImg;
    } else {
      imaged = coPro;
    }

    if (knwnAs.isNotEmpty) {
      if (price.isNotEmpty) {
        if (no.isNotEmpty) {
          if (_generalimage != null) {
            List<int> bytes = defaultImg.readAsBytesSync();
            String image = base64Encode(bytes);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BusnessSubscription(
                        busnessType: bType,
                        knownAs: knwnAs,
                        coProfile: image,
                        price: price,
                        contact: no,
                        location: adress,
                        companyName: coName,
                        ceoId: ceoId,
                        aboutCEO: abtCeo,
                        aboutCompany: abtCo,
                        createdBy: currentUser.id,
                        hotStatus: '0')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Insert Image, Try Again'),
            ));
          }
        } else {
          fillTheBlanks(msg3);
        }
      } else {
        fillTheBlanks(msg2);
      }
    } else {
      fillTheBlanks(msg1);
    }
  }

  // for Updating Cermony
  dynamic img;
  _updateBusness(bType, knwnAs, coPro, defaultImg, price, no, address, coName,
      ceoId, abtCeo, abtCo, lvl, msg1, msg2, msg3, msg4, msg5) async {
    if (_generalimage != null) {
      List<int> bytes = defaultImg.readAsBytesSync();
      img = base64Encode(bytes);
    }

    PostBusness(
      bId: widget.getData.bId,
      busnessType: bType,
      knownAs: knwnAs,
      coProfile: img ?? '',
      price: price,
      contact: no,
      location: address,
      companyName: coName,
      ceoId: ceoId,
      aboutCEO: abtCeo,
      aboutCompany: abtCo,
      createdBy: currentUser.id,
      hotStatus: '0',
      status: 0,
      payload: [],
      subscrlevel: lvl,
    ).update(token, urlUpdateBusness, coPro).then((v) {
      if (v.status == 200) {
        fillTheBlanks(v.payload);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BusnessScreen(
                      bsnType: widget.getData.busnessType,
                      ceremony: ceremony,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('System Error, Try Again'),
        ));
      }
    });
  }

  fillTheBlanks(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0),
          child: AppBar(
            backgroundColor: Colors.black87,
            title: const Text('YOUR BUSNESS', style: TextStyle(fontSize: 14)),
            centerTitle: true,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            categorySelect,

            const SizedBox(
              height: 5,
            ),

            //Background Image Upload
            if (selectedBusness == 'Please Choose Busness')
              const Text('Select Busness'),

            if (selectedBusness != 'Please Choose Busness')
              Card(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    // Busness Profile Image
                    Stack(children: [
                      // const Image(
                      //   image: AssetImage('assets/busness/mc/mc2.png'),
                      // ),

                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 120,
                        color: Colors.grey[300],
                        child: _generalimage != null
                            ? Image.file(_generalimage!,
                                width: 300, fit: BoxFit.cover)
                            : widget.getData.bId.isNotEmpty
                                ? Image.network(
                                    api +
                                        'public/uploads/' +
                                        widget.getData.username +
                                        '/busness/' +
                                        widget.getData.coProfile,
                                    fit: BoxFit.cover,
                                  )
                                : const Image(
                                    image: AssetImage(
                                        'assets/busness/mc/mc2.png')),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Upload Photo',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),

                    //Buttons Image Upload
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Gallary
                          GestureDetector(
                            onTap: () {
                              _openImagePickerG('slctdChereko');
                            },
                            child: Row(
                              children: const [
                                Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.photo_library,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.black45,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Gallery',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              _openImagePickerC('slctdChereko');
                            },
                            child: Row(
                              children: const [
                                Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.photo_library,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.black45,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8.0),

            //Tabs Bar Buttons
            if (selectedBusness != 'Please Choose Busness')
              const TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(child: Text('Co')),
                    Tab(
                      child: Text('C.E.O'),
                    ),
                    Tab(
                      child: Text('Work'),
                    ),
                    Tab(
                      child: Text('staff'),
                    ),
                  ]),
            //Tabs Views
            if (selectedBusness != 'Please Choose Busness')
              Expanded(
                  child: TabBarView(children: [
                Column(
                  children: [
                    if (selectedBusness == _busness[0]) mcCoCategory,
                    if (selectedBusness == _busness[1]) prodCoCategory,
                    if (selectedBusness == _busness[2]) decCoCategory,
                    if (selectedBusness == _busness[3]) hallCoCategory,
                    if (selectedBusness == _busness[4]) cakeCoCategory,
                    if (selectedBusness == _busness[5]) singCoCategory,
                    if (selectedBusness == _busness[6]) dancCoCategory,
                    if (selectedBusness == _busness[7]) cokCoCategory,
                    if (selectedBusness == _busness[8]) salCoCategory,
                    if (selectedBusness == _busness[9]) carCoCategory,
                  ],
                ),
                Column(
                  children: [
                    if (selectedBusness == _busness[0]) mcCeoCategory,
                    if (selectedBusness == _busness[1]) prodCeoCategory,
                    if (selectedBusness == _busness[2]) decCeoCategory,
                    if (selectedBusness == _busness[3]) hallCeoCategory,
                    if (selectedBusness == _busness[4]) cakeCeoCategory,
                    if (selectedBusness == _busness[5]) singCeoCategory,
                    if (selectedBusness == _busness[6]) dancCeoCategory,
                    if (selectedBusness == _busness[7]) cokCeoCategory,
                    if (selectedBusness == _busness[8]) salCeoCategory,
                    if (selectedBusness == _busness[9]) carCeoCategory,
                  ],
                ),
                Column(
                  children: [
                    if (selectedBusness == _busness[0]) mcWorkCategory,
                    if (selectedBusness == _busness[1]) prodWorkCategory,
                    if (selectedBusness == _busness[2]) decWorkCategory,
                    if (selectedBusness == _busness[3]) hallWorkCategory,
                    if (selectedBusness == _busness[4]) cakeWorkCategory,
                    if (selectedBusness == _busness[5]) singWorkCategory,
                    if (selectedBusness == _busness[6]) dancWorkCategory,
                    if (selectedBusness == _busness[7]) cokWorkCategory,
                    if (selectedBusness == _busness[8]) salWorkCategory,
                    if (selectedBusness == _busness[9]) carWorkCategory
                  ],
                ),
                Column(
                  children: [
                    if (selectedBusness == _busness[0]) mcStaffCategory,
                    if (selectedBusness == _busness[1]) prodStaffCategory,
                    if (selectedBusness == _busness[2]) decStaffCategory,
                    if (selectedBusness == _busness[3]) hallStaffCategory,
                    if (selectedBusness == _busness[4]) cakeStaffCategory,
                    if (selectedBusness == _busness[5]) singStaffCategory,
                    if (selectedBusness == _busness[6]) dancStaffCategory,
                    if (selectedBusness == _busness[7]) cokStaffCategory,
                    if (selectedBusness == _busness[8]) salStaffCategory,
                    if (selectedBusness == _busness[9]) carStaffCategory,
                  ],
                ),
              ])),
          ],
        ),
        floatingActionButton: selectedBusness != 'Please Choose Busness'
            ? FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 17, 17, 17),
                //objects will be added to the database when this button is clicked.
                onPressed: () {
                  if (selectedBusness == 'Mc') {
                    if (widget.getData.bId.isEmpty) {
                      _postBusness(
                          selectedBusness,
                          _mcCoKnownController.text,
                          mcDefaultImg,
                          _generalimage,
                          _mcCoPriceController.text,
                          _mcCoPhoneController.text,
                          _mcCoLocationController.text,
                          _mcCoKnownController.text,
                          mcId,
                          _mcCeobioController.text,
                          _mcCoAboutController.text,
                          'Insert your Brand Name on "CO Tab" pls!...',
                          'Insert your Price on "Co Tab" pls!...',
                          'Insert your Phone Number  on "Co Tab" pls!...',
                          'Insert Contact  on "Co Tab" pls!...',
                          'msg5');
                    } else {
                      _updateBusness(
                          selectedBusness,
                          _mcCoKnownController.text,
                          widget.getData.coProfile,
                          _generalimage,
                          _mcCoPriceController.text,
                          _mcCoPhoneController.text,
                          _mcCoLocationController.text,
                          _mcCoKnownController.text,
                          mcId,
                          _mcCeobioController.text,
                          _mcCoAboutController.text,
                          _mcSubscription,
                          'Insert your Brand Name on "CO Tab" pls!...',
                          'Insert your Price on "Co Tab" pls!...',
                          'Insert your Phone Number  on "Co Tab" pls!...',
                          'Insert Contact  on "Co Tab" pls!...',
                          '');
                    }
                  }

                  if (selectedBusness == 'Production') {
                    _postBusness(
                        selectedBusness,
                        _productionCoKnownController.text,
                        productionDefaultImg,
                        _generalimage,
                        _productionCoPriceController.text,
                        _productionCoPhoneController.text,
                        _productionCoLocationController.text,
                        _productionCoKnownController.text,
                        productionId,
                        _productionCeobioController.text,
                        _productionCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'Decorator') {
                    _postBusness(
                        selectedBusness,
                        _decoratorCoKnownController.text,
                        decoratorDefaultImg,
                        _generalimage,
                        _decoratorCoPriceController.text,
                        _decoratorCoPhoneController.text,
                        _decoratorCoLocationController.text,
                        _decoratorCoKnownController.text,
                        decoratorId,
                        _decoratorCeobioController.text,
                        _decoratorCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }
                  if (selectedBusness == 'Halls') {
                    _postBusness(
                        selectedBusness,
                        _hallCoKnownController.text,
                        hallDefaultImg,
                        _generalimage,
                        _hallCoPriceController.text,
                        _hallCoPhoneController.text,
                        _hallCoLocationController.text,
                        _hallCoKnownController.text,
                        hallId,
                        _hallCeobioController.text,
                        _hallCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'Cake Bekar') {
                    _postBusness(
                        selectedBusness,
                        _cakeCoKnownController.text,
                        cakeDefaultImg,
                        _generalimage,
                        _cakeCoPriceController.text,
                        _cakeCoPhoneController.text,
                        _cakeCoLocationController.text,
                        _cakeCoKnownController.text,
                        cakeId,
                        _cakeCeobioController.text,
                        _cakeCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'Singer') {
                    _postBusness(
                        selectedBusness,
                        _singersCoKnownController.text,
                        singersDefaultImg,
                        _generalimage,
                        _singersCoPriceController.text,
                        _singersCoPhoneController.text,
                        _singersCoLocationController.text,
                        _singersCoKnownController.text,
                        singersId,
                        _singersCeobioController.text,
                        _singersCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'Dancer') {
                    _postBusness(
                        selectedBusness,
                        _dancersCoKnownController.text,
                        dancersDefaultImg,
                        _generalimage,
                        _dancersCoPriceController.text,
                        _dancersCoPhoneController.text,
                        _dancersCoLocationController.text,
                        _dancersCoKnownController.text,
                        dancersId,
                        _dancersCeobioController.text,
                        _dancersCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'Cooker') {
                    _postBusness(
                        selectedBusness,
                        _cookerCoKnownController.text,
                        cookerDefaultImg,
                        _generalimage,
                        _cookerCoPriceController.text,
                        _cookerCoPhoneController.text,
                        _cookerCoLocationController.text,
                        _cookerCoKnownController.text,
                        cookerId,
                        _cookerCeobioController.text,
                        _cookerCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }

                  if (selectedBusness == 'saloon') {
                    _postBusness(
                        selectedBusness,
                        _saloonCoKnownController.text,
                        saloonDefaultImg,
                        _generalimage,
                        _saloonCoPriceController.text,
                        _saloonCoPhoneController.text,
                        _saloonCoLocationController.text,
                        _saloonCoKnownController.text,
                        saloonId,
                        _saloonCeobioController.text,
                        _saloonCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }
                  if (selectedBusness == 'Car') {
                    _postBusness(
                        selectedBusness,
                        _carsCoKnownController.text,
                        carsDefaultImg,
                        _generalimage,
                        _carsCoPriceController.text,
                        _carsCoPhoneController.text,
                        _carsCoLocationController.text,
                        _carsCoKnownController.text,
                        carsId,
                        _carsCeobioController.text,
                        _carsCoAboutController.text,
                        'Insert your Brand Name on "CO Tab" pls!...',
                        'Insert your Price on "Co Tab" pls!...',
                        'Insert your Phone Number  on "Co Tab" pls!...',
                        'Insert Contact  on "Co Tab" pls!...',
                        'msg5');
                  }
                },

                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget get categorySelect => Container(
        margin: selectedBusness != 'Please Choose Busness'
            ? const EdgeInsets.only(left: 20, right: 20)
            : const EdgeInsets.only(left: 20, right: 20, top: 250),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            // icon: const Icon(Icons.arrow_circle_down),
            // iconSize: 20,
            // elevation: 16,
            underline: Container(),
            items: _busness.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Container(
              alignment: Alignment.center,
              child: Text(
                selectedBusness,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            onChanged: (v) {
              setState(() {
                // print(v);
                selectedBusness = v!;
              });
            },
          ),
        ),
      );

  Widget get mcCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'McCo',
            _mcCoKnownController,
            _mcCoPriceController,
            _mcCoPhoneController,
            _mcCoLocationController,
            _mcCoAboutController,
          ),
        ),
      );

  Widget get mcCeoCategory => Expanded(
        child: SingleChildScrollView(
          child: ceoCategory('McCEO', mcAvater, mcUsername, _mcCeobioController,
              _mcCeoPhoneController),
        ),
      );

  Widget get mcWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: workCategory('McWork'),
        ),
      );

  //Workers List Category
  Column workCategory(category) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),

        //Title Our Work
        Container(
          height: 30,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.grey.shade200,
                // alignment: Alignment.topLeft,
                child: const Text('Our Work Photo'),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    ourWorkPhoto();
                  })
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 150,
                          height: 110,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Card(
                            child: Column(children: [
                              const Icon(
                                Icons.image,
                              ),

                              // Image(
                              //   image: AssetImage(
                              //       'assets/busness/mc/mc1.png'),
                              //   fit: BoxFit.cover,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'Ceremony Code',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ),
                              const Text('dd/mm/yyy',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold))
                            ]),
                          )),
                      Container(
                          width: 150,
                          height: 110,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Card(
                            child: Column(children: [
                              const Image(
                                image: AssetImage('assets/busness/mc/mc1.png'),
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'Mr&Mrs Mwansasu12',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ),
                              const Text('12/12/2022',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold))
                            ]),
                          )),
                    ]),
                //work Upload Buttn
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.photo_album,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        const SizedBox(
          height: 15,
        ),

        //Title Our Facilities
        Container(
          height: 30,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.grey.shade200,
                // alignment: Alignment.topLeft,
                child: const Text('Our Facilities Photo'),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    ourWorkPhoto();
                  })
            ],
          ),
        ),

        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 150,
                          height: 110,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Card(
                            child: Column(children: [
                              const Icon(
                                Icons.image,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'Facilities Name',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ),
                            ]),
                          )),
                      Container(
                          width: 150,
                          height: 110,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Card(
                            child: Column(children: [
                              const Image(
                                image: AssetImage('assets/busness/mc/mc1.png'),
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'Facilities name',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ),
                            ]),
                          )),
                    ]),
                //work Upload Buttn
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.photo_album,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget get mcStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      //oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // production
  Widget get prodCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'ProductionCo',
            _productionCoKnownController,
            _productionCoPriceController,
            _productionCoPhoneController,
            _productionCoLocationController,
            _productionCoAboutController,
          ),
        ),
      );

  Widget get prodCeoCategory => Expanded(
        child: SingleChildScrollView(
          child: ceoCategory(
              'ProductionCEO',
              productionAvater,
              productionUsername,
              _productionCeobioController,
              _productionCeoPhoneController),
        ),
      );

  Widget get prodWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get prodStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      //oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // Decorators
  Widget get decCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'decoratorCo',
            _decoratorCoKnownController,
            _decoratorCoPriceController,
            _decoratorCoPhoneController,
            _decoratorCoLocationController,
            _decoratorCoAboutController,
          ),
        ),
      );

  Widget get decCeoCategory => Expanded(
      child: SingleChildScrollView(
          child: ceoCategory('decoratorCEO', decoratorAvater, decoratorUsername,
              _decoratorCeobioController, _decoratorCeoPhoneController)));

  Widget get decWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get decStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

// Hall
  Widget get hallCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'hallCo',
            _hallCoKnownController,
            _hallCoPriceController,
            _hallCoPhoneController,
            _hallCoLocationController,
            _hallCoAboutController,
          ),
        ),
      );

  Widget get hallCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('hallCEO', hallAvater, hallUsername,
                _hallCeobioController, _hallCeoPhoneController)),
      );

  Widget get hallWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get hallStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // Cake Baker
  Widget get cakeCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'cakeCo',
            _cakeCoKnownController,
            _cakeCoPriceController,
            _cakeCoPhoneController,
            _cakeCoLocationController,
            _cakeCoAboutController,
          ),
        ),
      );

  Widget get cakeCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('cakeCEO', cakeAvater, cakeUsername,
                _cakeCeobioController, _cakeCeoPhoneController)),
      );

  Widget get cakeWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get cakeStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // Singers
  Widget get singCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'singersCo',
            _singersCoKnownController,
            _singersCoPriceController,
            _singersCoPhoneController,
            _singersCoLocationController,
            _singersCoAboutController,
          ),
        ),
      );

  Widget get singCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('singersCEO', singersAvater, singersUsername,
                _singersCeobioController, _singersCeoPhoneController)),
      );

  Widget get singWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get singStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

// Dancer
  Widget get dancCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'dancersCo',
            _dancersCoKnownController,
            _dancersCoPriceController,
            _dancersCoPhoneController,
            _dancersCoLocationController,
            _dancersCoAboutController,
          ),
        ),
      );

  Widget get dancCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('dancersCEO', dancersAvater, dancersUsername,
                _dancersCeobioController, _dancersCeoPhoneController)),
      );

  Widget get dancWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get dancStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

// Cookers
  Widget get cokCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'cookerCo',
            _cookerCoKnownController,
            _cookerCoPriceController,
            _cookerCoPhoneController,
            _cookerCoLocationController,
            _cookerCoAboutController,
          ),
        ),
      );

  Widget get cokCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('cookerCEO', cookerAvater, cookerUsername,
                _cookerCeobioController, _cookerCeoPhoneController)),
      );

  Widget get cokWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get cokStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // Saloon
  Widget get salCoCategory => Expanded(
        child: SingleChildScrollView(
            child: coCategory(
          'saloonCo',
          _saloonCoKnownController,
          _saloonCoPriceController,
          _saloonCoPhoneController,
          _saloonCoLocationController,
          _saloonCoAboutController,
        )),
      );

  Widget get salCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('saloonCEO', saloonAvater, saloonUsername,
                _saloonCeobioController, _saloonCeoPhoneController)),
      );

  Widget get salWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get salStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

// Wedding Cars
  Widget get carCoCategory => Expanded(
        child: SingleChildScrollView(
          child: coCategory(
            'carsCo',
            _carsCoKnownController,
            _carsCoPriceController,
            _carsCoPhoneController,
            _carsCoLocationController,
            _carsCoAboutController,
          ),
        ),
      );

  Widget get carCeoCategory => Expanded(
        child: SingleChildScrollView(
            child: ceoCategory('carsCEO', carsAvater, carsUsername,
                _carsCeobioController, _carsCeoPhoneController)),
      );

  Widget get carWorkCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //Title Our Work
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Work Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),

                                    // Image(
                                    //   image: AssetImage(
                                    //       'assets/busness/mc/mc1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Ceremony Code',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('dd/mm/yyy',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Mr&Mrs Mwansasu12',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    const Text('12/12/2022',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),

              //Title Our Facilities
              Container(
                height: 30,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      // alignment: Alignment.topLeft,
                      child: const Text('Our Facilities Photo'),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                        ),
                        color: Colors.blueGrey,
                        onPressed: () {
                          ourWorkPhoto();
                        })
                  ],
                ),
              ),

              Card(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Icon(
                                      Icons.image,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities Name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                            Container(
                                width: 150,
                                height: 110,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Card(
                                  child: Column(children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Facilities name',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                  ]),
                                )),
                          ]),
                      //work Upload Buttn
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.photo_album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget get carStaffCategory => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: const Text('Co Members',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  GestureDetector(
                    onTap: () {
                      //oneButtonPressed();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 14, top: 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Insert Members',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/busness/profile.jpg'),
                      ),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                child: const Card(
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/busness/profile.jpg')),
                      title: Text('User Name'),
                      subtitle: Text('Sub tile'),
                      trailing: Icon(Icons.select_all)),
                ),
              ),
            ],
          ),
        ),
      );

  // Ohter function
  // Bottom Model For Search
  void oneButtonPressed(categoryType) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 600,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  children: [
                    // Search Container
                    Container(
                      height: 40,
                      margin:
                          const EdgeInsets.only(left: 35, top: 20, right: 35),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        cursorColor: Colors.grey[500]!.withOpacity(0.2),
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.0),
                              child: Icon(
                                Icons.search,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search ...',
                            hintStyle: TextStyle(fontSize: 14, height: 1.5)),
                        onChanged: (value) => _runFilter(value),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Searched Results
                    SizedBox(
                      height: 330,
                      child: _foundUsers.isNotEmpty
                          ? ListView.builder(
                              itemCount: _foundUsers.length,
                              itemBuilder: (BuildContext context, index) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 1, left: 10, right: 10),
                                        child: Card(
                                          child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  if (categoryType == 'McCEO') {
                                                    mcAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    mcId =
                                                        _foundUsers[index].id;
                                                    mcUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'ProductionCEO') {
                                                    productionAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    productionId =
                                                        _foundUsers[index].id;
                                                    productionUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'decoratorCEO') {
                                                    decoratorAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    decoratorId =
                                                        _foundUsers[index].id;
                                                    decoratorUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'hallCEO') {
                                                    hallAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    hallId =
                                                        _foundUsers[index].id;
                                                    hallUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'cakeCEO') {
                                                    cakeAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    cakeId =
                                                        _foundUsers[index].id;
                                                    cakeUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'singersCEO') {
                                                    singersAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    singersId =
                                                        _foundUsers[index].id;
                                                    singersUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'dancersCEO') {
                                                    dancersAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    dancersId =
                                                        _foundUsers[index].id;
                                                    dancersUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'cookerCEO') {
                                                    cookerAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    cookerId =
                                                        _foundUsers[index].id;
                                                    cookerUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'saloonCEO') {
                                                    saloonAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    saloonId =
                                                        _foundUsers[index].id;
                                                    saloonUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }

                                                  if (categoryType ==
                                                      'carsCEO') {
                                                    carsAvater =
                                                        _foundUsers[index]
                                                            .avater;
                                                    carsId =
                                                        _foundUsers[index].id;
                                                    carsUsername =
                                                        _foundUsers[index]
                                                            .username;
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              leading:
                                                  _foundUsers[index].avater !=
                                                          ''
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                          api +
                                                              'public/uploads/' +
                                                              _foundUsers[index]
                                                                  .username +
                                                              '/profile/' +
                                                              _foundUsers[index]
                                                                  .avater,
                                                          // height: 45,
                                                          // fit: BoxFit.cover,
                                                        ))
                                                      : const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          child: ClipOval(
                                                              child: Image(
                                                            image: AssetImage(
                                                                'assets/profile/profile.jpg'),
                                                            fit: BoxFit.cover,
                                                            width: 110,
                                                            height: 110,
                                                          ))),
                                              title: Text(
                                                  _foundUsers[index].username),
                                              subtitle:
                                                  _foundUsers[index].gender ==
                                                          'f'
                                                      ? const Text('Female')
                                                      : const Text('Male'),
                                              trailing:
                                                  const Icon(Icons.select_all)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : const Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            ),
                    )
                  ],
                )),
          );
        });
  }

  void ourWorkPhoto() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 600,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: buildWorkPhoto()),
          );
        });
  }

  //Co Categeroies
  Column coCategory(category, known, price, phone, location, coBio) {
    return Column(
      children: [
        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('Brand Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: known,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Known',
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
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: price,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'My Price',
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
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('Contact',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Phone No',
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('Contact',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: location,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Regional / Location',
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
              ],
            )),
        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('About Group/Organization',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 75,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: coBio,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'About Group/Organization',
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
              ],
            )),
      ],
    );
  }

  //CEO category
  Column ceoCategory(category, avater, name, bio, contact) {
    return Column(
      children: [
        // Profile
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: avater == ''
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/busness/profile.jpg'),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                        api +
                                            'public/uploads/' +
                                            name +
                                            '/profile/' +
                                            avater,
                                      )),
                              )),
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: name == ''
                                      ? const Text(
                                          ' User Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        )
                                      : Text(
                                          name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        )),
                              GestureDetector(
                                onTap: () {
                                  oneButtonPressed(category);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 4.0, left: 8, right: 8, top: 4),
                                    child: Text(
                                      'Select CEO User ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        const SizedBox(
          height: 10,
        ),

        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('About C.E.O',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 75,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: bio,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Bio',
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
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: const Text('Contact',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start),
                ),
                Container(
                  height: 45,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: contact,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Phone No',
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
              ],
            )),
      ],
    );
  }

  Column buildWorkPhoto() {
    return Column(
      children: [
        Container(
          height: 40,
          margin: const EdgeInsets.only(left: 35, top: 20, right: 35),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            cursorColor: Colors.grey[500]!.withOpacity(0.2),
            decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Icon(
                    Icons.search,
                    size: 22,
                    color: Colors.grey,
                  ),
                ),
                border: InputBorder.none,
                hintText: 'Search Spouse',
                hintStyle: TextStyle(fontSize: 14, height: 1.5)),
            onChanged: (value) {
              setState(() {
                //_email = value;
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 330,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                  child: const Card(
                    child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/busness/profile.jpg')),
                        title: Text('User Name'),
                        subtitle: Text('Sub tile'),
                        trailing: Icon(Icons.select_all)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                  child: const Card(
                    child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/busness/profile.jpg')),
                        title: Text('User Name'),
                        subtitle: Text('Sub tile'),
                        trailing: Icon(Icons.select_all)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                  child: const Card(
                    child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/busness/profile.jpg')),
                        title: Text('User Name'),
                        subtitle: Text('Sub tile'),
                        trailing: Icon(Icons.select_all)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1, left: 10, right: 10),
                  child: const Card(
                    child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/busness/profile.jpg')),
                        title: Text('User Name'),
                        subtitle: Text('Sub tile'),
                        trailing: Icon(Icons.select_all)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  busnessSave() {
    return Container(
      width: 100,
      height: 40,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Text(
        'Save',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
