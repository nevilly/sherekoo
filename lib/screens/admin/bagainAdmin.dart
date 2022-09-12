import 'package:flutter/material.dart';

class AdminBagain extends StatefulWidget {
  const AdminBagain({Key? key}) : super(key: key);

  @override
  State<AdminBagain> createState() => _AdminBagainState();
}

class _AdminBagainState extends State<AdminBagain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Bagain'),
      ),
    );
  }
}
