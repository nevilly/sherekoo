// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sherekoo/widgets/imgWigdets/defaultAvater.dart';
import '../../model/user/user-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/ceremony/postCrm-call.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/appWords.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../crmScreen/crmScreen.dart';

class CeremonyUpload extends StatefulWidget {
  final CeremonyModel getData;
  final User getcurrentUser;
  const CeremonyUpload(
      {Key? key, required this.getData, required this.getcurrentUser})
      : super(key: key);

  @override
  _CeremonyUploadState createState() => _CeremonyUploadState();
}

class _CeremonyUploadState extends State<CeremonyUpload> {
  List<CeremonyModel> data = [];
  List<User> dataUsers = [];
  User? currentUser;

  // Image upload
  final _picker = ImagePicker();

  String selectedChereko = 'Select Ceremony';
  DateTime? _selectedDate;

  // wedding Data
  late String wedAvater = "";
  late String wedId = "";
  late String wedLastname = "";
  late String wedUsername = "";
  File? _wimage; // background image for wedding
  String wDflt_img = 'assets/ceremony/wpr.png';

  final TextEditingController _weddingDateController = TextEditingController();
  final TextEditingController _weddingNameController = TextEditingController();

  // Birday Data
  late String bAvater = "";
  late String bId = "";
  late String bFirstName = "";
  late String bUsername = "";
  File? _bimage; // background Image for Birthday
  String bDflt_img = 'assets/ceremony/bday.png';

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdayDateController = TextEditingController();

  // SendOff Data
  late String sAvater = "";
  late String sId = "";
  late String sLastName = "";
  late String sUsername = "";

  String sDflt_img = 'assets/ceremony/wpr.png';
  File? _simage; //background image for send off

  final TextEditingController _sendOffNameController = TextEditingController();
  final TextEditingController _sendOffDateController = TextEditingController();

  // kitchenPart Data
  late String kAvater = "";
  late String kId = "";
  late String kFirstName = "";
  late String kUsername = "";

  File? _kimage; // background image
  String kDflt_img = 'assets/ceremony/wpr.png';

  final TextEditingController _kichenpartNameController =
      TextEditingController();
  final TextEditingController _kitchenPartDateController =
      TextEditingController();

  // kigodoro
  late String gAvater = "";
  late String gId = "";
  late String gFirstName = "";
  late String gUsername = "";

  File? _gimage; //background image
  String gDflt_img = 'assets/ceremony/kgd.png';

  final TextEditingController _kgodoroNameController = TextEditingController();
  final TextEditingController _kigodoroDateController = TextEditingController();

  File? _generalimage;
  // Image Picking
  _openImagePicker(ImageSource source, arg) async {
    final pick = _picker.pickImage(source: source, imageQuality: 25);
    XFile? pickedImage = await pick;
    if (pickedImage == null) return;

    File img = File(pickedImage.path);
    img = await cropImage(img);

    setState(() {
      _generalimage = img;
      if (arg == 'Birthday') _bimage = img;
      if (arg == 'Wedding') _wimage = img;
      if (arg == 'SendOff') _simage = img;
      if (arg == 'kitchenPart') _kimage = img;
      if (arg == 'Kigodoro') _gimage = img;
    });
  }

  final List<String> _sherehe = [
    'Birthday',
    'Wedding',
    'SendOff',
    'Kitchen Part',
    'Kigodoro'
  ];

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;

        getUser();
        getAll();

        if (widget.getcurrentUser.id!.isNotEmpty) {
          currentUser = widget.getcurrentUser;
        }

        if (widget.getData.cId.isNotEmpty) {
          selectedChereko = widget.getData.ceremonyType;

          // Birthday
          if (widget.getData.ceremonyType == 'Birthday') {
            selectedChereko = widget.getData.ceremonyType;

            bAvater = widget.getData.userFid.avater!;
            bId = widget.getData.fId;
            bFirstName = widget.getData.userFid.firstname!;
            bUsername = widget.getData.userFid.username!;

            bDflt_img = widget.getData.cImage;

            _ageController.text = widget.getData.cName;
            _birthdayDateController.text = widget.getData.ceremonyDate;
          }

          // Wedding
          if (widget.getData.ceremonyType == 'Wedding') {
            wedAvater = widget.getData.userSid.avater!;
            wedId = widget.getData.sId;
            wedLastname = widget.getData.userSid.lastname!;
            wedUsername = widget.getData.userSid.username!;
            // File? _wimage; // background image for wedding
            wDflt_img = widget.getData.cImage;

            _weddingNameController.text = widget.getData.cName;
            _weddingDateController.text = widget.getData.ceremonyDate;
          }

          //SendOff
          if (widget.getData.ceremonyType == 'SendOff') {
            sAvater = widget.getData.userSid.avater!;
            sId = widget.getData.sId;
            sLastName = widget.getData.userSid.lastname!;
            sUsername = widget.getData.userSid.username!;

            sDflt_img = widget.getData.cImage;

            _sendOffNameController.text = widget.getData.cName;
            _sendOffDateController.text = widget.getData.ceremonyDate;
          }

          //kitchenPart data
          if (widget.getData.ceremonyType == 'Kitchen Part') {
            kAvater = widget.getData.userSid.avater!;
            kId = widget.getData.sId;
            kFirstName = widget.getData.userSid.lastname!;
            kUsername = widget.getData.userSid.username!;

            kDflt_img = widget.getData.cImage;

            _kichenpartNameController.text = widget.getData.cName;
            _kitchenPartDateController.text = widget.getData.ceremonyDate;
          }

          //Kigodoro
          if (widget.getData.ceremonyType == 'Kigodoro') {
            gAvater = widget.getData.userSid.avater!;
            gId = widget.getData.sId;
            gFirstName = widget.getData.userSid.lastname!;
            gUsername = widget.getData.userSid.username!;

            gDflt_img = widget.getData.cImage;

            _kgodoroNameController.text = widget.getData.cName;
            _kigodoroDateController.text = widget.getData.ceremonyDate;
          }
        }
      });
    });

    super.initState();
  }

  getAll() async {
    UsersCall(payload: [], status: 0).get(token, urlUserList).then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          dataUsers = value.payload.map<User>((e) => User.fromJson(e)).toList();
        });
      }
    });
  }

  // for_Search Result

  getUser() async {
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  dynamic image;

  //Function: For_save Details
  _saveCeremony(backgroundImg, String defaultImg, sId, codeName, name, dati,
      String slcted, String msg1, String msg2, String msg3) async {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var rand =
        List.generate(4, (index) => chars[r.nextInt(chars.length)]).join();

    String codeNo = codeName + rand;

    if (sId.isNotEmpty) {
      if (name.text.isNotEmpty) {
        if (dati.text.isNotEmpty) {
          if (widget.getData.cId.isNotEmpty) {
            if (backgroundImg != null) {
              List<int> bytes = backgroundImg.readAsBytesSync();
              image = base64Encode(bytes);
            }

            PostAllCeremony(
              cId: widget.getData.cId,
              userId: '',
              sId: sId,
              name: name.text,
              date: dati.text,
              cType: slcted,
              image:
                  image ?? '', // for nw enter default img only instd 'image';
              codeNo: widget.getData.codeNo,
              status: 0,
              payload: [],
              goLiveId: 'GoLive',
            )
                .update(token, urlUpdateDayCeremony, widget.getData.cImage)
                .then((value) {
              if (value.status == 200) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.payload),
                ));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CeremonyScreen()));
              } else {
                fillTheBlanks(context, sysErr, altSty, odng);
              }
            });
          } else {
            if (backgroundImg != null) {
              List<int> bytes = backgroundImg.readAsBytesSync();
              String image = base64Encode(bytes);

              PostAllCeremony(
                userId: '',
                sId: sId,
                name: name.text,
                date: dati.text,
                cType: slcted,
                image: image, // for nw enter default img only instd 'image';
                codeNo: codeNo,
                status: 0,
                payload: [],
                goLiveId: 'GoLive', cId: '',
              ).get(token, urlPostCeremony).then((value) {
                if (value.status == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value.payload),
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CeremonyScreen()));
                } else {
                  fillTheBlanks(context, sysErr, altSty, odng);
                }
              });
            } else {
              fillTheBlanks(context, imgInsertAlt, altSty, odng);
            }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: topBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text('Select Type Of Ceremony', style: header14),
          ),

          const SizedBox(
            height: 5,
          ),

          //Select Categories
          categorySelect,

          const SizedBox(
            height: 5,
          ),

          //Selected Field
          if (selectedChereko == 'Select Ceremony') pls,
          if (selectedChereko == _sherehe[0]) birthday,
          if (selectedChereko == _sherehe[1]) wedding,
          if (selectedChereko == _sherehe[2]) sendOff,
          if (selectedChereko == _sherehe[3]) kitchenPart,
          if (selectedChereko == _sherehe[4]) kigodoro,
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  AppBar topBar() {
    return AppBar(
      toolbarHeight: 45,
      elevation: 0,
      backgroundColor: OColors.secondary,
      title: widget.getData.cId.isNotEmpty
          ? const Text('Edit ')
          : const Text('Ceremony account'),
      centerTitle: true,
      actions: [
        if (selectedChereko != 'Select Ceremony')
          GestureDetector(
              onTap: () {
                if (selectedChereko == _sherehe[0]) {
                  _saveCeremony(
                      _generalimage,
                      bDflt_img,
                      bId,
                      bFirstName,
                      _ageController,
                      _birthdayDateController,
                      selectedChereko,
                      selectBirthday,
                      enterAge,
                      insertBirthday);
                }

                if (selectedChereko == _sherehe[1]) {
                  _saveCeremony(
                      _generalimage,
                      wDflt_img,
                      wedId,
                      currentUser!.lastname,
                      _weddingNameController,
                      _weddingDateController,
                      selectedChereko,
                      'Select your Wife pls...',
                      'Enter Family Name pls ...',
                      'Enter Wedding Date pls ...');
                }

                if (selectedChereko == _sherehe[2]) {
                  _saveCeremony(
                      _generalimage,
                      sDflt_img,
                      sId,
                      currentUser!.lastname,
                      _sendOffNameController,
                      _sendOffDateController,
                      selectedChereko,
                      'Select  your future husband...',
                      'Enter Last name pls ...',
                      'Enter sendOff Date pls ...');
                }

                if (selectedChereko == _sherehe[3]) {
                  _saveCeremony(
                      _generalimage,
                      kDflt_img,
                      kId,
                      currentUser!.lastname,
                      _kichenpartNameController,
                      _kitchenPartDateController,
                      selectedChereko,
                      'Select  your Future husband...',
                      'Enter your Last name pls ...',
                      'Enter Kitchen Part date pls ...');
                }

                if (selectedChereko == _sherehe[4]) {
                  _saveCeremony(
                      _generalimage,
                      gDflt_img,
                      gId,
                      gFirstName,
                      _kgodoroNameController,
                      _kigodoroDateController,
                      selectedChereko,
                      'Select Kigodoro Admin...',
                      'Enter kigodoro Title pls ...',
                      'Enter Kigodoro date pls ...');
                }
              },
              child: ceremonySave())
      ],
    );
  }

  Widget get categorySelect => Container(
        height: 40,
        margin: selectedChereko != 'Select Ceremony'
            ? const EdgeInsets.only(left: 20, right: 20)
            : const EdgeInsets.only(left: 20, right: 20, top: 100),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: OColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: DropdownButton<String>(
            dropdownColor: OColors.darGrey,
            isExpanded: true,
            // icon: const Icon(Icons.arrow_circle_down),
            // iconSize: 20,
            // elevation: 16,
            underline: Container(),
            items: _sherehe.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child:
                      Text(value, style: TextStyle(color: OColors.fontColor)));
            }).toList(),

            hint: Container(
              alignment: Alignment.center,
              child: Text(
                selectedChereko,
                style: TextStyle(
                    fontSize: 13,
                    color: OColors.fontColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedChereko = value!;
              });
            },
          ),
        ),
      );

  Widget get pls =>
      Container(alignment: Alignment.center, child: const SizedBox());

  Widget get birthday => Expanded(
        child: SizedBox(
          height: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile
                ceremonyProfile('birthday', bAvater, bFirstName, bUsername),

                // Birthday Age
                ceremonyName('Age', _ageController, 'My age'),

                const SizedBox(
                  height: 10,
                ),

                //Birday Date
                ceremonyDate('Birthday Date', _birthdayDateController),
                const SizedBox(
                  height: 10,
                ),

                //Background Image Upload
                backgroundProfile(_bimage, 'birthday', bDflt_img),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get wedding => Expanded(
        child: SizedBox(
          height: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile
                ceremonyProfile('wedding', wedAvater, wedLastname, wedUsername),

                // Ceremony Namee
                ceremonyName('Family Name', _weddingNameController, 'Mr&Mrs'),

                const SizedBox(
                  height: 10,
                ),

                // Ceremony Date
                ceremonyDate('Wedding Date', _weddingDateController),
                const SizedBox(
                  height: 10,
                ),

                //Background Image Upload
                backgroundProfile(_wimage, 'wedding', wDflt_img),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get sendOff => Expanded(
        child: SizedBox(
          height: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile

                ceremonyProfile('sendOff', sAvater, sLastName, sUsername),

                // Family Namee
                ceremonyName('Family Name', _sendOffNameController, 'Mr&Mrs'),

                const SizedBox(
                  height: 10,
                ),

                // Send Off Date
                ceremonyDate('SendOff Date', _sendOffDateController),

                const SizedBox(
                  height: 10,
                ),

                //Background Image Upload
                backgroundProfile(_simage, 'sendOff', sDflt_img),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get kitchenPart => Expanded(
        child: SizedBox(
          height: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile
                ceremonyProfile('kitchernPart', kAvater, kFirstName, kUsername),

                // Family Namee
                ceremonyName(
                    'Family Name', _kichenpartNameController, 'Mr&Mrs'),

                const SizedBox(
                  height: 10,
                ),

                // Ceremony Date
                ceremonyDate('Kitchen Part Date', _kitchenPartDateController),

                const SizedBox(
                  height: 10,
                ),

                //Background Image Upload
                backgroundProfile(_kimage, 'kitchenPart', kDflt_img),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get kigodoro => Expanded(
        child: SizedBox(
          height: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile
                ceremonyProfile('kigodoro', gAvater, gFirstName, gUsername),

                // Kigodoro Namee
                ceremonyName(
                    'Kigodoro', _kgodoroNameController, 'Kigodoro Title'),

                const SizedBox(
                  height: 10,
                ),

                // kigodoro Date
                ceremonyDate('Kigodoro Date', _kigodoroDateController),
                const SizedBox(
                  height: 10,
                ),

                //Background Image Upload
                backgroundProfile(_gimage, 'kigodoro', gDflt_img),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );

  ceremonyProfile(String arg, profileImg, cName, C_Username) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (arg == 'birthday') bdayProfile(profileImg, C_Username, cName, arg),
        if (arg == 'kigodoro') bdayProfile(profileImg, C_Username, cName, arg),
        if (arg == 'wedding') wddProfile(profileImg, C_Username, cName),
        if (arg == 'sendOff')
          sendOkitchnProfile(profileImg, C_Username, cName, arg),
        if (arg == 'kitchernPart')
          sendOkitchnProfile(profileImg, C_Username, cName, arg),
      ],
    );
  }

  ceremonyName(arg1, arg2, arg3) {
    return Card(
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
              child: Text(arg3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: OColors.fontColor),
                  textAlign: TextAlign.start),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: arg2,
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
                  hintText: arg1,
                  hintStyle: const TextStyle(color: Colors.grey, height: 1.5),
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
        ));
  }

  ceremonyDate(title, dateController) {
    return Card(
        color: OColors.darGrey,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              padding: const EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: OColors.fontColor),
                  textAlign: TextAlign.start),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.calendar_month,
                      size: 28,
                      color: OColors.primary,
                    ),
                  ),
                  hintText: 'Date ( DD/MM/YYY )',
                  hintStyle: const TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onTap: () {
                  _selectDate(context, dateController);
                },
              ),
            ),
          ],
        ));
  }

  backgroundProfile(imgType, slctdChereko, img) {
    return Card(
      color: OColors.darGrey,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            padding: const EdgeInsets.only(bottom: 8.0),
            alignment: Alignment.topLeft,
            child: Text('Upload Cover Photo',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: OColors.fontColor),
                textAlign: TextAlign.start),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  // width: double.infinity,

                  color: OColors.darGrey,
                  child: _generalimage != null
                      ? Image.file(
                          _generalimage!,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : widget.getData.cId.isNotEmpty
                          ? Image.network(
                              '${api}public/uploads/${widget.getData.userFid.username}/ceremony/${widget.getData.cImage}',
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : Image(image: AssetImage(img)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                ),
                child: Column(
                  children: [
                    // Gallary
                    GestureDetector(
                      onTap: () {
                        _openImagePicker(ImageSource.gallery, slctdChereko);
                      },
                      child: Row(
                        children: [
                          Card(
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
                          const Card(
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
                        _openImagePicker(ImageSource.camera, slctdChereko);
                      },
                      child: Row(
                        children: [
                          Card(
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
                          const Card(
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
        ],
      ),
    );
  }

  ceremonySave() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 20, top: 8, bottom: 8),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: OColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: widget.getData.cId.isNotEmpty
          ? const Text(
              'Update',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          : const Text('Save',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
    );
  }

  Row sendOkitchnProfile(profileImg, C_Username, cName, String arg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Male Side
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 142,
            child: Card(
              color: OColors.darGrey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Male',
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  //Profile
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: profileImg == ''
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/ceremony/male.png'),
                          )
                        : CircleAvatar(
                            radius: 30,
                            child: UserAvater(
                                avater: profileImg,
                                height: 45,
                                url: '/profile/',
                                username: C_Username,
                                width: 45),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cName == ''
                        ? Text(
                            'Your Husband..',
                            style: TextStyle(
                                color: OColors.fontColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          )
                        : Text(
                            cName,
                            style: TextStyle(
                                color: OColors.fontColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed(arg);
                      SearchMembers(context, arg);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 4.0, left: 8, right: 8, top: 4),
                        child: Text(
                          'Select User ',
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
            ),
          ),
        ),

        //Femaile Side
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 142,
            child: Card(
              color: OColors.darGrey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Female',
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: currentUser!.avater!.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${api}public/uploads/${currentUser!.username}/profile/${currentUser!.avater}'
                                // height: 45,
                                // fit: BoxFit.cover,
                                ))
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/ceremony/female.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentUser!.firstname!,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: OColors.fontColor,
                          fontSize: 13),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade200,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          bottom: 4.0, left: 8, right: 8, top: 4),
                      child: Text(
                        'Selected User ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Row wddProfile(profileImg, C_Username, cName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Male Profile
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 143,
            child: Card(
              color: OColors.darGrey,
              child: Column(
                children: [
                  // title Male
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Male',
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),

                  //avater Male Display
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: currentUser!.avater != ""
                          ? UserAvater(
                              avater: currentUser!.avater!,
                              height: 45,
                              url: '/profile/',
                              username: currentUser!.username!,
                              width: 45)

                          // CircleAvatar(
                          //     backgroundImage: NetworkImage(api +
                          //             'public/uploads/' +
                          //             currentUser!.username +
                          //             '/profile/' +
                          //             currentUser!.avater
                          //         // height: 45,
                          //         // fit: BoxFit.cover,
                          //         ))
                          : const DefaultAvater(
                              height: 45, radius: 15, width: 45)),

                  //last Name Display
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentUser!.lastname!,
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),

                  // Slect user Buttons
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade200,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          bottom: 4.0, left: 8, right: 8, top: 4),
                      child: Text(
                        'Selected User ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //Female Profile
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 143,
            child: Card(
              color: OColors.darGrey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Female',
                      style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: profileImg == ''
                          ? const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/ceremony/female.png'),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                              '${api}public/uploads/$C_Username/profile/$profileImg',
                              // height: 45,
                              // fit: BoxFit.cover,
                            ))),

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cName == ''
                          ? Text(
                              'Wife Name..',
                              style: TextStyle(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            )
                          : Text(
                              cName,
                              style: TextStyle(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            )),

                  //Savee data
                  GestureDetector(
                    onTap: () {
                      // oneButtonPressed('wedding');
                      SearchMembers(context, 'wedding');
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
                          'Select Wife ',
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
            ),
          ),
        )
      ],
    );
  }

  Padding bdayProfile(profileImg, C_Username, cName, String arg) {
    return Padding(
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
                      color: OColors.fontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: profileImg == ''
                          ? const CircleAvatar(
                              child: DefaultAvater(
                                  height: 45, radius: 15, width: 45),
                            )
                          : accountForBdayKgodoro(context, profileImg,
                              C_Username, '/profile/', 45, 45, 30),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: cName == ""
                              ? Text(
                                  ' Sherekoo Admin',
                                  style: TextStyle(
                                      color: OColors.fontColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                )
                              : Text(cName,
                                  style: TextStyle(
                                      color: OColors.fontColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13)),
                        ),
                        GestureDetector(
                          onTap: () {
                            SearchMembers(context, arg);
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
                                'Select Other User ',
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
          )),
    );
  }

// Alert Widget
  SearchMembers(BuildContext context, ceremonyType) async {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 5),
      backgroundColor: OColors.secondary,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              size: 35,
              color: OColors.fontColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0, top: 8, bottom: 8),
          child: Text('Search',
              style:
                  header18.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ]),
      content: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Autocomplete<User>(
                optionsBuilder: (TextEditingValue value) {
                  // When the field is empty
                  if (value.text.isEmpty) {
                    return [];
                  }

                  // The logic to find out which ones should appear
                  return dataUsers
                      .where((d) => d.username!
                          .toLowerCase()
                          .contains(value.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (User option) => option.username!,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 18),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: OColors.primary, fontSize: 14, height: 1.5),
                      hintText: "Search User..",
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: OColors.fontColor),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<User> onSelected,
                    Iterable<User> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: Container(
                        width: 300,
                        color: OColors.secondary,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final User option = options.elementAt(index);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (ceremonyType == 'birthday') {
                                    bAvater = option.avater!;
                                    bId = option.id!;
                                    bFirstName = option.firstname!;

                                    bUsername = option.username!;
                                  }

                                  if (ceremonyType == 'wedding') {
                                    wedAvater = option.avater!;
                                    wedId = option.id!;
                                    wedLastname = option.lastname!;
                                    wedUsername = option.username!;
                                  }

                                  if (ceremonyType == 'sendOff') {
                                    sAvater = option.avater!;
                                    sId = option.id!;
                                    sLastName = option.lastname!;
                                    sUsername = option.username!;
                                  }

                                  if (ceremonyType == 'kitchernPart') {
                                    kAvater = option.avater!;
                                    kId = option.id!;
                                    kFirstName = option.lastname!;
                                    kUsername = option.username!;
                                  }

                                  if (ceremonyType == 'kigodoro') {
                                    gAvater = option.avater!;
                                    gId = option.id!;
                                    gFirstName = option.lastname!;
                                    gUsername = option.username!;
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: option.avater != ''
                                              ? Image.network(
                                                  '${api}public/uploads/${option.username}/profile/${option.avater}',
                                                  fit: BoxFit.cover,
                                                  height: 40,
                                                )
                                              : const CircleAvatar(
                                                  child: DefaultAvater(
                                                      height: 45,
                                                      radius: 15,
                                                      width: 45),
                                                ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(option.username!,
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            // Text(option.busnessType,
                                            //     style: const TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 12,
                                            //         fontStyle: FontStyle.italic))
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      height: 1.0,
                                      color: Colors.black.withOpacity(0.24),
                                      thickness: 1.0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                // onSelected: (User selection) {
                //   print('am hre ');
                //   setState(() {
                //     if (ceremonyType == 'birthday') {
                //       bAvater = selection.avater!;
                //       bId = selection.id!;
                //       bFirstName = selection.firstname!;

                //       bUsername = selection.username!;
                //     }

                //     if (ceremonyType == 'wedding') {
                //       wedAvater = selection.avater!;
                //       wedId = selection.id!;
                //       wedLastname = selection.lastname!;
                //       wedUsername = selection.username!;
                //     }

                //     if (ceremonyType == 'sendOff') {
                //       sAvater = selection.avater!;
                //       sId = selection.id!;
                //       sLastName = selection.lastname!;
                //       sUsername = selection.username!;
                //     }

                //     if (ceremonyType == 'kitchernPart') {
                //       kAvater = selection.avater!;
                //       kId = selection.id!;
                //       kFirstName = selection.lastname!;
                //       kUsername = selection.username!;
                //     }

                //     if (ceremonyType == 'kigodoro') {
                //       gAvater = selection.avater!;
                //       gId = selection.id!;
                //       gFirstName = selection.lastname!;
                //       gUsername = selection.username!;
                //     }
                //   });
                //   Navigator.of(context).pop();
                // },
              ))
        ],
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
