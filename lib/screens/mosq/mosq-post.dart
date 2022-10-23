import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/mosqModle/moModel.dart';
import '../../model/post/post.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/func.dart';
import '../../util/util.dart';
import 'mosq-Home.dart';

class MosqPost extends StatefulWidget {
  const MosqPost({Key? key}) : super(key: key);

  @override
  State<MosqPost> createState() => _MosqPostState();
}

class _MosqPostState extends State<MosqPost> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
    final TextEditingController _title = TextEditingController();
      final TextEditingController _amount = TextEditingController();
  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";

  String hashTag = "";

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
            toolbarWidgetColor: OColors.primary,
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

      MosqPostModel(
        pId: '',
        createdBy: '',
        title: _title.text,
        amount: _amount.text,
        body: _body.text,
        vedeo: image,
        status: 0,
        payload: [],
      ).post(token, urlPostSherekoo).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MosqProject(
                      getIndex: 1,
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
                          meritalStatus: '',
                          totalPost: '',
                          isCurrentBsnAdmin: '',
                          isCurrentCrmAdmin: '',
                          totalFollowers: '',
                          totalFollowing: '',
                          totalLikes: ''),
                    )));
      });
    } else {
      fillTheBlanks(context, 'Select Image/Vedio Please... ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Record')),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          //Details
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 35,
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _title,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      border: InputBorder.none,
                      hintText: "title.. \n \n \n",
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

                //Amount
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 35,
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _amount,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      border: InputBorder.none,
                      hintText: "Amount.. \n \n \n",
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 95,
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
                        contentPadding:
                            EdgeInsets.only(left: 20.0, right: 20.0),
                        border: InputBorder.none,
                        hintText: "Reason.. \n \n \n",
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
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // Photo Display
          Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Title(
                    color: Colors.red, child: const Text('Document ScreeShot')),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 90,
                width: 250,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  // width: double.infinity,
                  // height: _generalimage != null ? 300 : 10,
                  color: Colors.grey,
                  child: _generalimage != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Image.file(
                            _generalimage!,
                          ),
                        )
                      : const SizedBox(height: 1),
                ),
              ),
              Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Gallary
                    GestureDetector(
                      onTap: () {
                        _openImagePicker(ImageSource.camera);
                      },
                      child: Card(
                        color: OColors.primary,
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    //cameraa
                    GestureDetector(
                      onTap: () {
                        _openImagePicker(ImageSource.gallery);
                      },
                      child: Card(
                        color: OColors.primary,
                        child: const Padding(
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
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          //Post Buttons
          GestureDetector(
            onTap: () {
              post();
            },
            child: Container(
              width: 90,
              height: 40,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  color: OColors.primary2,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Icon(
                Icons.send,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
