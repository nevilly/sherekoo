import 'package:flutter/material.dart';

import '../model/ceremony/ceremonyModel.dart';
import '../model/chats/chatsModel.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../screens/detailScreen/livePost.dart';
import '../screens/uploadScreens/uploadSherekoo.dart';
import '../util/Preferences.dart';
import '../util/util.dart';

class TabA extends StatefulWidget {
  final CeremonyModel ceremony;
  const TabA({Key? key, required this.ceremony}) : super(key: key);

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
    ).getPostByCeremonyId(token, urlGetSherekooByCeremonyId).then((value) {
      // print('check Payload feeds');
      // print(value.payload);
      setState(() {
        post = value.payload
            .map<SherekooModel>((e) => SherekooModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView.separated(
          separatorBuilder: (context, child) => const Divider(
            height: 5,
          ),
          padding: const EdgeInsets.all(0.0),
          itemCount: post.length,
          itemBuilder: (context, i) {
            return LiveePost(post: post[i]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SherekooUpload(
                          crm: widget.ceremony,
                          from: 'Ceremony',
                        )));
          },
          child: const Icon(Icons.upload, color: Colors.white),
          backgroundColor: Colors.red),
    );
  }
}
