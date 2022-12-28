// ignore_for_fiefer_typing_uninitialized_variables

// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sherekoo/model/ceremony/crm-model.dart';
import 'package:sherekoo/model/post/post.dart';
import 'package:sherekoo/screens/chats.dart';
import 'package:sherekoo/util/util.dart';

import '../../model/user/userModel.dart';
import '../../screens/crmScreen/crmDoor.dart';
import '../../screens/detailScreen/livee.dart';
import '../../screens/homNav.dart';
import '../imgWigdets/defaultAvater.dart';
import '../../util/Preferences.dart';
import '../../util/button.dart';
import 'likeLife.dart';

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
  final isLike;
  final crmViewer;

  final filterBck;
  final Widget userPost;

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
      required this.isLike,
      required this.crmViewer});

  @override
  PostTemplateState createState() => PostTemplateState();
}

class PostTemplateState extends State<PostTemplate> {
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
  int isLike = 0;
  int totalLikes = 0;
  int totalShare = 0;

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      token = value;
    });

    if (widget.numberOfLikes != '') {
      totalLikes = int.parse(widget.numberOfLikes);
    } else {
      totalLikes = 0;
    }

    if (widget.numberOfShere != '') {
      totalShare = int.parse(widget.numberOfShere);
    } else {
      totalShare = 0;
    }
    isLike = int.parse(widget.isLike);
    super.initState();
  }

  share() async {
    Post(
            pId: widget.postId,
            createdBy: '',
            body: '',
            vedeo: '',
            ceremonyId: '',
            username: '',
            avater: '',
            status: 0,
            payload: [],
            hashTag: '')
        .share(token, urlpostShare, 'Post')
        .then((value) {
      if (value.status == 200) {
        setState(() {
          totalShare++;
        });
      }
      // make App to remember likes, or store
    });
  }

  onLikeButtonTapped() async {
    Post(
            pId: widget.postId,
            createdBy: widget.userId,
            body: '',
            vedeo: '',
            ceremonyId: '',
            username: '',
            avater: '',
            status: 0,
            payload: [],
            hashTag: '')
        .likes(token, urlpostLikes, isLike.toString())
        .then((value) {
      // print(value.payload);

      if (value.status == 200) {
        if (value.payload == 'removed') {
          setState(() {
            isLike--;
            totalLikes--;
          });
        } else if (value.payload == 'added') {
          setState(() {
            isLike++;
            totalLikes++;
          });
        }
      }

      // make App to remember likes, or store
    });
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

          //Post Details
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
                                        meritalStatus: '',
                                        totalPost: '',
                                        isCurrentBsnAdmin: '',
                                        isCurrentCrmAdmin: '',
                                        totalFollowers: '',
                                        totalFollowing: '',
                                        totalLikes: ''),
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
                    onLikeButtonTapped();
                  },
                  child: LikeLife(isLike: isLike, totalLikes: totalLikes),
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
                                    chatsNo: widget.numberOfComments,
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
                    share();
                    final String dirUrl =
                        '${api}public/uploads/${widget.username}/posts/${widget.postVedeo}';

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
                      icon: Icons.reply_rounded, number: totalShare.toString()),
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
                Text('@ ${widget.username}',
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
                  backgroundImage: NetworkImage(
                      '${api}public/uploads/${widget.username}/profile/${widget.avater}'),
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
        widget.crmViewer == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CrmDoor(
                          crm: CeremonyModel(
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
                              isInFuture: '',
                              isCrmAdmin: '',
                              likeNo: '',
                              chatNo: '',
                              viwersNo: '',
                              userFid: User(
                                  id: '',
                                  username: widget.crmUsername,
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
                              youtubeLink: widget.crmYoutubeLink),
                        )))
            : Navigator.push(
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
                              isInFuture: '',
                              isCrmAdmin: '',
                              likeNo: '',
                              chatNo: '',
                              viwersNo: '',
                              userFid: User(
                                  id: '',
                                  username: widget.crmUsername,
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
                        '${api}public/uploads/${widget.crmUsername}/ceremony/${widget.cImage}',
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(height: 1),
            ),
          ])),
    );
  }
}
