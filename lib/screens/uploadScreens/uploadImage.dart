import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/post/post.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../detailScreen/livee.dart';

class UploadImage extends StatefulWidget {
  final String from;
  final CeremonyModel crm;
  const UploadImage({Key? key, required this.from, required this.crm})
      : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });
    super.initState();
  }

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
  Future cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Shereko Cropper',
            toolbarColor: OColors.appBarColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Sherekoo Cropper',
        ),
        // WebUiSettings(
        //   context: context,
        // ),
      ],
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  // Posting
  Future<void> post() async {
    if (_generalimage != null) {
      List<int> bytes = _generalimage!.readAsBytesSync();
      String image = base64Encode(bytes);

      Post(
        pId: '',
        createdBy: '',
        body: _body.text,
        vedeo: image,
        ceremonyId: widget.crm.cId,
        status: 0,
        payload: [],
        avater: '',
        username: '',
      ).post(token, urlPostSherekoo).then((value) {
        if (widget.from == 'Home') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeNav(
                        getIndex: 2,
                        user: User(
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
                            meritalStatus: ''),
                      )));
        } else if (widget.from == 'Ceremony') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Livee(
                        ceremony: widget.crm,
                      )));
        }
    
      });
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
                  _openImagePicker(ImageSource.camera);
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
                  _openImagePicker(ImageSource.gallery);
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
