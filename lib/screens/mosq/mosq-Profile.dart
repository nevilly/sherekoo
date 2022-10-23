import 'package:flutter/material.dart';

import '../../model/userModel.dart';

class MosqProfile extends StatefulWidget {
  final User user;
  const MosqProfile({Key? key, required this.user}) : super(key: key);
 

  @override
  State<MosqProfile> createState() => _MosqProfileState();
}

class _MosqProfileState extends State<MosqProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
    );
  }
}
