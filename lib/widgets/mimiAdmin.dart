import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/InvCards/invCards.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/ourServices/sherekoCards.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';

import '../../util/Preferences.dart';
import '../../util/func.dart';
import '../../util/util.dart';
import '../model/userModel.dart';
import '../util/appWords.dart';
import '../util/textStyle-pallet.dart';

class MkweriWaMaisha extends StatefulWidget {
  final String from;
  final CeremonyModel crm;
  const MkweriWaMaisha({Key? key, required this.from, required this.crm})
      : super(key: key);

  @override
  State<MkweriWaMaisha> createState() => _MkweriWaMaishaState();
}

class _MkweriWaMaishaState extends State<MkweriWaMaisha> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";

  String hashTag = "";
User user =  User(
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
      // print(image);
      InvCards(
        status: 0,
        payload: [],
      )
          .postCard(token, urladdInvCards, 'Wedding', image, image, image,
              image, 'Mchumba waa', '1000', '50')
          .then((value) {
     
        if (value.status == 200) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SherekoCards(
                        crm: ceremony,
                        user: user,
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

        //What On your mind
        Positioned(
          bottom: 15,
          left: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 200,
                ),
                //What on your
                // Container(
                //   width: MediaQuery.of(context).size.width / 2.3,
                //   height: 55,
                //   padding: const EdgeInsets.only(
                //     top: 5,
                //   ),
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1, color: Colors.grey),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: TextField(
                //     controller: _body,
                //     maxLines: null,
                //     expands: true,
                //     textAlign: TextAlign.left,
                //     keyboardType: TextInputType.multiline,
                //     decoration: const InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                //       border: InputBorder.none,
                //       hintText: "What's on your mind \n \n \n",
                //       hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                //     ),
                //     style: const TextStyle(
                //         fontSize: 15, color: Colors.grey, height: 1.5),
                //     onChanged: (value) {
                //       setState(() {
                //         //_email = value;
                //       });
                //     },
                //   ),
                // ),

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
