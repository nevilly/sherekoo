import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.red,
        height: 70.0,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Video title and some other stuff'),
              Row(children: const [
                Icon(Icons.music_note, size: 15.0),
                Text('Artist name - Album name - song',
                    style: TextStyle(fontSize: 12.0))
              ]),
            ]),
      ),
    );
  }
}
