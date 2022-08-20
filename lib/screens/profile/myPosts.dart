import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/post/post.dart';
import '../../model/post/sherekoModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../chats.dart';

class MyPosts extends StatefulWidget {
  final User user;
  const MyPosts({Key? key, required this.user}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final Preferences _preferences = Preferences();

  String token = '';
  List<SherekooModel> post = [];

  @override
  void initState() {
    PaintingBinding.instance.imageCache.clear();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        print('Need to See widget.user.id');
        print(widget.user.id);
        if (widget.user.id.isNotEmpty) {
          getPost(widget.user.id);
        }
      });
    });
    super.initState();
  }

  Future getPost(id) async {
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
    ).getPostByUserId(token, urlGetSherekooByUid, id).then((value) {
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
    return StaggeredGridView.countBuilder(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: post.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostChats(
                            postId: post[index].pId,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Stack(clipBehavior: Clip.hardEdge, children: [
                    Center(
                      child: Container(
                          child: post[index].vedeo != ''
                              ?

                              //  Image.network(
                              //     api +
                              //         'public/uploads/' +
                              //         post[index].username +
                              //         '/posts/' +
                              //         post[index].vedeo,
                              //     fit: BoxFit.cover,
                              //     errorBuilder: (context, error, stackTrace) {
                              //       return Image.asset('assets/logo/noimage.pgn',
                              //           fit: BoxFit.fitWidth);
                              //     },
                              //   )

                              FadeInImage(
                                  image: NetworkImage(api +
                                      'public/uploads/' +
                                      post[index].username +
                                      '/posts/' +
                                      post[index].vedeo),
                                  fadeInDuration:
                                      const Duration(milliseconds: 100),
                                  placeholder: const AssetImage(
                                      'assets/logo/noimage.png'),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/logo/noimage.png',
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                )
                              : const SizedBox(height: 1)),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.only(top: 109),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 3.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black45.withOpacity(.8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  post[index].body,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return const StaggeredTile.fit(2);
        });
  }
}
