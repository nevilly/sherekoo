import 'package:flutter/material.dart';

import '../model/ceremony/ceremonyModel.dart';
import '../model/chats/chatsModel.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../model/userModel.dart';
import '../screens/detailScreen/livePost.dart';
import '../util/Preferences.dart';
import '../util/util.dart';

class TabA extends StatefulWidget {
  final CeremonyModel ceremony;
  final User user;
  const TabA({Key? key, required this.ceremony, required this.user})
      : super(key: key);

  @override
  State<TabA> createState() => _TabAState();
}

class _TabAState extends State<TabA> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<SherekooModel> post = [];
  List<ChatsModel> chats = [];

  @override
  void initState() {
    print(widget.ceremony.cId);
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getPost();
      });
    });
    super.initState();
  }

  getPost() async {
    Post(
      payload: [],
      status: 0,
      pId: '',
      avater: '',
      body: '',
      ceremonyId: widget.ceremony.cId,
      createdBy: '',
      username: '',
      vedeo: '',
      hashTag: '',
    ).getPostByCeremonyId(token, urlGetSherekooByCeremonyId).then((value) {
      if (value.status == 200) {
        setState(() {
          post = value.payload
              .map<SherekooModel>((e) => SherekooModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        separatorBuilder: (context, child) => const Divider(
          height: 5,
        ),
        padding: const EdgeInsets.all(0.0),
        itemCount: post.length,
        itemBuilder: (context, i) {
          return LiveePost(
            post: post[i],
            crm: widget.ceremony,
          );
        },
      ),
    );
  }
}
