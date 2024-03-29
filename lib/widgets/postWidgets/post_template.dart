// ignore_for_fiefer_typing_uninitialized_variables

// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sherekoo/model/ceremony/crm-model.dart';
import 'package:sherekoo/model/post/post.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';
import 'package:sherekoo/screens/chats.dart';
import 'package:sherekoo/util/util.dart';

import '../../model/user/userModel.dart';
import '../../screens/crmScreen/crmDoor.dart';
import '../../screens/detailScreen/livee.dart';
import '../../screens/homNav.dart';
import '../../screens/uploadScreens/uploadSherekoo.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../animetedClip.dart';
import '../imgWigdets/defaultAvater.dart';
import '../../util/button.dart';
import "package:http/http.dart" as http;

import 'post-chats-widget.dart';

class PostTemplate extends StatefulWidget {
  final SherekooModel sherekoo;

  final filterBck;
  final Widget userPost;

  // ignore: use_key_in_widget_constructors
  const PostTemplate(
      {required this.sherekoo,
      required this.filterBck,
      required this.userPost});

  @override
  PostTemplateState createState() => PostTemplateState();
}

class PostTemplateState extends State<PostTemplate> {
  int isLike = 0;
  int totalLikes = 0;
  int totalShare = 0;
  double captionsHgth = 225;
  bool isPostAdmin = false;
  bool _open = false;
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        isPostAdmin = widget.sherekoo.isPostAdmin ? true : false;

        if (widget.sherekoo.totalLikes != '') {
          totalLikes = int.parse(widget.sherekoo.totalLikes!);
        } else {
          totalLikes = 0;
        }

        if (widget.sherekoo.totalShare != '') {
          totalShare = int.parse(widget.sherekoo.totalShare);
        } else {
          totalShare = 0;
        }

        isLike = int.parse(widget.sherekoo.isLike!);
      });
    });

    super.initState();
  }

  share() async {
    Post(
            pId: widget.sherekoo.pId,
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
            pId: widget.sherekoo.pId,
            createdBy: widget.sherekoo.creatorInfo.id!,
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

            widget.sherekoo.isLike = isLike.toString();

            widget.sherekoo.totalLikes = totalLikes.toString();
            totalLikes = int.parse(widget.sherekoo.totalLikes!);
          });
        } else if (value.payload == 'added') {
          setState(() {
            isLike++;
            totalLikes++;

            widget.sherekoo.isLike = isLike.toString();
            widget.sherekoo.totalLikes = totalLikes.toString();
            totalLikes = int.parse(widget.sherekoo.totalLikes!);
          });
        }
      }

      // make App to remember likes, or store
    });
  }

  SherekooModel sherekoMdl = SherekooModel(
      pId: '',
      createdBy: '',
      ceremonyId: '',
      body: '',
      vedeo: '',
      mediaUrl: '',
      creatorInfo: User(
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
      createdDate: '',
      commentNumber: '',
      crmInfo: CeremonyModel(
        cId: '',
        codeNo: '',
        ceremonyType: '',
        cName: '',
        fId: '',
        sId: '',
        cImage: '',
        ceremonyDate: '',
        admin: '',
        contact: '',
        isInFuture: '',
        isCrmAdmin: '',
        likeNo: '',
        chatNo: '',
        viwersNo: '',
        userFid: emptyUser,
        userSid: emptyUser,
        youtubeLink: '',
      ),
      totalLikes: '',
      isLike: '',
      totalShare: '',
      hashTag: '',
      isPostAdmin: false,
      crmViewer: '',
      waterMarklUrl: '');
  deletePost() {
    Post(
            pId: widget.sherekoo.pId,
            createdBy: '',
            body: '',
            vedeo: '',
            ceremonyId: '',
            username: '',
            avater: '',
            status: 0,
            payload: [],
            hashTag: '')
        .remove(token, urlremoveSherekoo)
        .then((value) {
      if (value.status == 200) {
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
      }
      // make App to remember likes, or store
    });
  }

  shareImage() async {
    final String dirUrl = '${api}${widget.sherekoo.waterMarklUrl}';

    Uri url = Uri.parse(dirUrl);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';

    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path], text: 'Image Shared from sherekoo');

    //inspiration Link
    // => https://protocoderspoint.com/flutter-share-files-images-videos-text-using-share_plus/
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

          //User post(Image /Vedeo)
          widget.userPost,

          //Username & Caption
          Positioned(
              bottom: 0,
              child: Container(
                  //color: Colors.red,
                  height: captionsHgth,
                  child: bodyPanel(context))),

          ///
          /// Post Details
          ///

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
                                        id: widget.sherekoo.creatorInfo.id,
                                        username: widget
                                            .sherekoo.creatorInfo.username,
                                        avater:
                                            widget.sherekoo.creatorInfo.avater,
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
                    child: _getFollowAction(
                        pictureUrl: widget.sherekoo.creatorInfo.avater!)),

                // Ceremony Avater exist
                if (widget.sherekoo.ceremonyId != '0') _getCeremonyAvater,

                const SizedBox(
                  height: 8,
                ),

                ///
                /// Like Button
                ///
                GestureDetector(
                  onTap: () {
                    onLikeButtonTapped();
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
                            isLike == 0
                                ? Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                    color: OColors.fontColor,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                    color: OColors.primary,
                                  ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              totalLikes.toString(),
                              style: header12,
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

                ///
                /// chats Buttons
                ///
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PostChats(post: widget.sherekoo)));
                    },
                    child: MyButton(
                      icon: Icons.chat_bubble,
                      number: widget.sherekoo.commentNumber!,
                    )),
                const SizedBox(
                  height: 10,
                ),

                ///
                /// post settings
                ///
                GestureDetector(
                  onTap: () async {
                    moreOptionsBuilder();

                    // // share();
                  },
                  child: Container(
                      width: 35,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.black54.withOpacity(.5),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      )),
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

  ///
  /// User body
  ///
  Column bodyPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(.4),
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(15)),
          ),
          width: MediaQuery.of(context).size.width / 1.2,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 1.0, bottom: 1.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Username info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('@ ${widget.sherekoo.creatorInfo.username}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                        color: OColors.primary,
                        highlightColor: OColors.primary,
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          setState(() => _open ^= true);

                          setState(() {
                            if (_open) {
                              captionsHgth = 450;
                            } else {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  captionsHgth = 225;
                                });
                              });
                            }
                          });
                        },
                        icon: _open == false
                            ? Icon(Icons.keyboard_arrow_up_outlined,
                                color: OColors.fontColor)
                            : Icon(Icons.keyboard_arrow_down,
                                color: OColors.fontColor))
                  ],
                ),

                // Description
                widget.sherekoo.body.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(widget.sherekoo.body, style: header15),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.green,
                          size: 16,
                        ),
                        Text(
                          'View reply',
                          style: header12,
                        ),
                      ],
                    )
                  ],
                ),

                AnimatedClipRect(
                  open: _open,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: widget.sherekoo.commentNumber != ''
                      ? SizedBox(
                          height: 230,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                PostChatsSCreen(
                                  post: widget.sherekoo,
                                ),
                              ],
                            ),
                          ))
                      : SizedBox(),
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

          child: widget.sherekoo.creatorInfo.avater!.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${api}${widget.sherekoo.creatorInfo.urlAvatar}'),
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
        widget.sherekoo.crmViewer == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CrmDoor(
                          crm: CeremonyModel(
                              cId: widget.sherekoo.ceremonyId,
                              codeNo: '',
                              ceremonyType: '',
                              cName: '',
                              fId: widget.sherekoo.crmInfo.fId,
                              sId: widget.sherekoo.crmInfo.cId,
                              cImage: widget.sherekoo.crmInfo.cImage,
                              ceremonyDate:
                                  widget.sherekoo.crmInfo.ceremonyDate,
                              contact: '',
                              admin: '',
                              isInFuture: widget.sherekoo.crmInfo.isInFuture,
                              isCrmAdmin: widget.sherekoo.crmInfo.isCrmAdmin,
                              likeNo: '',
                              chatNo: '',
                              viwersNo: '',
                              userFid: User(
                                  id: widget.sherekoo.crmInfo.userFid.id,
                                  username:
                                      widget.sherekoo.crmInfo.userFid.username,
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
                              youtubeLink: widget.sherekoo.crmInfo.youtubeLink),
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Livee(
                          ceremony: crmMdlLivee(),
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
              child: widget.sherekoo.crmInfo.cImage != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: Image.network(
                        '${api}public/uploads/${widget.sherekoo.crmInfo.userFid.username}/ceremony/${widget.sherekoo.crmInfo.cImage}',
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(height: 1),
            ),
          ])),
    );
  }

  CeremonyModel crmMdlLivee() {
    return CeremonyModel(
        cId: widget.sherekoo.ceremonyId,
        codeNo: widget.sherekoo.crmInfo.codeNo,
        ceremonyType: widget.sherekoo.crmInfo.ceremonyType,
        cName: widget.sherekoo.crmInfo.cName,
        fId: widget.sherekoo.crmInfo.fId,
        sId: widget.sherekoo.crmInfo.sId,
        cImage: widget.sherekoo.crmInfo.cImage,
        ceremonyDate: widget.sherekoo.crmInfo.ceremonyDate,
        contact: widget.sherekoo.crmInfo.contact,
        admin: widget.sherekoo.crmInfo.admin,
        isInFuture: widget.sherekoo.crmInfo.isInFuture,
        isCrmAdmin: widget.sherekoo.crmInfo.isCrmAdmin,
        likeNo: '',
        chatNo: '',
        viwersNo: '',
        userFid: User(
            id: widget.sherekoo.crmInfo.userFid.id,
            username: widget.sherekoo.crmInfo.userFid.username,
            firstname: widget.sherekoo.crmInfo.userFid.firstname,
            lastname: widget.sherekoo.crmInfo.userFid.lastname,
            avater: widget.sherekoo.crmInfo.userFid.avater,
            phoneNo: widget.sherekoo.crmInfo.userFid.phoneNo,
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
        youtubeLink: widget.sherekoo.crmInfo.youtubeLink);
  }

  ///
  /// more Options
  ///
  void moreOptionsBuilder() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: isPostAdmin ? 280 : 150,
            child: Container(
                decoration: BoxDecoration(
                    color: OColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            ///
                            /// Edit  post
                            ///
                            isPostAdmin
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SherekooUpload(
                                                    from: 'Home',
                                                    crm: emptyCrmModel,
                                                    post: widget.sherekoo,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: const Icon(Icons.add,
                                                size: 20, color: Colors.green),
                                          ),
                                          Text('Edit post', style: header14),
                                        ],
                                      ),
                                    ))
                                : SizedBox.shrink(),
                            const SizedBox(
                              height: 10,
                            ),

                            ///
                            /// delete post
                            ///

                            isPostAdmin
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      deleteAlertDialog('Delete!');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8, right: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: const Icon(Icons.delete,
                                                  size: 20,
                                                  color: Colors.green),
                                            ),
                                            Text('Delete', style: header14)
                                          ],
                                        ),
                                      ),
                                    ))
                                : SizedBox.shrink(),

                            SizedBox(
                              height: 10,
                            ),

                            ///
                            ///Share post
                            ///

                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();

                                  shareImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: const Icon(Icons.share,
                                            size: 20, color: Colors.green),
                                      ),
                                      Text('share', style: header14),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),

                            GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             const CrmBundleOrders()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: const Icon(Icons.download,
                                            size: 20, color: Colors.green),
                                      ),
                                      Text('Download', style: header14),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }

  ///
  /// Delete Alert
  ///
  deleteAlertDialog(String title) async {
    // set up the buttons

    Widget noButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        // textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: Text("No +", style: header13),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget yesButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: Text(
        "Yes ",
        style: header13,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        deletePost();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      actions: [
        Column(
          children: [
            Center(child: Text('Are you sure ?', style: header15)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                noButton,
                yesButton,
              ],
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     GestureDetector(onTap: () {}, child: setting),
            //   ],
            // ),
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
