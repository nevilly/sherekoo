import 'package:flutter/material.dart';
import 'package:sherekoo/util/func.dart';

import '../../util/colors.dart';

class ServicesBackgroundImage extends StatelessWidget {
  final String image;
  // ignore: use_key_in_widget_constructors
  const ServicesBackgroundImage({required this.image});

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
        child: fadeImg(context, image, MediaQuery.of(context).size.width / 1,
            MediaQuery.of(context).size.height / 1,BoxFit.fitWidth),
      ),
    );
  }
}
