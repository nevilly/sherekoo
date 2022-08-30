// ignore_for_file: unnecessary_new, prefer_final_fields, unnecessary_brace_in_string_interps

import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/post/post.dart';
import '../model/post/sherekoModel.dart';
import '../util/Preferences.dart';
import '../util/util.dart';
import '../widgets/postWidgets/post_template.dart';
import '../widgets/postWidgets/displayPost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Preferences _preferences = Preferences();
  String token = '';
  int page = 1, limit = 3, offset = 0;

  final _controller = PageController();

  String avata = '';
  List<SherekooModel> post = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getPost(offset: page, limit: limit);
      });
    });

    super.initState();
  }

  onPage(int pag) {
    // print("Pages");
    // print(pag);
    if (page > pag) {
      page--;
    } else {
      page++;
    }
    //page = pag;
    // print('post Length :');
    // print(post.length);
    if (pag == post.length - 1) {
      offset = page;
      //print("Select * from posts order by id limit ${offset}, ${limit}");
      getPost(offset: offset, limit: limit);
    }
  }

  getPost({int? offset, int? limit}) async {
    String d = offset != null && limit != null ? "/${offset}/${limit}" : '';

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
    ).get(token, urlGetSherekoo + d).then((value) {
      if (value.status == 200) {
        setState(() {
          post.addAll(value.payload
              .map<SherekooModel>((e) => SherekooModel.fromJson(e))
              .toList());
        });
      }
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
            onPageChanged: onPage,
            children: List.generate(post.length, (index) {
              return PostTemplate(
                  postId: post[index].pId,
                  avater: post[index].avater,
                  numberOfComments: post[index].commentNumber,
                  numberOfLikes: post[index].totalLikes,
                  isLike: post[index].isLike,
                  numberOfShere: post[index].totalShare,
                  userId: post[index].userId,
                  username: post[index].username,
                  videoDescription: post[index].body,
                  ceremonyId: post[index].ceremonyId,
                  cImage: post[index].cImage,
                  crmUsername: post[index].crmUsername,
                  crmYoutubeLink: post[index].crmYoutubeLink,
                  postVedeo: post[index].vedeo,
                  filterBck: Positioned.fill(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: post[index].vedeo.endsWith('.jpg') &&
                              post[index].vedeo.isNotEmpty
                          ? Image.network(
                              '${api}public/uploads/${post[index].username}/posts/${post[index].vedeo}',
                              // height: 400,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              'assets/logo/bkg.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  userPost: DisplayVedeo(
                    username: post[index].username,
                    vedeo: post[index].vedeo,
                  ));
            }),
          ),
          Positioned(
              top: 25,
              left: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
