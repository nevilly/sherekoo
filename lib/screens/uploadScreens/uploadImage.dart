import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/ceremony/crm-model.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/post/post.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
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

   

      Post(
        pId: '',
        createdBy: '',
        body: _body.text,
        vedeo: image,
        ceremonyId: widget.crm.cId,
        hashTag: hashTag,
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
                            meritalStatus: '',
                            totalPost: '', isCurrentBsnAdmin: '', 
      isCurrentCrmAdmin: '',
      totalFollowers: '', 
      totalFollowing: '', 
      totalLikes: ''),
                      )));
        } else if (widget.from == 'Ceremony') {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Livee(
                        ceremony: widget.crm,
                      )));
        }
      });

    } else {

      fillTheBlanks(context,imgOrVdoUploadAlt,altSty,odng);
    }
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
                color: OColors.secondary,
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
          top: 25,
          right: 10,
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
        
        if (widget.from == 'Ceremony')
        Positioned(
            bottom: 78,
            left: 15,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        hashTag = 'Home';
                      });
                    },
                    child: hashTagFunc(context, 'Home', hashTag)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        hashTag = 'Church';
                      });
                    },
                    child: hashTagFunc(context, 'Church', hashTag)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        hashTag = 'AtWedding';
                      });
                    },
                    child: hashTagFunc(context, 'AtWedding', hashTag)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        hashTag = 'Beach';
                      });
                    },
                    child: hashTagFunc(context, 'Beach', hashTag)),
              ],
            )),
        //What On your mind
        Positioned(
          bottom: 15,
          left: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //What on your
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 55,
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
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: OColors.primary2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.send,
                      size: 20,
                      color: OColors.fontColor,
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
