import 'package:flutter/material.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../model/post/post.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/cermChats_widgets.dart';
import '../homNav.dart';

class LiveePost extends StatefulWidget {
  final SherekooModel post;

  final CeremonyModel crm; // must be remove after knowing Provider way
  const LiveePost({
    Key? key,
    required this.post,
    required this.crm,
  }) : super(key: key);

  @override
  State<LiveePost> createState() => _LiveePostState();
}

class _LiveePostState extends State<LiveePost> {
  int isLike = 0;
  int totalLikes = 0;
  int totalShare = 0;

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      token = value;
    });

    if (widget.post.totalLikes != '') {
      totalLikes = int.parse(widget.post.totalLikes!);
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
            payload: [],
            hashTag: '')
        .share(token, urlpostShare, 'Post')
        .then((value) {
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
            payload: [],
            hashTag: '')
        .remove(token, urlremoveSherekoo)
        .then((value) {
      if (value.status == 200) {
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
            payload: [],
            hashTag: '')
        .likes(token, urlpostLikes, isLike.toString())
        .then((value) {
      if (value.status == 200) {
        if (value.payload == 'removed') {
          setState(() {
            isLike--;
            totalLikes--;
            widget.post.isLike = isLike.toString();

            widget.post.totalLikes = totalLikes.toString();
            totalLikes = int.parse(widget.post.totalLikes!);
          });
        } else if (value.payload == 'added') {
          setState(() {
            isLike++;
            totalLikes++;
            widget.post.isLike = isLike.toString();
            widget.post.totalLikes = totalLikes.toString();
            totalLikes = int.parse(widget.post.totalLikes!);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        color: OColors.darGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomeNav(
                                    user: User(
                                        id: widget.post.creatorInfo.id,
                                        username:
                                            widget.post.creatorInfo.username,
                                        avater: widget.post.creatorInfo.avater,
                                        phoneNo: '',
                                        role: '',
                                        gender: '',
                                        email: '',
                                        firstname: '',
                                        lastname: '',
                                        isCurrentUser: '',
                                        address: '',
                                        bio: '',
                                        meritalStatus: '',
                                        totalPost: '',
                                        isCurrentBsnAdmin: '',
                                        isCurrentCrmAdmin: '',
                                        totalFollowers: '',
                                        totalFollowing: '',
                                        totalLikes: ''),
                                    getIndex: 4,
                                  )));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                              '${api}public/uploads/${widget.post.creatorInfo.username}/profile/${widget.post.creatorInfo.avater}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.post.creatorInfo.username!,
                                  style: TextStyle(
                                    // fontSize: 16,
                                    color: OColors.fontColor,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(widget.post.createdDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1.0),
                    child: Container(
                        width: 80,
                        height: 26,
                        margin: const EdgeInsets.only(top: 9),
                        decoration: BoxDecoration(
                            border: Border.all(color: OColors.primary),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text('follow',
                              style: TextStyle(
                                fontSize: 15,
                                color: OColors.primary,
                              )),
                        )),
                  ),
                ],
              ),
            ),

            //Hash Tags
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text('#relative',
                  style: TextStyle(fontSize: 12, color: OColors.primary)),
            ),
            //body Message
            Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, left: 4, right: 5.0, bottom: 13.0),
              child: Text(widget.post.body,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: OColors.fontColor)),
            ),
            //body Photo
            Center(
              child: Container(
                  child: widget.post.vedeo != ''
                      ? Image.network(
                          '${api}public/uploads/${widget.post.creatorInfo.username}/posts/${widget.post.vedeo}',
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(height: 1)),
            ),

            //footer
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      // margin: const EdgeInsets.only(left: 2.0),
                      padding: const EdgeInsets.all(2.0),
                      child: footerIcon(Icons.more_vert, 20, OColors.primary),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          share();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.reply,
                                size: 20.0,
                                color: OColors.primary,
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                totalShare.toString(),
                                style: ef,
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
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              isLike == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(10),
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
                                        size: 20.0,
                                        color: OColors.primary,
                                      ),
                                    ),
                              const SizedBox(
                                width: 2.0,
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
                          // margin: const EdgeInsets.only(right: 14.0),
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.message,
                                size: 20.0,
                                color: OColors.primary,
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                '23',
                                style: header13,
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
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(1),
      backgroundColor: OColors.secondary,
      title: Text('Post Settings',
          style:
              TextStyle(color: OColors.fontColor, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.post.isPostAdmin == 'true'
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
