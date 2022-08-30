import 'package:flutter/material.dart';

import '../../util/util.dart';

class UserAvater extends StatefulWidget {
  final String url;
  final String username;
  final String avater;
  final double width;
  final double height;
  const UserAvater(
      {Key? key,
      required this.avater,
      required this.height,
      required this.url,
      required this.username,
      required this.width})
      : super(key: key);

  @override
  State<UserAvater> createState() => _UserAvaterState();
}

class _UserAvaterState extends State<UserAvater> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Image.network(
      '${api}public/uploads/${widget.username}${widget.url}${widget.avater}',
      fit: BoxFit.cover,
      width: widget.width,
      height: widget.height,
      // loadingBuilder: (BuildContext context, Widget child,
      //     ImageChunkEvent? loadingProgress) {
      //   if (loadingProgress == null) return child;
      //   return Center(
      //     child: CircularProgressIndicator(
      //       value: loadingProgress.expectedTotalBytes != null
      //           ? loadingProgress.cumulativeBytesLoaded /
      //               loadingProgress.expectedTotalBytes!
      //           : null,
      //     ),
      //   );
      // },
    ));
  }
}
