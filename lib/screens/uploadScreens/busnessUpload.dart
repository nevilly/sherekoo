import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';

import '../../model/busness/busness-call.dart';
import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../bsnScreen/bsn-screen.dart';
import 'medias-upload.dart';

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
    'Cake Bakery',
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

  List<User> _allUsers = [];
  List<User> _foundUsers = []; //search

  // for_Search Result
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user.username!
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
        // getUser();
        getAllUsers();

        if (widget.getData.bId.isNotEmpty) {
          selectedBusness = widget.getData.busnessType;

          if (widget.getData.busnessType == 'Mc') {
            mcAvater = widget.getData.user.avater!;
            mcId = widget.getData.ceoId;
            mcUsername = widget.getData.user.username!;
            _mcSubscription = widget.getData.subscriptionInfo!.level;
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
            productionAvater = widget.getData.user.avater!;
            productionId = widget.getData.ceoId;
            productionUsername = widget.getData.user.username!;
            productionSubscription = widget.getData.subscriptionInfo!.level;
            productionDefaultImg = widget.getData.coProfile;
            _productionCoKnownController.text = widget.getData.knownAs;
            _productionCoPriceController.text = widget.getData.price;
            _productionCoPhoneController.text = widget.getData.contact;
            _productionCoLocationController.text = widget.getData.location;

            _productionCoAboutController.text = widget.getData.aboutCompany;

            _productionCeobioController.text = widget.getData.aboutCEO;
            _productionCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Decorator') {
            decoratorAvater = widget.getData.user.avater!;
            decoratorId = widget.getData.ceoId;
            decoratorUsername = widget.getData.user.username!;
            decoratorSubscription = widget.getData.subscriptionInfo!.level;
            decoratorDefaultImg = widget.getData.coProfile;
            _decoratorCoKnownController.text = widget.getData.knownAs;
            _decoratorCoPriceController.text = widget.getData.price;
            _decoratorCoPhoneController.text = widget.getData.contact;
            _decoratorCoLocationController.text = widget.getData.location;
            _decoratorCoAboutController.text = widget.getData.aboutCompany;

            _decoratorCeobioController.text = widget.getData.aboutCEO;
            _decoratorCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Hall') {
            hallAvater = widget.getData.user.avater!;
            hallId = widget.getData.ceoId;
            hallUsername = widget.getData.user.username!;
            hallSubscription = widget.getData.subscriptionInfo!.level;
            hallDefaultImg = widget.getData.coProfile;
            _hallCoKnownController.text = widget.getData.knownAs;
            _hallCoPriceController.text = widget.getData.price;
            _hallCoPhoneController.text = widget.getData.contact;
            _hallCoLocationController.text = widget.getData.location;
            _hallCoAboutController.text = widget.getData.aboutCompany;
            _hallCeobioController.text = widget.getData.aboutCEO;
            _hallCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Cake Bakery') {
            cakeAvater = widget.getData.user.avater!;
            cakeId = widget.getData.ceoId;
            cakeUsername = widget.getData.user.username!;
            cakeSubscription = widget.getData.subscriptionInfo!.level;
            cakeDefaultImg = widget.getData.coProfile;
            _cakeCoKnownController.text = widget.getData.knownAs;
            _cakeCoPriceController.text = widget.getData.price;
            _cakeCoPhoneController.text = widget.getData.contact;
            _cakeCoLocationController.text = widget.getData.location;
            _cakeCoAboutController.text = widget.getData.aboutCompany;
            _cakeCeobioController.text = widget.getData.aboutCEO;
            _cakeCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Singer') {
            singersAvater = widget.getData.user.avater!;
            singersId = widget.getData.ceoId;
            singersUsername = widget.getData.user.username!;
            singersSubscription = widget.getData.subscriptionInfo!.level;
            singersDefaultImg = widget.getData.coProfile;
            _singersCoKnownController.text = widget.getData.knownAs;
            _singersCoPriceController.text = widget.getData.price;
            _singersCoPhoneController.text = widget.getData.contact;
            _singersCoLocationController.text = widget.getData.location;
            _singersCoAboutController.text = widget.getData.aboutCompany;
            _singersCeobioController.text = widget.getData.aboutCEO;
            _singersCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Dancer') {
            dancersAvater = widget.getData.user.avater!;
            dancersId = widget.getData.ceoId;
            dancersUsername = widget.getData.user.username!;
            dancersSubscription = widget.getData.subscriptionInfo!.level;
            dancersDefaultImg = widget.getData.coProfile;
            _dancersCoKnownController.text = widget.getData.knownAs;
            _dancersCoPriceController.text = widget.getData.price;
            _dancersCoPhoneController.text = widget.getData.contact;
            _dancersCoLocationController.text = widget.getData.location;
            _dancersCoAboutController.text = widget.getData.aboutCompany;
            _dancersCeobioController.text = widget.getData.aboutCEO;
            _dancersCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Cooker') {
            cookerAvater = widget.getData.user.avater!;
            cookerId = widget.getData.ceoId;
            cookerUsername = widget.getData.user.username!;
            cookerSubscription = widget.getData.subscriptionInfo!.level;
            cookerDefaultImg = widget.getData.coProfile;
            _cookerCoKnownController.text = widget.getData.knownAs;
            _cookerCoPriceController.text = widget.getData.price;
            _cookerCoPhoneController.text = widget.getData.contact;
            _cookerCoLocationController.text = widget.getData.location;
            _cookerCoAboutController.text = widget.getData.aboutCompany;
            _cookerCeobioController.text = widget.getData.aboutCEO;
            _cookerCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'saloon') {
            saloonAvater = widget.getData.user.avater!;
            saloonId = widget.getData.ceoId;
            saloonUsername = widget.getData.user.username!;
            saloonSubscription = widget.getData.subscriptionInfo!.level;
            saloonDefaultImg = widget.getData.coProfile;
            _saloonCoKnownController.text = widget.getData.knownAs;
            _saloonCoPriceController.text = widget.getData.price;
            _saloonCoPhoneController.text = widget.getData.contact;
            _saloonCoLocationController.text = widget.getData.location;
            _saloonCoAboutController.text = widget.getData.aboutCompany;
            _saloonCeobioController.text = widget.getData.aboutCEO;
            _saloonCeoPhoneController.text = widget.getData.contact;
          }
          if (widget.getData.busnessType == 'Car') {
            carsAvater = widget.getData.user.avater!;
            carsId = widget.getData.ceoId;
            carsUsername = widget.getData.user.username!;
            carsSubscription = widget.getData.subscriptionInfo!.level;
            carsDefaultImg = widget.getData.coProfile;
            _carsCoKnownController.text = widget.getData.knownAs;
            _carsCoPriceController.text = widget.getData.price;
            _carsCoPhoneController.text = widget.getData.contact;
            _carsCoLocationController.text = widget.getData.location;
            _carsCoAboutController.text = widget.getData.aboutCompany;
            _carsCeobioController.text = widget.getData.aboutCEO;
            _carsCeoPhoneController.text = widget.getData.contact;
          }
        }
      });
    });
    _foundUsers = _allUsers;
    super.initState();
  }

  // getUser() async {
  //   AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
  //     setState(() {
  //       if (value.status == 200) {
  //         currentUser = User.fromJson(value.payload);
  //       }
  //     });
  //   });
  // }

  getAllUsers() async {
    UsersCall(payload: [], status: 0).get(token, urlUserList).then((value) {
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
  String productionSubscription = "";
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
  String decoratorSubscription = '';
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
  String hallSubscription = '';
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
  String cakeSubscription = '';
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
  String singersSubscription = '';
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
  String dancersSubscription = '';
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
  String cookerSubscription = '';
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
  String saloonSubscription = '';
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
  String carsSubscription = '';
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

  // Image Picking
  _openImagePicker(ImageSource source) async {
    final pick = _picker.pickImage(source: source, imageQuality: 25);
    XFile? pickedImage = await pick;
    if (pickedImage == null) return;

    File img = File(pickedImage.path);
    img = await cropImage(img);

    setState(() {
      _generalimage = img;
    });
  }

  // Image Croping

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
                    builder: (BuildContext context) => BsnMediaUpload(
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
                        createdBy: '',
                        hotStatus: '0')

                    // BusnessSubscription(
                    //     busnessType: bType,
                    //     knownAs: knwnAs,
                    //     coProfile: image,
                    //     price: price,
                    //     contact: no,
                    //     location: adress,
                    //     companyName: coName,
                    //     ceoId: ceoId,
                    //     aboutCEO: abtCeo,
                    //     aboutCompany: abtCo,
                    //     createdBy: '',
                    //     hotStatus: '0')

                    ));
          } else {
            fillTheBlanks(context, imgInsertAlt, altSty, odng);
          }
        } else {
          fillTheBlanks(context, msg3, altSty, odng);
        }
      } else {
        fillTheBlanks(context, msg2, altSty, odng);
      }
    } else {
      fillTheBlanks(context, msg1, altSty, odng);
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

    BusnessCall(
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
      createdBy: '',
      hotStatus: '0',
      status: 0,
      payload: [],
      subscrlevel: lvl,
    ).update(token, urlUpdateBusness, coPro).then((v) {
      if (v.status == 200) {
        fillTheBlanks(context, v.payload, altSty, odng);
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BusnessScreen(
                      bsnType: widget.getData.busnessType,
                      ceremony: emptyCrmModel,
                    )));
      } else {
        fillTheBlanks(context, sysErr, altSty, odng);
      }
    });
  }

  // TabBar get _tabBar => TabBar(
  //         labelColor: OColors.primary,
  //         unselectedLabelColor: Colors.grey,
  //         indicatorColor: OColors.primary,
  //         indicatorWeight: 2,
  //         tabs: const [
  //           Tab(child: Text('Busness Info')),
  //           // Tab(
  //           //   child: Text('Owner Details'),
  //           // ),

  //           // Tab(
  //           //   child: Text('Work'),
  //           // ),
  //           // Tab(
  //           //   child: Text('staff'),
  //           // ),
  //         ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.appBarColor,
        title: Text('Busness', style: header14),
        centerTitle: true,
        toolbarHeight: 50,
        actions: [
          selectedBusness != 'Please Choose Busness'
              ? GestureDetector(
                  onTap: () {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Production') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      } else {
                        _updateBusness(
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
                            productionSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Decorator') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      } else {
                        _updateBusness(
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
                            decoratorSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Halls') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            hallSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Cake Bakery') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);

                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            cakeSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Singer') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);

                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            singersSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Dancer') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);

                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            dancersSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'Cooker') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);

                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            cookerSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }

                    if (selectedBusness == 'saloon') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            saloonSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }
                    if (selectedBusness == 'Car') {
                      if (widget.getData.bId.isEmpty) {
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
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                        // if (widget.getData.bId.isEmpty) {
                      } else {
                        _updateBusness(
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
                            carsSubscription,
                            insertBrandName,
                            insertPrice,
                            insertPhoneNumber,
                            insertContact,
                            insertLastMsg);
                      }
                    }
                  },
                  child: busnessSave())
              : const SizedBox(),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          categorySelect,

          const SizedBox(
            height: 5,
          ),

          //Background Image Upload
          if (selectedBusness == 'Please Choose Busness')
            Text('Select Busness', style: TextStyle(color: OColors.fontColor)),

          if (selectedBusness != 'Please Choose Busness')
            Card(
              color: OColors.darGrey,
              child: Stack(children: [
                SizedBox(
                  width: 310,
                  height: 120,
                  child: _generalimage != null
                      ? Image.file(_generalimage!,
                          width: 300, fit: BoxFit.cover)
                      : widget.getData.bId.isNotEmpty
                          ? Image.network(
                              '${api}${widget.getData.mediaUrl}',
                              fit: BoxFit.cover,
                            )
                          : const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/logo/noimage.png')),
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: OColors.primary,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Upload ',
                          style: TextStyle(
                              color: OColors.fontColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Gallary
                      GestureDetector(
                        onTap: () {
                          _openImagePicker(ImageSource.gallery);
                        },
                        child: Card(
                          color: OColors.primary,
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _openImagePicker(ImageSource.camera);
                        },
                        child: Card(
                          color: OColors.primary,
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),

          //Tabs Bar Buttons
          // if (selectedBusness != 'Please Choose Busness')
          //   // PreferredSize(
          //   //     preferredSize: _tabBar.preferredSize,
          //   //     child: Container(
          //   //         decoration: const BoxDecoration(
          //   //             border: Border(
          //   //                 bottom:
          //   //                     BorderSide(color: Colors.grey, width: 0.8))),
          //   //         child:
          //   //             ColoredBox(color: OColors.darGrey, child: _tabBar))),
          //   Container(
          //       width: MediaQuery.of(context).size.width,
          //       color: OColors.darGrey,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text('Busness Info', style: header16),
          //       )),
          //Tabs Views
          if (selectedBusness != 'Please Choose Busness')
            Expanded(
                child: Column(
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
            )),
        ],
      ),
    );
  }

  Widget get categorySelect => Container(
        height: 40,
        margin: selectedBusness != 'Please Choose Busness'
            ? const EdgeInsets.only(left: 20, right: 20)
            : const EdgeInsets.only(left: 20, right: 20, top: 250),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: OColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            // icon: const Icon(Icons.arrow_circle_down),
            // iconSize: 20,
            // elevation: 16,
            dropdownColor: OColors.darGrey,
            underline: Container(),
            items: _busness.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: OColors.fontColor)),
              );
            }).toList(),
            hint: Container(
              // color: OColors.darGrey,
              alignment: Alignment.center,
              child: Text(
                selectedBusness,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: OColors.fontColor),
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
                    // color: Theme.of(context).canvasColor,
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  children: [
                    // Search Container
                    Container(
                      height: 35,
                      margin:
                          const EdgeInsets.only(left: 35, top: 10, right: 35),
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
                      height: 5,
                    ),

                    // Searched Results
                    Expanded(
                      child: _foundUsers.isNotEmpty
                          ? ListView.builder(
                              itemCount: _foundUsers.length,
                              itemBuilder: (BuildContext context, index) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: OColors.darGrey,
                                        margin: const EdgeInsets.only(
                                            top: 1, left: 10, right: 10),
                                        child: Card(
                                          color: OColors.darGrey,
                                          child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  if (categoryType == 'McCEO') {
                                                    mcAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    mcId =
                                                        _foundUsers[index].id!;
                                                    mcUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'ProductionCEO') {
                                                    productionAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    productionId =
                                                        _foundUsers[index].id!;
                                                    productionUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'decoratorCEO') {
                                                    decoratorAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    decoratorId =
                                                        _foundUsers[index].id!;
                                                    decoratorUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'hallCEO') {
                                                    hallAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    hallId =
                                                        _foundUsers[index].id!;
                                                    hallUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'cakeCEO') {
                                                    cakeAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    cakeId =
                                                        _foundUsers[index].id!;
                                                    cakeUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'singersCEO') {
                                                    singersAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    singersId =
                                                        _foundUsers[index].id!;
                                                    singersUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'dancersCEO') {
                                                    dancersAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    dancersId =
                                                        _foundUsers[index].id!;
                                                    dancersUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'cookerCEO') {
                                                    cookerAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    cookerId =
                                                        _foundUsers[index].id!;
                                                    cookerUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'saloonCEO') {
                                                    saloonAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    saloonId =
                                                        _foundUsers[index].id!;
                                                    saloonUsername =
                                                        _foundUsers[index]
                                                            .username!;
                                                  }

                                                  if (categoryType ==
                                                      'carsCEO') {
                                                    carsAvater =
                                                        _foundUsers[index]
                                                            .avater!;
                                                    carsId =
                                                        _foundUsers[index].id!;
                                                    carsUsername =
                                                        _foundUsers[index]
                                                            .username!;
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
                                                          '${api}public/uploads/${_foundUsers[index].username}/profile/${_foundUsers[index].avater}',
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
                                                  _foundUsers[index].username!,
                                                  style: TextStyle(
                                                      color:
                                                          OColors.fontColor)),
                                              subtitle: _foundUsers[index]
                                                          .gender ==
                                                      'f'
                                                  ? Text('Female',
                                                      style: TextStyle(
                                                          color: OColors
                                                              .fontColor))
                                                  : Text('Male',
                                                      style: TextStyle(
                                                          color: OColors
                                                              .fontColor)),
                                              trailing:
                                                  const Icon(Icons.select_all)),
                                        ),
                                      ),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                );
                              })
                          : Text(
                              'No results found',
                              style: TextStyle(
                                  fontSize: 24, color: OColors.fontColor),
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
            color: OColors.darGrey,
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
                  child: Text('Brand Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'Known',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
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

        // Price
        Card(
            color: OColors.darGrey,
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
                  child: Text('Price',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.money,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'My Price',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    keyboardType: TextInputType.number,
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

        // Contact
        Card(
            color: OColors.darGrey,
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
                  child: Text('Contact',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'Phone No',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
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

        // Location
        Card(
            color: OColors.darGrey,
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
                  child: Text('Location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.location_city,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'Regional / Location',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
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
        // About Group
        Card(
            color: OColors.darGrey,
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
                  child: Text('About Group/Organization',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.group,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'About Group/Organization',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
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
                color: OColors.darGrey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: OColors.fontColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: OColors.primary,
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      '${api + 'public/uploads/' + name}/profile/' +
                                          avater,
                                    )),
                            )),
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: name == ''
                                    ? Text(
                                        ' User Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: OColors.fontColor),
                                      )
                                    : Text(
                                        name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: OColors.fontColor),
                                      )),
                            GestureDetector(
                              onTap: () {
                                oneButtonPressed(category);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: OColors.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 4.0, left: 8, right: 8, top: 4),
                                  child: Text(
                                    'Select CEO User ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: OColors.fontColor,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
            color: OColors.darGrey,
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
                  child: Text('About C.E.O',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.group,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'Bio',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
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
            color: OColors.darGrey,
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
                  child: Text('Contact',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OColors.fontColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.price_change_rounded,
                          size: 28,
                          color: OColors.primary,
                        ),
                      ),
                      hintText: 'Phone No',
                      hintStyle:
                          const TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                        fontSize: 15, color: Colors.grey, height: 1.5),
                    onChanged: (value) {
                      setState(() {
                        //_email = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10)
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
      margin: const EdgeInsets.only(left: 10, right: 20, top: 8, bottom: 8),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: OColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: const Text(
        'Submit',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}



  // Column(
  //                 children: [
  //                   if (selectedBusness == _busness[0]) mcWorkCategory,
  //                   if (selectedBusness == _busness[1]) prodWorkCategory,
  //                   if (selectedBusness == _busness[2]) decWorkCategory,
  //                   if (selectedBusness == _busness[3]) hallWorkCategory,
  //                   if (selectedBusness == _busness[4]) cakeWorkCategory,
  //                   if (selectedBusness == _busness[5]) singWorkCategory,
  //                   if (selectedBusness == _busness[6]) dancWorkCategory,
  //                   if (selectedBusness == _busness[7]) cokWorkCategory,
  //                   if (selectedBusness == _busness[8]) salWorkCategory,
  //                   if (selectedBusness == _busness[9]) carWorkCategory
  //                 ],
  //               ),
  //               Column(
  //                 children: [
  //                   if (selectedBusness == _busness[0]) mcStaffCategory,
  //                   if (selectedBusness == _busness[1]) prodStaffCategory,
  //                   if (selectedBusness == _busness[2]) decStaffCategory,
  //                   if (selectedBusness == _busness[3]) hallStaffCategory,
  //                   if (selectedBusness == _busness[4]) cakeStaffCategory,
  //                   if (selectedBusness == _busness[5]) singStaffCategory,
  //                   if (selectedBusness == _busness[6]) dancStaffCategory,
  //                   if (selectedBusness == _busness[7]) cokStaffCategory,
  //                   if (selectedBusness == _busness[8]) salStaffCategory,
  //                   if (selectedBusness == _busness[9]) carStaffCategory,
  //                 ],
  //               ),
             