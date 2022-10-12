import 'package:flutter/material.dart';

import '../../screens/hireRequset/invit.dart';
import '../../util/colors.dart';

class NotifyWidget extends StatefulWidget {
  const NotifyWidget({Key? key}) : super(key: key);

  @override
  State<NotifyWidget> createState() => _NotifyWidgetState();
}

class _NotifyWidgetState extends State<NotifyWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const InvitationTime()));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          Icons.notifications,
          color: OColors.primary,
          size: 25,
        ),
      ),
    );
  }
}
