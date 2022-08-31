import 'package:flutter/material.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../model/post/post.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/cermChats_widgets.dart';

class LiveePost extends StatefulWidget {
  final SherekooModel post;
  final User user;
  final CeremonyModel crm; // must be remove after knowing Provider way
  const LiveePost(
      {Key? key, required this.post, required this.crm, required this.user})
      : super(key: key);

  @override
  State<LiveePost> createState() => _LiveePostState();
}

class _LiveePostState extends State<LiveePost> {
  final Preferences _preferences = Preferences();

  String token = '';
  int isLike = 0;
  int totalLikes = 0;
  int totalShare = 0;

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      token = value;
    });

    if (widget.post.totalLikes != '') {
      totalLikes = int.parse(widget.post.totalLikes);
    } else {
      totalLikes = 0;
    }

    if (widget.post.totalShare != '') {
      totalShare = int.parse(widget.post.totalShare);
    } else {
      totalShare = 0;
    }

    isLike = int.parse(widget.post.isLike);

    super.initState();
  }

  share() async {
    Post(
        pId: widget.post.pId,
        createdBy: '',
        body: '',
        vedeo: '',
        ceremonyId: '',
        username: '',
        avater: '',
        status: 0,
        payload: []).share(token, urlpostShare, 'Post').then((value) {
      if (value.status == 200) {
        setState(() {
          totalShare++;
        });
      }
      // make App to remember likes, or store
    });
  }

  remove() async {
    Post(
        pId: widget.post.pId,
        createdBy: '',
        body: '',
        vedeo: '',
        ceremonyId: '',
        username: '',
        avater: '',
        status: 0,
        payload: []).remove(token, urlremoveSherekoo).then((value) {
      if (value.status == 200) {
        print('am hereee');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Livee(
                      ceremony: widget.crm,
                    )));
      }
      // make App to remember likes, or store
    });
  }

  onLikeButtonTapped() async {
    Post(
            pId: widget.post.pId,
            createdBy: '',
            body: '',
            vedeo: '',
            ceremonyId: '',
            username: '',
            avater: '',
            status: 0,
            payload: [])
        .likes(token, urlpostLikes, isLike.toString())
        .then((value) {
      if (value.status == 200) {
        if (value.payload == 'removed') {
          setState(() {
            isLike--;
            totalLikes--;
          });
        } else if (value.payload == 'added') {
          setState(() {
            isLike++;
            totalLikes++;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30.0,
        ),
        //header
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          '${api}public/uploads/${widget.post.username}/profile/${widget.post.avater}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(widget.post.username,
                        style: TextStyle(
                          color: OColors.fontColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(widget.post.createdDate,
                    style: TextStyle(
                      color: OColors.fontColor,
                    )),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 5,
        ),

        //body Photo
        Center(
          child: Container(
              child: widget.post.vedeo != ''
                  ? Image.network(
                      '${api}public/uploads/${widget.post.username}/posts/${widget.post.vedeo}',
                      fit: BoxFit.contain,
                    )
                  : const SizedBox(height: 1)),
        ),

        //body Message
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 8, right: 5.0),
          child: Text(widget.post.body,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: OColors.fontColor)),
        ),

        //footer
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: Container(
                      color: Colors.green,
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.all(8.0),
                      child: footerIcon(Icons.more_vert, 20, OColors.primary),
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.more_vert)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      share();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.reply,
                            size: 18.0,
                            color: OColors.primary,
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            totalShare.toString(),
                            style: TextStyle(color: OColors.fontColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onLikeButtonTapped();
                    },
                    child: Container(
                      // color: Colors.green,
                      margin: const EdgeInsets.only(left: 4, right: 8),
                      child: Column(
                        children: [
                          isLike == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18.0,
                                    color: OColors.primary,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                    color: OColors.primary,
                                  ),
                                ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            totalLikes.toString(),
                            style: TextStyle(color: OColors.fontColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      oneButtonPressed(widget.post);
                    },
                    child: Container(
                      // color: Colors.yellow,
                      margin: const EdgeInsets.only(right: 14.0),
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Column(
                        children: [
                          Icon(
                            Icons.send_outlined,
                            size: 18.0,
                            color: OColors.primary,
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            '23',
                            style: TextStyle(
                                fontSize: 13, color: OColors.fontColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Icon footerIcon(IconData icon, double size, Color color) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }

  void oneButtonPressed(p) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: OColors.secondary,
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

  // PopUp Widget
  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(1),
      backgroundColor: OColors.secondary,
      title: Text('Post Settings',
          style:
              TextStyle(color: OColors.fontColor, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.post.userId == widget.user.id
              ? ListTile(
                  title: Text('Delete Post',
                      style: TextStyle(color: OColors.fontColor)),
                  onTap: () {
                    remove();
                  },
                )
              : const SizedBox(),
          ListTile(
            title:
                Text('see only me', style: TextStyle(color: OColors.fontColor)),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => EditProfile(
              //               data: currentUser,
              //             )));
            },
          ),
          ListTile(
            title: Text('see only fallow People',
                style: TextStyle(color: OColors.fontColor)),
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => EditProfile(
              //               data: currentUser,
              //             )));
            },
          ),
        ],
      ),
    );
  }
}
