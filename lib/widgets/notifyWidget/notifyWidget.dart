import 'package:flutter/material.dart';

import '../../screens/hireRequset/invit.dart';

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
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(top: 1, right: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(35),
        ),
        child: const Icon(
          Icons.notifications,
          color: Colors.black87,
          size: 25,
        ),
      ),
    );
  }
}
