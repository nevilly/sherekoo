import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/ceremony/crm-model.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';
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
  final User user;
  final SherekooModel post;
  const UploadImage(
      {Key? key,
      required this.from,
      required this.crm,
      required this.user,
      required this.post})
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
  int profile = 0;
  String id = '';
  String createdBy = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        if (widget.post.pId.isNotEmpty) {
          _body.text = widget.post.body;
          id = widget.post.pId;
          createdBy = widget.post.createdBy;
        }

        if (widget.post.vedeo.isNotEmpty) {
          profile = 1;
        }
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
      profile = 2;
    });
  }

  // Posting
  Future<void> post() async {
    String image = '';
    if (profile == 2) {
      if (_generalimage != null) {
        List<int> bytes = _generalimage!.readAsBytesSync();
        image = base64Encode(bytes);
      }
    }

    if (profile == 1) {
      image = widget.post.vedeo;
    }

    String dirUrl =
        widget.post.pId.isNotEmpty ? urlUpdateSherekoo : urlPostSherekoo;
    if (image != '') {
      Post(
        pId: id,
        createdBy: createdBy,
        body: _body.text,
        vedeo: image,
        ceremonyId: widget.crm.cId,
        hashTag: hashTag,
        status: 0,
        payload: [],
        avater: '',
        username: '',
      ).post(token, dirUrl, widget.user.gId!, profile.toString()).then((value) {
        if (widget.from == 'Home') {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeNav(
                        getIndex: 2,
                        user: User(
                            id: '',
                            gId: '',
                            urlAvatar: '',
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
      fillTheBlanks(context, imgOrVdoUploadAlt, altSty, odng);
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
                child: Stack(children: [
                  if (profile == 0) SizedBox.shrink(),
                  if (profile == 1)
                    Image.network(
                      api + widget.post.mediaUrl,
                      // height: 400,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  if (profile == 2)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.file(
                        _generalimage!,
                      ),
                    )
                ]),
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
              // camera
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
              const SizedBox(height: 8.0),
              //Gallalery
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

              const SizedBox(height: 8.0),
              widget.post.vedeo.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _generalimage = null;
                          profile = 1;
                          // Navigator.of(context).pop();
                        });
                      },
                      child: Card(
                        color: OColors.primary,
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.reply,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 8.0),

              if (_generalimage != null || profile == 1)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _generalimage = null;
                      profile = 0;
                    });
                  },
                  child: Card(
                    color: OColors.primary,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
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
                        color: OColors.primary,
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
