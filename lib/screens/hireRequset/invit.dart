import 'package:flutter/material.dart';

import '../../util/Preferences.dart';

class InvitationTime extends StatefulWidget {
  const InvitationTime({Key? key}) : super(key: key);

  @override
  State<InvitationTime> createState() => _InvitationTimeState();
}

class _InvitationTimeState extends State<InvitationTime> {
  final Preferences _preferences = Preferences();
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
