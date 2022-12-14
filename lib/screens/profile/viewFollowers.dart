import 'package:flutter/material.dart';

import '../../model/follow/followCall.dart';
import '../../model/follow/followModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class ViewFollowers extends StatefulWidget {
  final String typ;
  final String usrId;
  final bool isCurrent;
  const ViewFollowers(
      {Key? key,
      required this.typ,
      required this.usrId,
      required this.isCurrent})
      : super(key: key);

  @override
  State<ViewFollowers> createState() => _ViewFollowersState();
}

class _ViewFollowersState extends State<ViewFollowers> {
  List<FollowModel> follow = [];
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        widget.typ == 'followers'
            ? followSyst(widget.usrId, urlGetFollowers, widget.typ)
            : followSyst(widget.usrId, urlGetFollowing, widget.typ);
      });
    });

    super.initState();
  }

  followSyst(id, urlDr, String typ) {
    FollowCall(payload: [], status: 0)
        .getfollow(token, urlDr, id, typ)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          follow = value.payload
              .map<FollowModel>((e) => FollowModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  unfollowSyst(FollowModel itm, urlDr, String typ) {
    FollowCall(payload: [], status: 0)
        .follow(token, urlDr, itm.id)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          follow.removeWhere((element) => element.id == itm.id);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: Text(widget.typ),
      ),
      body: ListView.builder(
        itemCount: follow.length,
        itemBuilder: (BuildContext context, int index) {
          final itm = follow[index];
          final avater =
              '${api}public/uploads/${itm.follosInfo.username!}/profile/${itm.follosInfo.avater!}';
          return GestureDetector(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.only(top: 4),
                child: ListTile(
                  tileColor: OColors.darGrey,
                  leading: personProfileClipOval(
                      context,
                      itm.follosInfo.avater!,
                      avater,
                      const SizedBox.shrink(),
                      25,
                      45,
                      45,
                      prmry),
                  title: Text(
                    itm.follosInfo.username!,
                    style: header14,
                  ),
                  subtitle: Text(
                    itm.followType,
                    style: header12,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      unfollowSyst(itm, urlUnFollow, itm.followType);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (itm.followType == 'followers' &&
                            widget.isCurrent == true)
                          Text(
                            'Unfollow',
                            style: header13.copyWith(color: prmry),
                          ),
                        if (itm.followType == 'following' &&
                            widget.isCurrent == true)
                          Text(
                            'Unfollow',
                            style: header13.copyWith(color: prmry),
                          ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
