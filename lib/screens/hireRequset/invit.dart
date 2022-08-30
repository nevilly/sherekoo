import 'package:flutter/material.dart';


class InvitationTime extends StatefulWidget {
  const InvitationTime({Key? key}) : super(key: key);

  @override
  State<InvitationTime> createState() => _InvitationTimeState();
}

class _InvitationTimeState extends State<InvitationTime> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Nehemia'),
      ),
      body: const Text('Umiaaa'),
    );
  }
}
