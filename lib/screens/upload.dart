import 'dart:async';

import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  static double _height = 100, _one = -_height, _two = _height;
  final double _oneFixed = -_height;
  final double _twoFixed = _height;
  final Duration _duration = const Duration(milliseconds: 5);
  bool _top = false, _bottom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Upload Life'),
      // ),
      body: SizedBox(
        height: _height,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              height: _height,
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dy >= 0) {
                    _toggleTop();
                  } else {
                    _toggleBottom();
                  }
                },
                child: _myContainer(
                  color: Colors.yellow[800],
                  text: "Old Container",
                  child1: IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: _toggleTop,
                  ),
                  child2: IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: _toggleBottom,
                  ),
                ),
              ),
            ),
          
            Positioned(
              left: 0,
              right: 0,
              top: _one,
              height: _height,
              child: GestureDetector(
                onTap: _toggleTop,
                onPanEnd: (details) => _toggleTop(),
                onPanUpdate: (details) {
                  _one += details.delta.dy;
                  if (_one >= 0) _one = 0;
                  if (_one <= _oneFixed) _one = _oneFixed;
                  setState(() {});
                },
                child: _myContainer(
                  color: _one >= _oneFixed + 1
                      ? Colors.red[800]
                      : Colors.transparent,
                  text: "Upper Container",
                ),
              ),
            ),
            
            Positioned(
              left: 0,
              right: 0,
              top: _two,
              height: _height,
              child: GestureDetector(
                onTap: _toggleBottom,
                onPanEnd: (details) => _toggleBottom(),
                onPanUpdate: (details) {
                  _two += details.delta.dy;
                  if (_two <= 0) _two = 0;
                  if (_two >= _twoFixed) _two = _twoFixed;
                  setState(() {});
                },
                child: _myContainer(
                  color: _two <= _twoFixed - 1
                      ? Colors.green[800]
                      : Colors.transparent,
                  text: "Bottom Container",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTop() {
    _top = !_top;
    Timer.periodic(_duration, (timer) {
      if (_top) {
        _one += 2;
      } else {
        _one -= 2;
      }

      if (_one >= 0) {
        _one = 0;
        timer.cancel();
      }
      if (_one <= _oneFixed) {
        _one = _oneFixed;
        timer.cancel();
      }
      setState(() {});
    });
  }

  void _toggleBottom() {
    _bottom = !_bottom;
    Timer.periodic(_duration, (timer) {
      if (_bottom) {
        _two -= 2;
      } else {
        _two += 2;
      }

      if (_two <= 0) {
        _two = 0;
        timer.cancel();
      }
      if (_two >= _twoFixed) {
        _two = _twoFixed;
        timer.cancel();
      }
      setState(() {});
    });
  }

  Widget _myContainer(
      {Color? color,
      required String text,
      Widget? child1,
      Widget? child2,
      onTap}) {
    Widget child;
    if (child1 == null || child2 == null) {
      child = Text(text,
          style: const TextStyle(
              fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold));
    } else {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          child1,
          child2,
        ],
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}


//inspired By
//   https://stackoverflow.com/questions/57149002/flutter-sliding-container-into-another-container-to-show-or-hide-some-icons-like
//   https://stackoverflow.com/questions/65282103/i-have-animated-right-and-left-scroll-effect-for-list-items-in-flutter-but-the-w