import 'package:flutter/material.dart';

import '../../util/colors.dart';

class LikeLife extends StatefulWidget {
  final int isLike;
  final int totalLikes;
  const LikeLife({
    Key? key,
    required this.isLike,
    required this.totalLikes,
  }) : super(key: key);

  @override
  State<LikeLife> createState() => _LikeLifeState();
}

class _LikeLifeState extends State<LikeLife>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: 35,
      height: 55,
      decoration: BoxDecoration(
          color: Colors.black54.withOpacity(.5),
          borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Column(
            children: [
              widget.isLike == 0
                  ? Icon(
                      Icons.favorite,
                      size: 18.0,
                      color: OColors.fontColor,
                    )
                  : Icon(
                      Icons.favorite,
                      size: 18.0,
                      color: OColors.primary,
                    ),
              const SizedBox(
                height: 3,
              ),
              Text(
                widget.totalLikes.toString(),
                style: TextStyle(fontSize: 12, color: OColors.fontColor),
              ),
              // const SizedBox(
              //   height: 8.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive

    super.updateKeepAlive();
  }
}
