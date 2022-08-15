import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/allData.dart';
import 'package:sherekoo/screens/homNav.dart';

import '../../model/post/post.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final Preferences _preferences = Preferences();
  String token = "";
  final TextEditingController _body = TextEditingController();
  File? _generalimage;

  



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
      isCurrentUser: '', meritalStatus: '', address: '', bio: '');

  // Image upload
  final _picker = ImagePicker();
  final _pickerG = ImagePicker();

  // late VideoPlayerController _videoPlayerController;
  // late VideoPlayerController _cameraVideoPlayerController;

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
        getUser();
      });
    });
    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  Future<void> post() async {
    if (_generalimage != null) {
      List<int> bytes = _generalimage!.readAsBytesSync();
      String image = base64Encode(bytes);
      print('imageeeeeeeeeeee');
      print(image);

      Post(
        pId: '',
        createdBy: currentUser.id,
        body: _body.text,
        vedeo: image,
        ceremonyId: '',
        status: 0,
        payload: [],
        avater: '',
        username: '',
      ).post(token, urlPostSherekoo).then((value) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeNav(
                        getIndex: 2,
                        user: currentUser,
                      )));
        });
      });
      // AllIbada(
      //         payload: [],
      //         status: 0,
      //         ibadaType: selectedType,
      //         id: '',
      //         title: _title.text,
      //         body: _body.text,
      //         image: image,
      //         startDate: _startDate.text,
      //         endDate: _endDate.text,
      //         startTime: _startTime.text,
      //         endTime: _endTime.text,
      //         youtubeId: _youtubeId.text,
      //         createdBy: currentUser.id)
      //     .get(token, urlPostIbada)
      //     .then((v) {
      //   // print('v.payload');
      //   // print(v.payload);
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (BuildContext context) => const NavIbada()));

      // });
    } else {
      fillMessage(
        'Select Image/Vedio Please... ',
      );
    }
  }

  // Empty Input Messages
  fillMessage(String arg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        arg,
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Photo Display
        Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                // width: double.infinity,
                // height: _generalimage != null ? 300 : 10,
                color: Colors.grey[300],
                child: _generalimage != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.file(
                          _generalimage!,
                        ),
                      )
                    : const SizedBox(height: 1),
              ),
            ),
          ],
        ),

        // ButtonsCamera & Gallary
        Positioned(
          top: 5,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Gallary
              GestureDetector(
                onTap: () {
                  _openImagePickerG('slctdChereko');
                },
                child: const Card(
                  color: Color.fromARGB(255, 243, 104, 12),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              //cameraa
              GestureDetector(
                onTap: () {
                  _openImagePickerC('slctdChereko');
                },
                child: const Card(
                  color: Color.fromARGB(255, 243, 104, 12),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.photo_library,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //What On your mind
        Positioned(
          bottom: 10,
          left: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //What on your
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 70,
                  padding: const EdgeInsets.only(
                    top: 5,
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
                      hintText: "What's on your mind \n \n \n",
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

                //Post Buttons
                GestureDetector(
                  onTap: () {
                    post();
                  },
                  child: Container(
                    width: 45,
                    height: 40,
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 104, 12),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
