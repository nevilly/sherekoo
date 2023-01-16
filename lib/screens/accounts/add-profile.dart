// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/screens/profile/profile.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';

import '../../model/authentication/creatAccount.dart';
import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final Preferences _preferences = Preferences();
  String token = '';
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

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

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

  List gender = ["Single", "merriage", "engaged"];
  String select = "";

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: prmry,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value!;
            });
          },
        ),
        Text(title, style: header10.copyWith(color: Colors.grey, fontSize: 12))
      ],
    );
  }

  File? _generalimage;
  // Image upload
  final _picker = ImagePicker();

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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
      });
    });

    super.initState();
  }

  getUser() async {
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  emptyField(String title) {
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

  dynamic image;
  void creatAccount(fn, ln, img, rgn, slt) async {
    if (fn.isNotEmpty) {
      if (ln.isNotEmpty) {
        if (slt.isNotEmpty) {
          if (rgn != "Select Your Location") {
            if (img != null) {
              List<int> bytes = img.readAsBytesSync();
              image = base64Encode(bytes);
            }

            final CreateAccountModel r = await CreateAccountModel(
                    password: '',
                    status: 0,
                    token: '',
                    avater: image ?? '',
                    username: '',
                    phone: '',
                    gender: '',
                    address: rgn,
                    bio: '',
                    email: '',
                    firstname: fn,
                    role: 'n',
                    lastname: ln,
                    meritalStatus: slt)
                .updateAccount(token, urlUpdateUserInfo);

            if (r.status == 200) {
              setState(() {
                emptyField(r.token!);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeNav(
                              getIndex: 2,
                              user: emptyUser,
                            )),
                    ModalRoute.withName('/'));
              });
            } else {
              emptyField('System Error, Try Again');
            }
          } else {
            emptyField("Select your Location Please...");
          }
        } else {
          emptyField("Select Your Marital Status Please...");
        }
      } else {
        emptyField("Enter your Last Name Please...");
      }
    } else {
      emptyField("Enter your First Name Please...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        automaticallyImplyLeading: false,
        title: const Text('Add Info'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              creatAccount(firstName.text, lastName.text, _generalimage,
                  selectedRegion, select);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 12.0, right: 8.0, bottom: 10),
              decoration: BoxDecoration(
                  color: prmry, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Save',
                      style: header14.copyWith(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),

      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: osec,

      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Spacer(),

                // Title Add title
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 8, bottom: 8),
                  child: Text('Add Profile',
                      style: header16.copyWith(fontWeight: FontWeight.bold)),
                ),

                // Avatar upload...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // width: double.infinity,
                      height: 90,
                      // color: Colors.grey[300],
                      child: _generalimage != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                backgroundColor: prmry,
                                radius: 60,
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
                              backgroundColor: prmry,
                              radius: 60,
                              child: const ClipOval(
                                child: Image(
                                  image:
                                      AssetImage('assets/profile/profile.jpg'),
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                    ),

                    //Buttons Image Upload
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _openImagePicker(ImageSource.camera);
                            },
                            child: Row(
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
                                  color: Colors.black45,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
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

                          // Gallary
                          GestureDetector(
                            onTap: () {
                              // _openImagePickerG('slctdChereko');
                              _openImagePicker(ImageSource.gallery);
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
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
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
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Text(
                                            'Add Your information',
                                            style: header15.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ]),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // First Name
                                  Container(
                                    height: 45,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: firstName,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person,
                                            size: 28,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'First Name',
                                        hintStyle: header14.copyWith(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: header14.copyWith(
                                          color: Colors.grey, height: 1.5),
                                      onChanged: (value) {
                                        setState(() {
                                          //_email = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // Last Name
                                  Container(
                                    height: 45,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: lastName,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person_add,
                                            size: 28,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Last Name',
                                        hintStyle: header14.copyWith(
                                            color: Colors.grey, height: 1.5),
                                      ),
                                      style: header14.copyWith(
                                          color: Colors.grey, height: 1.5),
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
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    top: 5.0,
                                                    bottom: 5.0),
                                                child: Text(
                                                  'Select Your region',
                                                  style: header14.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                      height: 1.5),
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
                                                  style: header14.copyWith(
                                                      color: Colors.grey,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        child: Text(
                                          'Select Your gender',
                                          style: header14.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              height: 1.5),
                                        ),
                                      ),
                                      const SizedBox()
                                    ],
                                  ),

                                  // Radio Button
                                  Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: SizedBox(
                                      height: 50,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          addRadioButton(0, 'Single'),
                                          addRadioButton(1, 'merriage'),
                                          addRadioButton(2, 'engaged'),
                                        ],
                                      ),
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
