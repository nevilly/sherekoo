import 'package:flutter/material.dart';
import 'package:sherekoo/model/post/sherekoModel.dart';

import '../../util/util.dart';
import '../../widgets/cermChats_widgets.dart';

class LiveePost extends StatefulWidget {
  final SherekooModel post;
  const LiveePost(
      {Key? key,
      required this.post})
      : super(key: key);

  @override
  State<LiveePost> createState() => _LiveePostState();
}

class _LiveePostState extends State<LiveePost> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 400,
        width: double.infinity,
        // color:
        //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    //header

                    Row(
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
                    const SizedBox(
                      height: 10,
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
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                                text: widget.post.body,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                    color: Colors.grey)),
                            // TextSpan(
                            //     text: ' @koosafi-MrsMwakanyaga0xsd',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontStyle: FontStyle.italic,
                            //         fontSize: 12.0,
                            //         color: Colors.grey)),
                          ])),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //footer

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.reply,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('234'),
                              ],
                            ),
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.favorite,
                                size: 20.0,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('139'),
                            ],
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
                                    Icons.send,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Comments',
                                    style: TextStyle(
                                        letterSpacing: .1, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
