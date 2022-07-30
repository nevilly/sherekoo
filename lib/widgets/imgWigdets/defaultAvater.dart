import 'package:flutter/material.dart';

class DefaultAvater extends StatefulWidget {
  final double radius;
  final double width;
  final double height;
  const DefaultAvater(
      {Key? key,
      required this.height,
      required this.radius,
      required this.width})
      : super(key: key);

  @override
  State<DefaultAvater> createState() => _DefaultAvaterState();
}

class _DefaultAvaterState extends State<DefaultAvater> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: widget.radius,
      child: ClipOval(
        child: Image(
          image: const AssetImage('assets/profile/profile.jpg'),
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}
