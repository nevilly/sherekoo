import 'package:flutter/material.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';

import '../../util/util.dart';
import '../../widgets/cermChats_widgets.dart';

class LiveePost extends StatefulWidget {
  final SherekooModel post;
  const LiveePost({Key? key, required this.post}) : super(key: key);

  @override
  State<LiveePost> createState() => _LiveePostState();
}

class _LiveePostState extends State<LiveePost> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 400,
        // width: double.infinity,
        // color:
        //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30.0,
        ),
        //header
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(api +
                          'public/uploads/' +
                          widget.post.username +
                          '/profile/' +
                          widget.post.avater),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(widget.post.username,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.post.createdDate),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 5,
        ),

        //body Photo
        Center(
          child: Container(
              child: widget.post.vedeo != ''
                  ? Image.network(
                      api +
                          'public/uploads/' +
                          widget.post.username +
                          '/posts/' +
                          widget.post.vedeo,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox(height: 1)),
        ),

        //body Message
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 8, right: 5.0),
          child: Text(widget.post.body,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black54)),
        ),

        //footer
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.more_vert,
                    size: 20.0,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.more_vert)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.reply,
                          size: 18.0,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          '234',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          size: 18.0,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text('139'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      oneButtonPressed(widget.post);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.send_outlined,
                            size: 18.0,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            '23',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  void oneButtonPressed(p) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 560,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: CeremonyChats(post: p)),
          );
        });
  }
}
