import 'package:flutter/material.dart';

class BagainChats extends StatefulWidget {
  const BagainChats({Key? key}) : super(key: key);

  @override
  State<BagainChats> createState() => _BagainChatsState();
}

class _BagainChatsState extends State<BagainChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bagain Life')),
      body: const Text('magic Hapeen'),
    );
  }
}
