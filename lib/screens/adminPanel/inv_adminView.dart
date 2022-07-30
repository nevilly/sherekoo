import 'package:flutter/material.dart';

class InvAdminView extends StatefulWidget {
  const InvAdminView({Key? key}) : super(key: key);

  @override
  State<InvAdminView> createState() => _InvAdminViewState();
}

class _InvAdminViewState extends State<InvAdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin Invitaion Request'),
      ),
    );
  }
}
