import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/busness/busness-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../bsnScreen/bsn-screen.dart';

class BsnMediaUpload extends StatefulWidget {
  final String busnessType,
      knownAs,
      coProfile,
      price,
      contact,
      location,
      companyName,
      ceoId,
      aboutCEO,
      aboutCompany,
      createdBy,
      hotStatus;
  const BsnMediaUpload(
      {Key? key,
      required this.busnessType,
      required this.knownAs,
      required this.coProfile,
      required this.price,
      required this.contact,
      required this.location,
      required this.companyName,
      required this.ceoId,
      required this.aboutCEO,
      required this.aboutCompany,
      required this.createdBy,
      required this.hotStatus})
      : super(key: key);

  @override
  State<BsnMediaUpload> createState() => _BsnMediaUploadState();
}

class _BsnMediaUploadState extends State<BsnMediaUpload> {
  bool isMultiple = false;

  var _images = [];
  List<XFile>? _imageFileList;

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });

    super.initState();
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      final pickedFileList = await _picker.pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 100,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });
    }
  }

  selectSubscription(lvl) async {
    BusnessCall(
      busnessType: widget.busnessType,
      knownAs: widget.knownAs,
      coProfile: widget.coProfile,
      price: widget.price,
      contact: widget.contact,
      location: widget.location,
      companyName: widget.companyName,
      ceoId: widget.ceoId,
      aboutCEO: widget.aboutCEO,
      aboutCompany: widget.aboutCompany,
      createdBy: widget.createdBy,
      hotStatus: '0',
      status: 0,
      payload: [],
      subscrlevel: lvl,
      bId: '',
    ).set(token, urlPostBusness, _imageFileList).then((v) {
      if (v.status == 200) {
        alertMessage(v.payload);
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BusnessScreen(
                      bsnType: widget.busnessType,
                      ceremony: cmr(),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('System Error, Try Again'),
        ));
      }
    });
  }

  CeremonyModel cmr() {
    return CeremonyModel(
        cId: '',
        codeNo: '',
        ceremonyType: '',
        cName: '',
        fId: '',
        sId: '',
        cImage: '',
        ceremonyDate: '',
        contact: '',
        admin: '',
        isCrmAdmin: '',
        isInFuture: '',
        likeNo: '',
        chatNo: '',
        viwersNo: '',
        userFid: User(
            id: '',
            username: '',
            firstname: '',
            lastname: '',
            avater: '',
            phoneNo: '',
            email: '',
            gender: '',
            role: '',
            address: '',
            meritalStatus: '',
            bio: '',
            totalPost: '',
            isCurrentUser: '',
            isCurrentCrmAdmin: '',
            isCurrentBsnAdmin: '',
            totalFollowers: '',
            totalFollowing: '',
            totalLikes: ''),
        userSid: User(
            id: '',
            username: '',
            firstname: '',
            lastname: '',
            avater: '',
            phoneNo: '',
            email: '',
            gender: '',
            role: '',
            address: '',
            meritalStatus: '',
            bio: '',
            totalPost: '',
            isCurrentUser: '',
            isCurrentCrmAdmin: '',
            isCurrentBsnAdmin: '',
            totalFollowers: '',
            totalFollowing: '',
            totalLikes: ''),
        youtubeLink: '');
  }

  alertMessage(String title) {
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

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        margin: EdgeInsets.only(
          right: 80,
        ),
        width: MediaQuery.of(context).size.width,
        height: 79,
        child: Semantics(
            child: ListView.builder(
              key: UniqueKey(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // Why network for web?
                //kIsWeb
                //                     ? Image.network(_imageFileList![index].path)
                //                     : Image.file(File(_imageFileList![index].path))
                // See https://pub.flutter-io.cn/packages/image_picker#getting-ready-for-the-web-platform
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: OColors.opacity.withOpacity(.2),
                    image: DecorationImage(
                        image: FileImage(File(_imageFileList![index].path)),
                        fit: BoxFit.cover),
                  ),
                );
              },
              itemCount: _imageFileList!.length,
            ),
            label: 'image_picker_example_picked_images'),
      );
    } else if (_pickImageError != null) {
      return Container(
          margin: EdgeInsets.only(
            right: 80,
          ),
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Pick image error: $_pickImageError',
            textAlign: TextAlign.center,
          ));
    } else {
      return Container(
          margin: EdgeInsets.only(
            right: 80,
          ),
          width: MediaQuery.of(context).size.width,
          child: Text(
            'You have not yet picked an image.',
            textAlign: TextAlign.center,
          ));
    }
  }

  Widget _handlePreview() => _previewImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work photo'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Stack(
              children: [
                _handlePreview(),
                Positioned(
                  child: InkWell(
                    child: Container(
                      height: 80,
                      width: 80,
                      color: OColors.primary,
                      child: Center(
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: OColors.white.withOpacity(.8),
                        ),
                      ),
                    ),
                    onTap: () {
                      _modalBottomSheetMenu();
                    },
                  ),
                  right: 0,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              selectSubscription('Free');
            },
            child: Container(
              width: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: OColors.primary,
                ),
                onTap: () {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                  Navigator.of(context).pop();
                },
                title: Text(
                  'From Camera',
                  style: TextStyle(
                    color: OColors.primary,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: OColors.primary,
                ),
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery,
                      context: context, isMultiImage: true);
                  Navigator.of(context).pop();
                },
                title: Text('From Gallery',
                    style: TextStyle(
                      color: OColors.primary,
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        });
  }
}
