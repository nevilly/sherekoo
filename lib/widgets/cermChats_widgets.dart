import 'dart:async';

import 'package:flutter/material.dart';

import '../model/chats/chatPost.dart';
import '../model/chats/chatsModel.dart';
import '../model/post/sherekoModel.dart';
import '../util/Preferences.dart';
import '../util/util.dart';

class CeremonyChats extends StatefulWidget {
  final SherekooModel post;
  const CeremonyChats({Key? key, required this.post}) : super(key: key);

  @override
  State<CeremonyChats> createState() => _CeremonyChatsState();
}

class _CeremonyChatsState extends State<CeremonyChats> {
  final Preferences _preferences = Preferences();
  String token = '';
  String postid = '';
  List<ChatsModel> chats = [];

  final TextEditingController _body = TextEditingController();
  int id = 0;

  @override
  void initState() {
    _preferences.init();
      postid = widget.post.pId;
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
      postId: widget.post.pId,
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
        postId: widget.post.pId,
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
          'Say Something',
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 5, right: 5),
                    child: Card(
                      child: Column(
                        children: [
                          //header

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 2, top: 5.0, bottom: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: chats[index].avater != ''
                                            ? CircleAvatar(
                                                radius: 12.0,
                                                backgroundImage: NetworkImage(
                                                  api +
                                                      'public/uploads/' +
                                                      chats[index].username +
                                                      '/profile/' +
                                                      chats[index].avater,
                                                  // height: 400,
                                                ),
                                              )
                                            : const CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                radius: 12,
                                                child: ClipOval(
                                                    child: Image(
                                                  image: AssetImage(
                                                      'assets/profile/profile.jpg'),
                                                  fit: BoxFit.cover,
                                                )))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, bottom: 8),
                                      child: Text(chats[index].username,
                                          style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    chats[index].date,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //body Message
                          Container(
                            margin: const EdgeInsets.only(
                                top: 1.0, left: 30.0, bottom: 6),
                            alignment: Alignment.topLeft,
                            child: Text(chats[index].body,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              // height: 50,
              height: size.height * 0.07,
              width: size.width * 2.8,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
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
                            left: 20.0, right: 20.0, top: 5, bottom: 3),
                        prefixIcon: const Icon(Icons.tag_faces_sharp),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              post();
                              _body.text = '';
                            },
                            child: const Icon(Icons.send)),
                        // suffixIcon: Icon(Icons.send_rounded),
                        hintText: 'Type here..',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
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
      ),
    );
  }
}
