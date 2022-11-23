import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sherekoo/screens/homNav.dart';

import '../model/chats/chatPost.dart';
import '../model/chats/chatsModel.dart';
import '../model/userModel.dart';
import '../util/Preferences.dart';
import '../util/colors.dart';
import '../util/func.dart';
import '../util/util.dart';
import 'settingScreen/chatsSetting.dart';

class PostChats extends StatefulWidget {
  final String postId;
  final String chatsNo;

  const PostChats({Key? key, required this.postId, required this.chatsNo})
      : super(key: key);

  @override
  State<PostChats> createState() => _PostChatsState();
}

class _PostChatsState extends State<PostChats> {
  final Preferences _preferences = Preferences();
  String token = '';
  String postid = '';

  List<ChatsModel> chats = [];
  final TextEditingController _body = TextEditingController();
  int id = 0;

  @override
  void initState() {
    _preferences.init();
    postid = widget.postId;
    backgroundTask();

    _preferences.get('token').then((value) {
      setState(() {
        token = value;
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
    // print("Hello World ${ID}");
    getPost();
    id++;

    return timer;
  }

  getPost() async {
    PostAllChats(
      payload: [],
      status: 0,
      body: '',
      postId: postid,
      userId: '',
    ).get(token, urlGetChats).then((value) {
      if (mounted) {
        setState(() {
          print(value.payload);
          chats = value.payload
              .map<ChatsModel>((e) => ChatsModel.fromJson(e))
              .toList();
        });
      }
    });
    id++;
  }

  Future<void> post() async {
    if (_body.text != '') {
      PostAllChats(
        postId: widget.postId,
        userId: '',
        body: _body.text,
        status: 0,
        payload: [],
      ).post(token, urlPostChats).then((value) {
        setState(() {});
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'body Emotyyy',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: Text('${widget.chatsNo}  Comments',
            style: TextStyle(
                // fontSize: 16,
                color: OColors.fontColor,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        // leading: InkWell(
        //   onTap: ()=> HomeNav(getIndex: 2, user: User()),
        //   child:Icon(Icons.arrow_back)
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, index) {
                final itm = chats[index];
                final urlProfile =
                    '${api}public/uploads/${itm.userInfo.username}/profile/';
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 10.0, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeNav(
                                              user: User(
                                                  id: itm.userId,
                                                  username:
                                                      itm.userInfo.username,
                                                  avater: chats[index]
                                                      .userInfo
                                                      .avater,
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
                                urlProfile + itm.userInfo.avater!,
                                const SizedBox.shrink(),
                                15,
                                35,
                                35,
                                Colors.grey,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(chats[index].userInfo.username!,
                                    style: TextStyle(
                                      color: OColors.fontColor,
                                      fontWeight: FontWeight.w600,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChatSettings(
                                                  chat: chats[index],
                                                  fromScrn: 'homeChats',
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(
                                          Icons.more_horiz_rounded,
                                          size: 15,
                                          color: OColors.fontColor,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //body Message
                      Container(
                        padding:
                            const EdgeInsets.only(top: 1.0, left: 55, right: 8),
                        alignment: Alignment.topLeft,
                        child: Text(chats[index].body!,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: OColors.fontColor,
                            )),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, left: 40, right: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border_outlined,
                                    color: OColors.primary,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('212',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: OColors.fontColor,
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(chats[index].date,
                                style: TextStyle(
                                  color: OColors.fontColor,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          //Textfield..
          Container(
            // height: 50,

            height: size.height * 0.1,
            width: size.width * 4.8,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: OColors.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Stack(
              children: [
                TextFormField(
                  controller: _body,
                  maxLines: null,
                  expands: true,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: OColors.primary),
                    contentPadding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5, bottom: 5),
                    prefixIcon:
                        Icon(Icons.tag_faces_sharp, color: OColors.primary),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          post();
                          _body.text = '';
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
