import 'package:flutter/material.dart';
import '../../model/post/sherekoModel.dart';
import '../../util/util.dart';

class PostDetail extends StatefulWidget {
  final SherekooModel post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _body = TextEditingController();
  int id = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Writer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Container(
                      child: widget.post.vedeo != ''
                          ? Image.network(
                              api +
                                  'public/uploads/' +
                                  widget.post.username +
                                  '/posts/' +
                                  widget.post.vedeo,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(height: 1)),
                ),
                Text(widget.post.body),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        //header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.0, left: 4.0, right: 4.0),
                                  child: CircleAvatar(
                                    radius: 15.0,
                                    backgroundImage:
                                        AssetImage('assets/login/02.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text('Karium',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //body Message
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 10.0),
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text:
                                        'Nakutakia maisha yenye Amani na upendo rafik wa kweri',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Colors.grey)),
                                TextSpan(
                                    text: ' @koosafi-MrsMwakanyaga0xsd',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.0,
                                        color: Colors.grey)),
                              ])),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: SizedBox(
                                width: 0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('12:00 pm'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        //header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4.0, left: 4.0, right: 4.0),
                                  child: CircleAvatar(
                                    radius: 15.0,
                                    backgroundImage:
                                        AssetImage('assets/login/02.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text('Karium',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //body Message
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 10.0),
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text:
                                        'Nakutakia maisha yenye Amani na upendo rafik wa kweri',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Colors.grey)),
                                TextSpan(
                                    text: ' @koosafi-MrsMwakanyaga0xsd',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.0,
                                        color: Colors.grey)),
                              ])),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: SizedBox(
                                width: 0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('12:00 pm'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            // height: 50,
            height: size.height * 0.08,
            width: size.width * 2.8,
            // color: Colors.red,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Stack(
                children: [
                  TextFormField(
                    controller: _body,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5, bottom: 5),
                      prefixIcon: const Icon(Icons.tag_faces_sharp),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            // post();
                            _body.text = '';
                          },
                          child: const Icon(Icons.send)),
                      // suffixIcon: Icon(Icons.send_rounded),
                      hintText: 'Type here..',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
