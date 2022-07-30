import 'package:flutter/material.dart';

import '../model/ceremony/ceremonyModel.dart';
import '../model/chats/chatsModel.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../screens/uploadScreens/livePost.dart';
import '../util/Preferences.dart';
import '../util/util.dart';
import 'cermChats_widgets.dart';

class TabA extends StatefulWidget {
  final String getcurrentUser;
  final CeremonyModel ceremony;
  const TabA({Key? key, required this.ceremony, required this.getcurrentUser})
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
        child: Expanded(
          child: ListView.separated(
            separatorBuilder: (context, child) => const Divider(
              height: 5,
            ),
            padding: const EdgeInsets.all(0.0),
            itemCount: post.length,
            itemBuilder: (context, i) {
              return SizedBox(
                  // height: 400,
                  width: double.infinity,
                  // color:
                  //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              //header

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(api +
                                              'public/uploads/' +
                                              post[i].username +
                                              '/profile/' +
                                              post[i].avater),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(post[i].username,
                                            style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(post[i].createdDate),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //body Photo
                              Center(
                                child: Container(
                                    child: post[i].vedeo != ''
                                        ? Image.network(
                                            api +
                                                'public/uploads/' +
                                                post[i].username +
                                                '/posts/' +
                                                post[i].vedeo,
                                            fit: BoxFit.contain,
                                          )
                                        : const SizedBox(height: 1)),
                              ),

                              //body Message
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: post[i].body,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0,
                                              color: Colors.grey)),
                                      // TextSpan(
                                      //     text: ' @koosafi-MrsMwakanyaga0xsd',
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontStyle: FontStyle.italic,
                                      //         fontSize: 12.0,
                                      //         color: Colors.grey)),
                                    ])),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //footer

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.reply,
                                            size: 20.0,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('234'),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.favorite,
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text('139'),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        oneButtonPressed(post[i]);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.send,
                                              size: 20.0,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Comments',
                                              style: TextStyle(
                                                  letterSpacing: .1,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LivePostUpload(
                          ceremony: widget.ceremony,
                          getcurrentUser: widget.getcurrentUser,
                        )));
          },
          child: const Icon(Icons.upload, color: Colors.white),
          backgroundColor: Colors.red),
    );
  }

  void oneButtonPressed(p) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 560,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: CeremonyChats(post: p)),
          );
        });
  }
}
