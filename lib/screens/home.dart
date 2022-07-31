// ignore_for_file: unnecessary_new, prefer_final_fields

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/postWidgets/post_template.dart';
import '../model/ceremony/allCeremony.dart';
import '../model/ceremony/ceremonyModel.dart';
import '../model/allData.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../model/profileMode.dart';
import '../util/Preferences.dart';
import '../util/util.dart';
import '../widgets/navWidget/bttmNav.dart';
import '../widgets/navWidget/bottom_toolbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Preferences _preferences = Preferences();
  String token = '';

  final _controller = PageController();

  User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '');

  String avata = '';
  List<SherekooModel> post = [];
  List<CeremonyModel> ceremonyLIve = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
        getPost();
        getAllCeremony();
      });
    });
    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  getPost() async {
    Post(
      payload: [],
      status: 0,
      pId: '',
      avater: '',
      body: '',
      ceremonyId: '',
      createdBy: '',
      username: '',
      vedeo: '',
    ).get(token, urlGetSherekoo).then((value) {
      setState(() {
        post = value.payload
            .map<SherekooModel>((e) => SherekooModel.fromJson(e))
            .toList();
      });
    });
  }

  getAllCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .getDayCeremony(token, urlGetDayCeremony, 'Today')
        .then((value) {
      setState(() {
        ceremonyLIve = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView(
                controller: _controller,
                scrollDirection: Axis.vertical,
                children: List.generate(post.length, (index) {
                  return PostTemplate(
                      postId: post[index].pId,
                      avater: post[index].avater,
                      numberOfComments: post[index].commentNumber,
                      numberOfLikes: '765',
                      numberOfShere: '234',
                      userId: post[index].userId,
                      username: post[index].username,
                      videoDescription: post[index].body,
                      ceremonyId: post[index].ceremonyId,
                      postVedeo: post[index].vedeo,
                      filterBck: Positioned.fill(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 10.0,
                            sigmaY: 10.0,
                          ),
                          child: post[index].vedeo != ''
                              ? Image.network(
                                  api +
                                      'public/uploads/' +
                                      post[index].username +
                                      '/posts/' +
                                      post[index].vedeo,
                                  // height: 400,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(height: 1),
                        ),
                      ),
                      userPost: Center(
                        child: Container(
                            child: post[index].vedeo != ''
                                ? Image.network(
                                    api +
                                        'public/uploads/' +
                                        post[index].username +
                                        '/posts/' +
                                        post[index].vedeo,
                                    fit: BoxFit.contain,
                                  )
                                : const SizedBox(height: 1)),
                      ));
                })),
            Positioned(
                top: 25,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 3, bottom: 3),
                      child: Text(
                        'ShareKo',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
          ],
        ),

        // Bottom Section
        bottomNavigationBar: const BttmNav());
  }
}
