import 'package:flutter/material.dart';
import 'package:sherekoo/screens/accounts/login.dart';
import 'package:sherekoo/util/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sherekoo',
      theme: ThemeData(
          primaryColor: OColors.secondary,
          // primarySwatch: Colors.blac,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            subtitle2: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            bodyText1: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
            bodyText2: TextStyle(color: Color.fromRGBO(10, 10, 10, .6)),
          )),
      home: const LoginPage(),
    );
  }
}
