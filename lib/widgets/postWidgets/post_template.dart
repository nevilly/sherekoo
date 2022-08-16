// ignore_for_fiefer_typing_uninitialized_variables

// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/chats.dart';
import 'package:sherekoo/util/util.dart';

import '../../model/profileMode.dart';
import '../../screens/detailScreen/livee.dart';
import '../../screens/homNav.dart';
import '../imgWigdets/defaultAvater.dart';
import '../../util/Preferences.dart';
import '../../util/button.dart';

class PostTemplate extends StatefulWidget {
  final String postId;
  final String avater;
  final String userId; //post Creator
  final String username;
  final String videoDescription;
  final String numberOfLikes;
  final String numberOfComments;
  final String numberOfShere;
  final String ceremonyId;
  final String cImage;
  final String crmUsername;
  final String crmYoutubeLink;
  final String postVedeo;
  final isLIke;

  final filterBck;
  final userPost;

  // ignore: use_key_in_widget_constructors
  const PostTemplate(
      {required this.postId,
      required this.numberOfComments,
      required this.numberOfLikes,
      required this.numberOfShere,
      required this.filterBck,
      required this.avater,
      required this.userPost,
      required this.postVedeo,
      required this.userId,
      required this.username,
      required this.videoDescription,
      required this.ceremonyId,
      required this.cImage,
      required this.crmUsername,
      required this.crmYoutubeLink,
      required this.isLIke});

  @override
  _PostTemplateState createState() => _PostTemplateState();
}

class _PostTemplateState extends State<PostTemplate> {
  final Preferences _preferences = Preferences();

  String token = '';
  // Full dimensions of an action
  static const double actionWidgetSize = 60.0;

// The size of the icon showen for Social Actions

  static const double actionIconSize = 35.0;

// The size of the share social icon
  static const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double plusIconSize = 20.0;

  double likeNo = 0;
  dynamic isLike;
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        // likeNo = widget.numberOfLikes ;
        // isLike = widget.isLIke;
      });
    });

    super.initState();
  }

  onLikeButtonTapped(isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    if (isLiked == '1') {
      print('remove Like');
      setState(() {
        // likeNo = likeNo - 1;
        isLike = '0';
        print(3 - 1);
        print(isLike);
      });
    }

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.blue,
          body: Stack(
        children: [
          //back Image filter
          widget.filterBck,

          // User post(Image /Vedeo)
          widget.userPost,

          //Username & Caption
          Positioned(
              bottom: 0,
              child: SizedBox(height: 100, child: bodyPanel(context))),

          Positioned(
            right: 0,
            bottom: 3,
            child: Container(
              padding: const EdgeInsets.only(bottom: 0, right: 1.0),
              width: 60,
              color: Colors.transparent,
              alignment: const Alignment(1, 1),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                //User Avater
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomeNav(
                                    user: User(
                                        id: widget.userId,
                                        username: widget.username,
                                        avater: widget.avater,
                                        phoneNo: '',
                                        role: '',
                                        gender: '',
                                        email: '',
                                        firstname: '',
                                        lastname: '',
                                        isCurrentUser: '',
                                        address: '',
                                        bio: '',
                                        meritalStatus: ''),
                                    getIndex: 4,
                                  )));
                    },
                    child: _getFollowAction(pictureUrl: widget.avater)),

                // Ceremony Avater exist
                if (widget.ceremonyId != '0') _getCeremonyAvater,

                const SizedBox(
                  height: 8,
                ),
                // Like Button
                GestureDetector(
                  onTap: () {
                    // onLikeButtonTapped(widget.isLIke);
                  },
                  child: Container(
                    width: 35,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Column(
                          children: [
                            widget.isLIke == '0'
                                ? const Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.numberOfLikes,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            // const SizedBox(
                            //   height: 8.0,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // chats Buttons
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PostChats(
                                    postId: widget.postId,
                                  )));
                    },
                    child: MyButton(
                        icon: Icons.chat_bubble,
                        number: widget.numberOfComments)),
                const SizedBox(
                  height: 10,
                ),

                // share
                GestureDetector(
                  onTap: () async {
                    final String dirUrl = api +
                        'public/uploads/' +
                        widget.username +
                        '/posts/' +
                        widget.postVedeo;

                    Uri url = Uri.parse(dirUrl);
                    final response = await http.get(url);
                    final bytes = response.bodyBytes;
                    ByteData imagebyte = await rootBundle
                        .load('assets/logo/waterMark/sherekoo.jpg');
                    final logo = imagebyte.buffer.asUint8List();

                    // waterMark
                    final watermarkedImgBytes =
                        await image_watermark.addImageWatermark(
                            bytes, //image bytes
                            logo, //watermark img bytes
                            imgHeight: 250, //watermark img height
                            imgWidth: 250, //watermark img width
                            dstY: 400,
                            dstX: 400);

                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.jpg';

                    File(path).writeAsBytesSync(watermarkedImgBytes);
                    await Share.shareFiles([path],
                        text: 'Image Shared from sherekoo');

                    //inspiration Link
                    // => https://protocoderspoint.com/flutter-share-files-images-videos-text-using-share_plus/
                  },
                  child: MyButton(
                      icon: Icons.reply_rounded, number: widget.numberOfShere),
                ),
                const SizedBox(
                  height: 4,
                ),
              ]),
            ),
          ),
        ],
      )),
    );
  }

  // User body
  Column bodyPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(.2),
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(15)),
          ),
          width: MediaQuery.of(context).size.width / 1.2,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Username info
                Text('@ ' + widget.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.videoDescription,
                        style: const TextStyle(fontSize: 12.0)),
                    // const TextSpan(
                    //     text: ' @ koosafi',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 12.0)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient get musicGradient => const LinearGradient(colors: [
        Color(0xFF424242),
        Color(0xFF212121),
        Color(0xFF212121),
        Color(0xFF424242)
      ], stops: [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Widget _getFollowAction({required String pictureUrl}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(), _getPlusIcon()]));
  }

  Widget _getProfilePicture() {
    return Positioned(
        left: (actionWidgetSize / 2) - (profileImageSize / 2),
        child: Container(
          padding: const EdgeInsets.all(
              1.0), // Add 1.0 point padding to create border
          height: profileImageSize, // ProfileImageSize = 50.0;
          width: profileImageSize, // ProfileImageSize = 50.0;

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(profileImageSize / 2)),

          child: widget.avater.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(api +
                      'public/uploads/' +
                      widget.username +
                      '/profile/' +
                      widget.avater),
                )
              : const DefaultAvater(
                  height: profileImageSize,
                  radius: 15,
                  width: profileImageSize),
        ));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((actionWidgetSize / 2) - (plusIconSize / 2)),
      child: Container(
          width: plusIconSize, // PlusIconSize = 20.0;
          height: plusIconSize, // PlusIconSize = 20.0;
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 43, 84),
              borderRadius: BorderRadius.circular(15.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  Widget get _getCeremonyAvater {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Livee(
                      ceremony: CeremonyModel(
                          cId: widget.ceremonyId,
                          codeNo: '',
                          ceremonyType: '',
                          cName: '',
                          fId: '',
                          sId: '',
                          cImage: widget.cImage,
                          ceremonyDate: '',
                          contact: '',
                          admin: '',
                          u1: widget.crmUsername,
                          u1Avt: '',
                          u1Fname: '',
                          u1Lname: '',
                          u1g: '',
                          u2: '',
                          u2Avt: '',
                          u2Fname: '',
                          u2Lname: '',
                          u2g: '',
                          youtubeLink: widget.crmYoutubeLink),
                    )));
      },
      child: SizedBox(
          // margin: const EdgeInsets.only(top: 10.0),
          width: actionWidgetSize,
          height: actionWidgetSize,
          child: Column(children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: profileImageSize,
              width: profileImageSize,
              decoration: BoxDecoration(
                  gradient: musicGradient,
                  borderRadius: BorderRadius.circular(profileImageSize / 2)),
              child: widget.cImage != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: Image.network(
                        api +
                            'public/uploads/' +
                            widget.crmUsername +
                            '/ceremony/' +
                            widget.cImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(height: 1),
             
            ),
          ])),
    );
  }
}
