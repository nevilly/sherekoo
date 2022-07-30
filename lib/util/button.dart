import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final String number;

  const MyButton({Key? key, required this.icon, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 55,
      decoration: BoxDecoration(
          color: Colors.black54.withOpacity(.5),
          borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                icon,
                size: 18.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                number,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              // const SizedBox(
              //   height: 8.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
