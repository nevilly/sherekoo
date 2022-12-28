// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/screens/profile/profile.dart';
import 'package:sherekoo/util/colors.dart';


import '../../model/authentication/creatAccount.dart';
import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
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
      totalLikes: ''
      
      );

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
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14))
      ],
    );
  }

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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // print('checkk token');
        // print(token);

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
                        builder: (BuildContext context) => Profile(
                              user: currentUser,
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
        title: const Text('Complete Info'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              creatAccount(firstName.text, lastName.text, _generalimage,
                  selectedRegion, select);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 18.0, right: 18.0),
              child: Text('Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontStyle: FontStyle.italic)),
            ),
          ),
        ],
      ),

      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: OColors.appBarColor,

      body: Column(
        children: [
          
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Spacer(),

                // Title Add title
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Add Your Photo',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

                // Avatar upload...
                Container(
                  alignment: Alignment.center,
                  // width: double.infinity,
                  height: 120,
                  // color: Colors.grey[300],
                  child: _generalimage != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            radius: 100,
                            child: ClipOval(
                              child: Image.file(
                                _generalimage!,
                                fit: BoxFit.cover,
                                width: 110.0,
                                height: 110.0,
                                // width: 100,
                              ),
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 120,
                          child: ClipOval(
                            child: Image(
                              image: AssetImage('assets/profile/profile.jpg'),
                              fit: BoxFit.cover,
                              width: 110,
                              height: 110,
                            ),
                          ),
                        ),

                  // CircleAvatar(
                  //     radius: 100,
                  //     backgroundImage:Image(image: Image.network(api)),
                  //   ),
                ),

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
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Text(
                                            'Add Your information',
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
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person,
                                            size: 28,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'First Name',
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
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.person_add,
                                            size: 28,
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
