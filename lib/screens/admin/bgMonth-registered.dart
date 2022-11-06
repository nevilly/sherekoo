import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

class BigMonthRegistered extends StatefulWidget {
  const BigMonthRegistered({Key? key}) : super(key: key);

  @override
  State<BigMonthRegistered> createState() => _BigMonthRegisteredState();
}

class _BigMonthRegisteredState extends State<BigMonthRegistered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: osec,
      appBar: AppBar(
        title: const Text('Big Month '),
      ),
      body: Text(''),
    );
  }
}
