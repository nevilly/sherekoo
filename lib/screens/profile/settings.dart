// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/authentication/creatAccount.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../homNav.dart';

class ProfileSetting extends StatefulWidget {
  final User user;
  const ProfileSetting({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final Preferences _preferences = Preferences();
  String token = '';
  List gender = ["Single", "merriage", "engaged"];

  TextEditingController username = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  String selectedRegion = 'Select Your Location';
  final List<String> _region = [
    'Dar-Es-Salaam',
    'Mbeya',
    'Arusha',
    'Moshi',
    'Morogoro',
    'Dodoma',
    'Tanga',
    'Geita',
    'Iringa',
    'kagera',
    'Katavi',
    'Kigoma',
    'Lindi',
    'Manyara',
    'Mara',
    'Zanzibar',
    'Mtwara',
    'Mwanza',
    'Njombe',
    'Pemba',
    'Rukwa',
    'Ruvuma',
    'Shinyanga',
    'Simiyu',
    'Singida',
    'Songwe',
    'Tabora',
    'Unguja',
  ];

  String select = "";
  File? _generalimage;
  // Image upload
  final _picker = ImagePicker();
  final _pickerG = ImagePicker();

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

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value!;
            });
          },
        ),
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12))
      ],
    );
  }

  dynamic image;
  void creatAccount(u, fn, ln, e, m, p, img, rgn, slt) async {
   
    if (img != null) {
      List<int> bytes = img.readAsBytesSync();
      image = base64Encode(bytes);
    }

    final CreateAccountModel r = await CreateAccountModel(
            password: '',
            status: 0,
            token: '',
            avater: image ?? '',
            username: u,
            phone: p,
            gender: '',
            address: rgn,
            bio: '',
            email: e,
            firstname: fn,
            role: 'n',
            lastname: ln,
            meritalStatus: slt)
        .updateAccountSetting(token, urlUpdateUserSetting, widget.user.avater);

    if (r.status == 200) {
      setState(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeNav(
                      user: widget.user,
                      getIndex: 4,
                    )),
            ModalRoute.withName('/'));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('System Error, Try Again'),
      ));
    }
  }

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        username.text = widget.user.username;
        firstName.text = widget.user.firstname;
        lastName.text = widget.user.lastname;
        selectedRegion = widget.user.address;
        email.text = widget.user.email;
        phoneNo.text = widget.user.phoneNo;
        select = widget.user.meritalStatus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OColors.appBarColor,
        title: const Text('Profile Settings'),
        centerTitle: true,
        actions: [
          //Post Button
          GestureDetector(
            onTap: () {
              creatAccount(
                  username.text,
                  firstName.text,
                  lastName.text,
                  email.text,
                  select,
                  phoneNo.text,
                  _generalimage,
                  selectedRegion,
                  select);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 104, 12),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Text(
                'Update',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // Title Add title

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Profile Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0, left: 8),
                          child: Text(
                            'Upload Profile',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),

                        // Avatar upload...
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 90,
                            height: 90,
                            // color: Colors.grey[300],
                            child: _generalimage != null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: CircleAvatar(
                                      radius: 85,
                                      child: ClipOval(
                                        child: Image.file(
                                          _generalimage!,
                                          fit: BoxFit.cover,
                                          width: 80.0,
                                          height: 80.0,
                                          // width: 100,
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 110,
                                    child: ClipOval(
                                      child: UserAvater(
                                        avater: widget.user.avater,
                                        url: '/profile/',
                                        username: widget.user.username,
                                        width: 80.0,
                                        height: 80.0,
                                      ),
                                    ),
                                  ),

                           
                          ),
                        ),
                      ],
                    ),

                    //Buttons Image Upload
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
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
                                      size: 14,
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
                                          fontSize: 12,
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
                                      size: 14,
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.black45,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontSize: 12,
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

                const SizedBox(
                  height: 5,
                ),

                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0))),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 3.0),
                      decoration: const BoxDecoration(
                        // color: Colors.lightBlue,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10.0)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 9.0),
                            Card(
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Text(
                                            'Edit Your information',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ]),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // username
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: username,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'First Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // First Name
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: firstName,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'First Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // Last Name
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: lastName,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person_add,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Last Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // Email
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: email,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.email,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // phone
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: phoneNo,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Last Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // Region Selection
                                  Card(
                                    child: Column(
                                      children: [
                                        // header
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    top: 5.0,
                                                    bottom: 5.0),
                                                child: Text(
                                                  'Select Your region',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ]),

                                        // Region Select
                                        Container(
                                          height: 45,
                                          margin: selectedRegion !=
                                                  'Select Your Location'
                                              ? const EdgeInsets.only(
                                                  left: 20, right: 20)
                                              : const EdgeInsets.only(
                                                  left: 20, right: 20, top: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 10),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              // icon: const Icon(Icons.arrow_circle_down),
                                              // iconSize: 20,
                                              // elevation: 16,
                                              underline: Container(),
                                              items:
                                                  _region.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              hint: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  selectedRegion,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              onChanged: (v) {
                                                setState(() {
                                                  // print(v);
                                                  selectedRegion = v!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Radio Button
                                  Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        addRadioButton(0, 'Single'),
                                        addRadioButton(1, 'merriage'),
                                        addRadioButton(2, 'engaged'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 9.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Privacy available in settings',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
