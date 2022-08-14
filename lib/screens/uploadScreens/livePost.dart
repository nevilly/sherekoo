// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/allData.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/home.dart';

import '../../model/post/post.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class LivePostUpload extends StatefulWidget {
  final String getcurrentUser;
  final CeremonyModel ceremony;
  const LivePostUpload(
      {Key? key, required this.ceremony, required this.getcurrentUser})
      : super(key: key);

  @override
  State<LivePostUpload> createState() => _LivePostUploadState();
}

class _LivePostUploadState extends State<LivePostUpload> {
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
      role: '', isCurrentUser: '');

  // Image upload
  final _picker = ImagePicker();

  // late VideoPlayerController _videoPlayerController;
  // late VideoPlayerController _cameraVideoPlayerController;

  // Implementing the image Camera picker
  _openImagePickerG(arg) async {
    final pickG = _picker.pickImage(source: ImageSource.gallery);
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
      // print('imageeeeeeeeeeee');
      // print(image);

      Post(
        pId: '',
        createdBy: currentUser.id,
        body: _body.text,
        vedeo: image,
        ceremonyId: widget.ceremony.cId,
        status: 0,
        payload: [],
        avater: '',
        username: '',
      ).post(token, urlPostSherekoo).then((value) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Home()));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OColors.appBarColor,
        title: const Text('LIve Upload',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            )),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => const UploadVedeo()));
          //   },
          //   child: const Icon(Icons.post_add),
          // )

          GestureDetector(
            onTap: () {
              post();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 2, bottom: 2),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 104, 12),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  'Post',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //Whats On your Mind
          const SizedBox(
            height: 45,
          ),
          Container(
            height: 105,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
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
                // prefixIcon: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Icon(
                //     Icons.wrap_text,
                //     size: 20,
                //     color: Colors.grey,
                //   ),
                // ),
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
                        color: Color.fromARGB(255, 243, 104, 12),
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

                //cameraa
                GestureDetector(
                  onTap: () {
                    _openImagePickerC('slctdChereko');
                  },
                  child: Row(
                    children: const [
                      Card(
                        color: Color.fromARGB(255, 243, 104, 12),
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
            height: 10,
          ),

          // Photo Display
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // width: double.infinity,
              height: _generalimage != null ? 200 : 10,
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
    );
  }
}
