import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../util/util.dart';

class DisplayVedeoChat extends StatefulWidget {
  final String vedeo;
  final String username;
  final String mediaUrl;

  const DisplayVedeoChat(
      {Key? key,
      required this.vedeo,
      required this.username,
      required this.mediaUrl})
      : super(key: key);

  @override
  State<DisplayVedeoChat> createState() => _DisplayVedeoChatState();
}

class _DisplayVedeoChatState extends State<DisplayVedeoChat> {
  VideoPlayerController? controller;

  @override
  void initState() {
    setState(() {
      if (widget.vedeo.endsWith('.mp4')) {
        loadVideoPlayer();
      }
    });

    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
      api + widget.mediaUrl,
    );
    controller!.addListener(() {
      setState(() {});
    });
    controller!.initialize().then((value) {
      setState(() {
        controller!.setVolume(0);
        controller!.play();
        controller!.setLooping(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: widget.vedeo.endsWith('.jpg')
            ? Image.network(
                '${api}${widget.mediaUrl}',
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  controller!.value.isInitialized
                      ? Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            AspectRatio(
                              aspectRatio: controller!.value.aspectRatio,
                              child: VideoPlayer(controller!),
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller!.value.volume == 0) {
                                    //check if volume is already set to 0 (i.e mute)
                                    controller!.setVolume(1.0);
                                  } else {
                                    //check if volume is already set to 1 (i.e unmute)
                                    controller!.setVolume(0.0);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: controller!.value.volume == 0
                                      ? const Icon(
                                          Icons.volume_off_outlined,
                                          size: 20,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.volume_up_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                ))
                          ],
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.vedeo.endsWith('.mp4')) {
      controller!.pause();
      controller!.setVolume(0);
      controller!.dispose();
    }
    super.dispose();
  }
}
