import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/crmPackage/crmPackage.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import 'crmPckSelect.dart';

class CrmPackageAdd extends StatefulWidget {
  const CrmPackageAdd({Key? key}) : super(key: key);

  @override
  State<CrmPackageAdd> createState() => _CrmPackageAddState();
}

class _CrmPackageAddState extends State<CrmPackageAdd> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _colorName = TextEditingController();
  final TextEditingController _inYear = TextEditingController();

  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";

  final List _col = [];

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

  // Posting
  Future<void> post() async {
    // if (_col.isNotEmpty) {
    if (_generalimage != null) {
      List<int> bytes = _generalimage!.readAsBytesSync();
      String image = base64Encode(bytes);

      CrmPackage(
        status: 0,
        payload: [],
      )
          .post(token, urladdCrmPackage, _title.text, _body.text, _col, image,
              _inYear.text)
          .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const CrmPckList()));
      });
    } else {
      fillTheBlanks(context, imgInsertAlt, altSty, odng);
    }
    // } else {
    //   fillTheBlanks(context, clrCodeAlert, altSty, odng);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Bundles'),
        actions: [
          GestureDetector(
            onTap: () {
              post();
            },
            child: Container(
              width: 50,
              height: 30,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Icon(
                Icons.send,
                size: 16,
                color: OColors.fontColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //Details
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
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
                        contentPadding:
                            EdgeInsets.only(left: 20.0, right: 20.0),
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
                ),

                const SizedBox(
                  height: 8,
                ),

                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
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

                const SizedBox(
                  height: 8,
                ),

                //ColorName
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Title(
                    color: Colors.grey,
                    child: const Text('ColorCode of The Years'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
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
                              controller: _colorName,
                              maxLines: null,
                              expands: true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                border: InputBorder.none,
                                hintText: "Color Name.. \n \n \n",
                                hintStyle:
                                    TextStyle(color: Colors.grey, height: 1.5),
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

                          //Color
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
                              controller: _color,
                              maxLines: null,
                              expands: true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                border: InputBorder.none,
                                hintText: "Color.. \n \n \n",
                                hintStyle:
                                    TextStyle(color: Colors.grey, height: 1.5),
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
                        ],
                      ),
                      //Post Buttons
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            var colory = {
                              "colorName": _colorName.text,
                              "color": _color.text
                            };
                            _col.add(colory);
                            print(_col);
                            _colorName.clear();
                            _color.clear();
                          });
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
                            Icons.add,
                            size: 20,
                            color: OColors.fontColor,
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
            height: 6,
          ),
          //Post Buttons

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
              controller: _inYear,
              maxLines: null,
              expands: true,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                border: InputBorder.none,
                hintText: "In Year \n \n \n",
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
        ],
      ),
    );
  }

  void addColorCode() {
    return setState(() {
      var colory = {"colorName": _colorName.text, "Color": _color.text};
      _col.add(colory);
      _colorName.clear();
      _color.clear();
    });
  }
}
