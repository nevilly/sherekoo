import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../util/util.dart';

class DisplayVedeo extends StatefulWidget {
  final String vedeo;
  final String username;

  const DisplayVedeo({
    Key? key,
    required this.vedeo,
    required this.username,
  }) : super(key: key);

  @override
  State<DisplayVedeo> createState() => _DisplayVedeoState();
}

class _DisplayVedeoState extends State<DisplayVedeo> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // if (widget.vedeo.endsWith('.mp4')) {
    //   print(widget.vedeo.endsWith('.mp4'));
    //   print(widget.vedeo);
    //   getVideo(widget.vedeo);
    // }
    super.initState();
  }

  String? _video;

  Future getVideo(_v) async {
    File v;

    if (_v != null) {
      v = File(_v.path);
      _videoPlayerController = VideoPlayerController.file(v)
        ..initialize().then((_) {
          setState(() {
            _video = _v.path;
          });
          _videoPlayerController.play();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: widget.vedeo.endsWith('.jpg')
            ? Image.network(
                api +
                    'public/uploads/' +
                    widget.username +
                    '/posts/' +
                    widget.vedeo,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
            : Text('null Vedo'),
      ),
    );
  }
}
