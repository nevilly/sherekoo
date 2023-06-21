import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/post/post.dart';
import '../../model/post/sherekoModel.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/util.dart';
import '../../widgets/postWidgets/display-post-chats.dart';
import '../../widgets/postWidgets/displayPost.dart';
import '../chats.dart';

class MyPosts extends StatefulWidget {
  final User user;
  const MyPosts({Key? key, required this.user}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final _controller = ScrollController();
  int page = 0, limit = 10, offset = 0;
  bool bottom = false;
  List<SherekooModel> post = [];

  @override
  void initState() {
    super.initState();
    PaintingBinding.instance.imageCache.clear();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        if (widget.user.id!.isNotEmpty) {
          getPost(widget.user.id, offset, limit);
        }
      });
    });

    _controller.addListener(() {
      if (!bottom &&
          _controller.hasClients &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        onPage(page);
      }
    });
  }

  onPage(int pag) {
    if (mounted) {
      setState(() {
        if (page > pag) {
          page--;
        } else {
          page++;
        }
        offset = page * limit;
      });
    }

    // print("Select * from table where data=all limit $offset,$limit");
    //page = pag;
    // print('post Length :');

    getPost(widget.user.id, offset, limit);
    if (pag == post.length - 1) {
      //offset = page;
      //print("Select * from posts order by id limit ${offset}, ${limit}");
    }
  }

  getPost(id, int? offset, int? limit) {
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
      hashTag: '',
    )
        .getPostByUserId(token, urlGetSherekooByUid, id, offset, limit)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          // print(value.payload);
          post.addAll(value.payload
              .map<SherekooModel>((e) => SherekooModel.fromJson(e))
              .toList());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        controller: _controller,
        crossAxisSpacing: 1,
        mainAxisSpacing: 3,
        crossAxisCount: 6,
        shrinkWrap: true,
        itemCount: post.length,
        itemBuilder: (context, index) {
          final itm = post[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostChats(
                            post: itm,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Stack(clipBehavior: Clip.hardEdge, children: [
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29.0)),
                          child: DisplayVedeoChat(
                            mediaUrl: itm.mediaUrl,
                            username: itm.creatorInfo.username!,
                            vedeo: itm.vedeo,
                          )),
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
                              color: const Color.fromRGBO(0, 0, 0, 0.451)
                                  .withOpacity(.8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: OColors.primary,
                                      size: 13,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      itm.commentNumber!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
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
