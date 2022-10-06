import 'package:flutter/material.dart';

import '../../util/colors.dart';

class BackgroundImage extends StatelessWidget {
  final String image;
  // ignore: use_key_in_widget_constructors
  const BackgroundImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [OColors.secondary, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            // colorFilter:
            //     const ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
