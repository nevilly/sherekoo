import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:video_player/video_player.dart';

import '../../model/post/post.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../detailScreen/livee.dart';
import '../homNav.dart';

class UploadVedeo extends StatefulWidget {
  final String from;
  final CeremonyModel crm;
  const UploadVedeo({Key? key, required this.from, required this.crm})
      : super(key: key);

  @override
  State<UploadVedeo> createState() => _UploadVedeoState();
}

class _UploadVedeoState extends State<UploadVedeo> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
  final _picker = ImagePicker();

  late VideoPlayerController _videoPlayerController;

  String token = "";
  String? _video;

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getUser();
      });
    });
    super.initState();
  }

  Future getVideo({int state = 0}) async {
    final _v = await _picker.pickVideo(
        source: state == 1 ? ImageSource.camera : ImageSource.gallery);
    File v;

    if (_v != null) {
      v = File(_v.path);
      _videoPlayerController = VideoPlayerController.file(v)
        ..initialize().then((_) {
          setState(() {
            _video = _v.path;
          });
          _videoPlayerController.play();
        });
    }
  }

  Future<void> postVedeo() async {
    if (_video != null) {
      // print('vedeo');
      // print(_video);

      Post(
        pId: '',
        createdBy: '',
        body: _body.text,
        vedeo: '',
        ceremonyId: widget.crm.cId,
        status: 0,
        payload: [],
        avater: '',
        username: '',
      ).set(token, urlVedioPostSherekoo, _video).then((value) {
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
                            totalPost: ''),
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
    return Stack(children: [
      Column(
        children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: OColors.secondary,
                child: Column(
                  children: [
                    if (_video != null)
                      _videoPlayerController.value.isInitialized
                          ? Expanded(
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            )
                          : const Text('Somthing wrong...'),
                  ],
                )),
          ),
        ],
      ),

      // Uploads Buttons
      Positioned(
        top: 25,
        right: 8,
        child: Container(
          color: Colors.transparent,
          alignment: const Alignment(1, 1),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            GestureDetector(
              onTap: () {
                getVideo(state: 1);
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                getVideo(state: 2);
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
          ]),
        ),
      ),

      // Post B utton
      Positioned(
        bottom: 15,
        left: 5,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //TextField ..
                Container(
                  // color: Colors.black45,
                  width: MediaQuery.of(context).size.width / 1.3, height: 55,
                  margin: const EdgeInsets.only(left: 1, right: 1),
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
                      hintStyle: TextStyle(color: Colors.black, height: 1.5),
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

                //Post Button
                GestureDetector(
                  onTap: () {
                    postVedeo();
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
            )),
      ),
    ]);
  }
}
