import 'dart:async';
import 'package:flutter/material.dart';

import '../util/colors.dart';

class LiveBorder extends StatefulWidget {
  final Widget child;
  const LiveBorder({Key? key, required this.child}) : super(key: key);

  @override
  State<LiveBorder> createState() => _LiveBorderState();
}

class _LiveBorderState extends State<LiveBorder> {
  var counter = 0;

  List<Color> get getColorsList => [
        const Color(0xFF006E7F),
        const Color(0xFFF8CB2E),
        const Color(0xFFEE5007),
        const Color(0xFFB22727),
      ]..shuffle();

  List<Alignment> get getAlignments => [
        Alignment.bottomLeft,
        Alignment.bottomRight,
        Alignment.topRight,
        Alignment.topLeft,
      ];

  _startBgColorAnimationTimer() {
    ///Animating for the first time.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counter++;
      setState(() {});
    });

    const interval = Duration(seconds: 4);
    Timer.periodic(
      interval,
      (Timer timer) {
        counter++;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startBgColorAnimationTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: getAlignments[counter % getAlignments.length],
                end: getAlignments[(counter + 2) % getAlignments.length],
                colors: getColorsList,
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(50)),
          duration: const Duration(seconds: 4),
          child: Padding(
            padding: const EdgeInsets.all(3.5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    color: OColors.secondary,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: widget.child))),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 4,
          width: 49,
          height: 15,
          child: Container(
              padding: const EdgeInsets.only(left: 3.5, right: 3.5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      OColors.primary2,
                      OColors.primary,
                      Colors.red,
                    ],
                  ),
                  color: OColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  Icon(Icons.live_tv, size: 13, color: OColors.fontColor),
                  const SizedBox(width: 5),
                  Text(
                    'live',
                    style: header10,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
