import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/screens/uploadScreens/uploadSherekoo.dart';
import 'package:sherekoo/util/textStyle-pallet.dart';
import "package:http/http.dart" as http;

import '../../model/chats/chatsModel.dart';
import '../../model/chats-reply/replyCall.dart';
import '../../model/chats-reply/replyModule.dart';
import '../../model/chats/chat-call.dart';
import '../../model/post/post.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/util.dart';

class PostChatsSCreen extends StatefulWidget {
  final SherekooModel post;

  const PostChatsSCreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostChatsSCreen> createState() => _PostChatsSCreenState();
}

class _PostChatsSCreenState extends State<PostChatsSCreen> {
  ScrollController _controller = ScrollController();
  String postid = '';
  bool textfield = true;

  List<ChatsModel> chats = [];
  final TextEditingController _body = TextEditingController();
  final TextEditingController _replybody = TextEditingController();
  int id = 0;

  bool isPostAdmin = false;
  @override
  void initState() {
    preferences.init();
    postid = widget.post.pId;
    // print('postid');
    // print(postid);
    backgroundTask();

    preferences.get('token').then((value) {
      setState(() {
        token = value;
        isPostAdmin = widget.post.isPostAdmin;
        getPost();
      });
    });

    super.initState();
  }

  backgroundTask() async {
    // print("Hello");
    getPost();
    Timer.periodic(const Duration(seconds: 4), getPosts);
  }

  getPosts(Timer timer) {
    // print("Hello World ${id}");
    getPost();
    id++;

    return timer;
  }

  getPost() async {
    ChatsCall(
      payload: [],
      status: 0,
      body: '',
      postId: postid,
      userId: '',
    ).get(token, urlGetChats).then((value) {
      if (mounted) {
        if (value.status == 200)
          setState(() {
            chats = value.payload
                .map<ChatsModel>((e) => ChatsModel.fromJson(e))
                .toList();
          });
      }
    });
    id++;
  }

  List<ReplyModel> reply = [];
  replyChat(ChatsModel c) async {
    if (_replybody.text.isNotEmpty) {
      ReplyCall(
        payload: [],
        status: 0,
        body: _replybody.text,
        postId: widget.post.pId,
        userId: '',
        chatId: c.id,
        id: '',
      ).post(token, urlAddReply).then((value) {
        if (mounted) {
          if (value.status == 200) print('-----payload-----');
          print(value.payload);
          setState(() {
            // reply = value.payload
            //     .map<ReplyModel>((e) => ReplyModel.fromJson(e))
            //     .toList();
          });
        }
      });
    } else {
      emptyField(context, 'reply is empty..');
    }
  }

  Future<void> post() async {
    if (_body.text != '') {
      ChatsCall(
        postId: widget.post.pId,
        userId: '',
        body: _body.text,
        status: 0,
        payload: [],
      ).post(token, urlPostChats).then((value) {
        setState(() {});
        // print(value.payload);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'body Empty',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  User user = User(
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
      whatYouDo: '',
      followInfo: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      currentFllwId: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  deletePost() {
    Post(
            pId: widget.post.pId,
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
    final String dirUrl = '${api}${widget.post.waterMarklUrl}';

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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: ListView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: chats.length,
        itemBuilder: (BuildContext context, index) {
          final itm = chats[index];

          final urlProfile = api + itm.userInfo.urlAvatar!;
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 3),
            color: OColors.transparent,
            padding: const EdgeInsets.only(top: 8.0, left: 4.0, bottom: 0),
            child: Column(
              children: [
                ///
                /// user Details
                ///
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => HomeNav(
                                        user: User(
                                            id: itm.userId,
                                            username: itm.userInfo.username,
                                            avater: itm.userInfo.avater,
                                            gId: itm.userInfo.gId,
                                            urlAvatar: itm.userInfo.urlAvatar,
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
                        child: personProfileClipOval(
                          context,
                          itm.userInfo.avater!,
                          urlProfile,
                          const SizedBox.shrink(),
                          16,
                          35,
                          35,
                          Colors.grey,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///
                              /// UserName
                              ///
                              Text(chats[index].userInfo.username!,
                                  style: header13.copyWith(
                                    color: OColors.fontColor,
                                    fontWeight: FontWeight.w600,
                                  )),

                              ///
                              /// chat settings
                              ///
                              Text(itm.date,
                                  style: header12.copyWith(
                                    color: OColors.fontColor,
                                  )),
                            ],
                          ),
                        ),

                        ///
                        /// body Message
                        ///
                        Container(
                          padding: const EdgeInsets.only(
                              top: 1.0, left: 0, right: 2),
                          alignment: Alignment.topLeft,
                          child: Text(itm.body!,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: OColors.fontColor,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 30, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: OColors.primary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          itm.replyInfo.first.id.isNotEmpty
                              ? Text(
                                  'replies(${itm.replyInfo.length.toString()})',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: OColors.fontColor,
                                  ))
                              : Text('replies(0)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: OColors.fontColor,
                                  ))
                        ],
                      ),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            textfield = false;
                          });

                          replyTextBoxBuilder(context, itm);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text('reply',
                              style: TextStyle(
                                  color: OColors.fontColor, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                /// Replyings
                ///
                SizedBox(height: 6),
                itm.replyInfo.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(left: 25, right: 0),
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: itm.replyInfo.length,
                                itemBuilder: (BuildContext context, i) {
                                  final rply = itm.replyInfo[i];
                                  return rply.id.isNotEmpty
                                      ? replyContainer(context, rply, index)
                                      : SizedBox.shrink();
                                }),
                          ],
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          );
        },
      ),
    );
  }

  Column replyContainer(BuildContext context, ReplyModel rply, int index) {
    return Column(
      children: [
        SizedBox(height: 4),
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomeNav(
                                    user: rplyUserInfo(rply),
                                    getIndex: 4,
                                  )));
                    },
                    child: personProfileClipOval(
                      context,
                      rply.userInfo.avater!,
                      api + rply.userInfo.urlAvatar!,
                      const SizedBox.shrink(),
                      14,
                      45,
                      45,
                      Colors.grey,
                    )),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Column(
                children: [
                  ///
                  /// UserName
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rply.userInfo.username!,
                          style: header12.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                      Row(
                        children: [
                          ///
                          /// chat settings
                          ///
                          Row(
                            children: [
                              Text(rply.date,
                                  style: TextStyle(
                                      color: OColors.fontColor, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///
                  /// body Message
                  ///
                  Container(
                    padding: const EdgeInsets.only(top: 1.0, left: 5, right: 4),
                    alignment: Alignment.topLeft,
                    child: Text(rply.body!,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13.0,
                          color: OColors.fontColor,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }

  User rplyUserInfo(ReplyModel rply) {
    return User(
        id: rply.userId,
        username: rply.userInfo.username,
        avater: rply.userInfo.avater,
        gId: rply.userInfo.gId,
        urlAvatar: rply.userInfo.urlAvatar,
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
        totalLikes: '');
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
                            widget.post.isPostAdmin
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SherekooUpload(
                                                    from: 'profile',
                                                    crm: emptyCrmModel,
                                                    post: widget.post,
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

  ///
  /// Reply Textbox
  ///
  replyTextBoxBuilder(BuildContext context, ChatsModel itm) async {
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
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(8.0),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text('Reply To', style: TextStyle(color: OColors.fontColor)),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "${itm.userInfo.username}'s Chat",
                style: header12,
              ),
            ),
            Container(
              // height: 50,

              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 4.8,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: OColors.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                children: [
                  TextFormField(
                    controller: _replybody,
                    style: TextStyle(color: OColors.white),
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: OColors.primary),
                      contentPadding: const EdgeInsets.only(
                          left: 20.0, right: 10.0, top: 5, bottom: 5),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: personProfileClipOval(
                          context,
                          itm.userInfo.avater!,
                          api + itm.userInfo.urlAvatar!,
                          const SizedBox.shrink(),
                          18,
                          45,
                          45,
                          Colors.grey,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            replyChat(itm);
                            _replybody.text = '';
                            textfield = true;
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.send,
                            color: OColors.primary,
                          )),
                      // suffixIcon: Icon(Icons.send_rounded),
                      hintText: 'Type here..',

                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: OColors.primary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: OColors.primary,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: OColors.primary,
                            width: 1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13.0))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // actions: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       noButton,
      //       yesButton,
      //     ],
      //   ),
      // ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        textfield = true;
        return alert;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
