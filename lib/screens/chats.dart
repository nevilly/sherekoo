import 'dart:async';
import 'package:flutter/material.dart';

import '../model/chats/chatPost.dart';
import '../model/chats/chatsModel.dart';
import '../model/profileMode.dart';
import '../util/Preferences.dart';
import '../util/util.dart';
import 'profile/profile.dart';

class PostChats extends StatefulWidget {
  final String postId;

  const PostChats({Key? key, required this.postId}) : super(key: key);

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
    backgroundTask();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getPost();
      });
    });

    postid = widget.postId;
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
      setState(() {
        chats = value.payload
            .map<ChatsModel>((e) => ChatsModel.fromJson(e))
            .toList();
      });
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
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 3.0, left: 15, right: 5),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        chats[index].avater != ''
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Profile(
                                                user: User(
                                                    id: chats[index].userId,
                                                    username:
                                                        chats[index].username,
                                                    avater: chats[index].avater,
                                                    phoneNo: '',
                                                    role: '',
                                                    gender: '',
                                                    email: '',
                                                    firstname: '',
                                                    lastname: ''),
                                              )));
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      radius: 10.0,
                                      backgroundImage: NetworkImage(
                                        api +
                                            'public/uploads/' +
                                            chats[index].username +
                                            '/profile/' +
                                            chats[index].avater,
                                        // height: 400,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 15,
                                child: ClipOval(
                                    child: Image(
                                  image:
                                      AssetImage('assets/profile/profile.jpg'),
                                  fit: BoxFit.cover,
                                ))),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //username & time
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(chats[index].username,
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(chats[index].date),
                                  ),
                                ],
                              ),

                              //body Message
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(chats[index].body,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //Textfield..
          SizedBox(
            // height: 50,
            height: size.height * 0.1,
            width: size.width * 4.8,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 15),
              child: Stack(
                children: [
                  TextFormField(
                    controller: _body,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5, bottom: 5),
                      prefixIcon: const Icon(Icons.tag_faces_sharp),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            post();
                            _body.text = '';
                          },
                          child: const Icon(Icons.send)),
                      // suffixIcon: Icon(Icons.send_rounded),
                      hintText: 'Type here..',

                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
