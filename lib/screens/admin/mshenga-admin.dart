import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/user/user-call.dart';
import '../../model/mshengaWar/mshengaWar-Model.dart';
import '../../model/mshengaWar/mshengaWar-call.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/appWords.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import 'mshengaShow-list.dart';

class AddMshengaWarTvShow extends StatefulWidget {
  final MshengaWarModel show;
  const AddMshengaWarTvShow({Key? key, required this.show}) : super(key: key);

  @override
  State<AddMshengaWarTvShow> createState() => _AddMshengaWarTvShowState();
}

class _AddMshengaWarTvShowState extends State<AddMshengaWarTvShow> {
  bool sw = false;

  final TextEditingController _body = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _season = TextEditingController();
  final TextEditingController _episode = TextEditingController();
  final TextEditingController _tvShowDateController = TextEditingController();
  final TextEditingController _dedlineDateController = TextEditingController();

  final _picker = ImagePicker();
  File? _generalimage;

  String onTapText = 'false';

  String id = '';
  String username = '';
  String avater = '';

  List washengaId = [];

  List washenga = [];

  List<User> data = [];
  String washengaIdEdited = '';
  String showImage = '';
  String showId = '';

  double sbxh = 15; // SizedBox height
  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAll();

        if (widget.show.id != '') {
          showId = widget.show.id;
          _body.text = widget.show.description;
          _title.text = widget.show.title;
          _season.text = widget.show.season;
          _episode.text = widget.show.episode;
          _tvShowDateController.text = widget.show.showDate;
          _dedlineDateController.text = widget.show.dedline;
          showImage = widget.show.showImage;
          washengaIdEdited = widget.show.washengaId;
        }
      });
    });
    super.initState();
  }

  getAll() async {
    UsersCall(payload: [], status: 0).get(token, urlUserList).then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          data = value.payload.map<User>((e) => User.fromJson(e)).toList();
        });
      }
    });
  }

  // Image Picking
  _openImagePicker(ImageSource source) async {
    final pick = _picker.pickImage(source: source, imageQuality: 25);
    XFile? pickedImage = await pick;
    if (pickedImage == null) return;

    File img = File(pickedImage.path);
    img = await cropImage(img);

    setState(() {
      _generalimage = img;
    });
  }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: const [
            Tab(
              text: 'OverView',
            ),
            Tab(
              text: 'Description',
            ),
            Tab(
              text: 'Members',
            )
          ]);

  // Posting
  Future<void> addShow() async {
    if (_title.text.isNotEmpty) {
      if (_generalimage != null) {
        List<int> bytes = _generalimage!.readAsBytesSync();
        String image = base64Encode(bytes);

        MshengaWarCall(
          status: 0,
          payload: [],
        )
            .post(
                token,
                urlAddMshengaWar,
                _title.text,
                _season.text,
                _episode.text,
                _body.text,
                _tvShowDateController.text,
                _dedlineDateController.text,
                washengaId,
                image)
            .then((value) {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MshengaShowList()));

          // print(value.payload);
        });
      } else {
        fillTheBlanks(context, l(sw, 43), altSty, odng);
      }
    } else {
      fillTheBlanks(context, l(sw, 44), altSty, odng);
    }
  }

  String edtImg = '';
  String isChanged = '';
  // Posting
  Future<void> editTVShow() async {
    if (_title.text.isNotEmpty) {
      if (_generalimage != null) {
        List<int> bytes = _generalimage!.readAsBytesSync();
        edtImg = base64Encode(bytes);
        isChanged = 'true';
      } else {
        edtImg = showImage;
        isChanged = 'false';
      }

      MshengaWarCall(
        status: 0,
        payload: [],
      )
          .editShow(
              token,
              urlUpdateMshenga,
              widget.show.id,
              _title.text,
              _season.text,
              _episode.text,
              _body.text,
              _tvShowDateController.text,
              _dedlineDateController.text,
              washengaId,
              washengaIdEdited,
              edtImg,
              isChanged)
          .then((value) {
   
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MshengaShowList()));

        // print(value.payload);
      });
    } else {
      fillTheBlanks(context, l(sw, 44), altSty, odng);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double textfldWidth = size.width / 1.5;
    double textfldHeight = 40.0;
    double textFldDescr = 70.0;
    double textFldTopPad = 13.0;
    double textFldRadius = 10.0;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: topBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// Tabs
            ///

            PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.8))),
                child: ColoredBox(
                  color: OColors.darGrey,
                  child: _tabBar,
                ),
              ),
            ),

            ///
            /// Tabs Viewers Start
            ///
            Expanded(
                child: TabBarView(
              children: [
                // Photo Display
                overView(context, textfldWidth, textfldHeight, textFldTopPad,
                    textFldRadius),

                descr(
                    context,
                    textfldWidth,
                    textfldHeight,
                    textFldTopPad,
                    textFldRadius,
                    textFldDescr), //Selecct Judges And superStars
                members(context),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Expanded members(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: sbxh,
            ),
            SizedBox(
              height: sbxh,
            ),
            superStars(context),
            SizedBox(
              height: sbxh,
            ),
          ],
        ),
      ),
    );
  }

  Expanded descr(
      BuildContext context,
      double textfldWidth,
      double textfldHeight,
      double textFldTopPad,
      double textFldRadius,
      double textFldDescr) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Season  & Episode
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                        child:
                            Text(l(sw, 34), style: tft.copyWith(color: gry1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: textFieldContainer(
                            context,
                            l(sw, 35), //Season No
                            _season,
                            120,
                            textfldHeight,
                            textFldTopPad,
                            textFldRadius,
                            gry1,
                            null,
                            header15.copyWith(height: 1.0, color: fntClr),TextInputType.multiline),
                      ),
                    ],
                  ),

                  //Episode
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                        child:
                            Text(l(sw, 36), style: tft.copyWith(color: gry1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: textFieldContainer(
                            context,
                            l(sw, 37), //Episode no
                            _episode,
                            120,
                            textfldHeight,
                            textFldTopPad,
                            textFldRadius,
                            gry1,
                            null,
                            header15.copyWith(height: 1.0, color: fntClr),TextInputType.multiline),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: sbxh,
              ),

              //DeadLime
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                child: Text(l(sw, 40), style: tft.copyWith(color: gry1)),
              ),
              dateDialog(context, _tvShowDateController, textfldWidth,
                  textfldHeight, textFldTopPad, gry1, dateStyl),

              //DeadLime
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                child: Text(l(sw, 40), style: tft.copyWith(color: gry1)),
              ),
              dateDialog(context, _dedlineDateController, textfldWidth,
                  textfldHeight, textFldTopPad, gry1, dateStyl),
              SizedBox(
                height: sbxh,
              ),
              // Description
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                child: Text(l(sw, 38), style: tft.copyWith(color: gry1)),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: textFieldContainer(
                    context,
                    l(sw, 39), //Description
                    _body,
                    textfldWidth,
                    textFldDescr,
                    textFldTopPad,
                    textFldRadius,
                    gry1,
                    null,
                    header15.copyWith(height: 1.0, color: fntClr),TextInputType.multiline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded overView(BuildContext context, double textfldWidth,
      double textfldHeight, double textFldTopPad, double textFldRadius) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 6),
                child: Text(l(sw, 32), style: tft.copyWith(color: gry1)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: textFieldContainer(
                    context,
                    l(sw, 33), //'Tv show title'
                    _title,
                    textfldWidth,
                    textfldHeight,
                    textFldTopPad,
                    textFldRadius,
                    gry1,
                    null,
                    header15.copyWith(height: 1.0, color: fntClr),TextInputType.multiline),
              ),
              SizedBox(
                height: sbxh,
              ),
              Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Title(
                        color: Colors.red,
                        child: const Text('BigMonth  BackGround Image')),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 90,
                    width: 250,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      // width: double.infinity,
                      // height: _generalimage != null ? 300 : 10,
                      color: Colors.grey,
                      child: _generalimage != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 1.0),
                              child: Image.file(
                                _generalimage!,
                              ),
                            )
                          : fadeImg(
                              context, urlMshenngaShowImg + showImage, 100, 80,BoxFit.fitWidth),
                    ),
                  ),
                  Positioned(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Gallary
                        GestureDetector(
                          onTap: () {
                            _openImagePicker(ImageSource.camera);
                          },
                          child: Card(
                            color: OColors.primary,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //cameraa
                        GestureDetector(
                          onTap: () {
                            _openImagePicker(ImageSource.gallery);
                          },
                          child: Card(
                            color: OColors.primary,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.photo_library,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column superStars(BuildContext context) {
    return Column(
      children: [
        uSearch('superStar'),
        onTapText == 'false'
            ? SizedBox(height: washenga.isNotEmpty ? 115 : 10)
            : const SizedBox(
                height: 10,
              ),
        washenga.isNotEmpty
            ? Container(
                color: OColors.darkGrey,
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: washenga.length,
                    itemBuilder: (BuildContext context, i) {
                      final itm = washenga[i];
                      Column info = Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            itm['username'],
                            style: header12.copyWith(color: prmry),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Mshenga',
                            style: header10.copyWith(color: gry1),
                          )
                        ],
                      );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: personProfileClipOval(
                            context,
                            itm['avater'],
                            "${api}public/uploads/$itm['username]/profile/$itm['avater']",
                            info,
                            30,
                            pPbigMnthWidth,
                            pPbigMnthHeight,
                            prmry),
                      );
                    }),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Autocomplete<User> uSearch(from) {
    return Autocomplete<User>(
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 125,
              color: OColors.secondary,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final User option = options.elementAt(index);

                  var info = Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        option.username!,
                        style: header13,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      from == 'judge'
                          ? Text(
                              'Our Judge',
                              style: header12,
                            )
                          : Text(
                              'Our Stars',
                              style: header12,
                            ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  );

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        username = option.username!;
                        avater = option.avater!;
                        id = option.id!;

                        Map v = {
                          "id": id,
                          "username": username,
                          "avater": avater
                        };

                        if (washenga.length <= 1) {
                          washenga.add(v);
                          washengaId.add(id);
                        } else {
                          fillTheBlanks(context, starsSltAlt, header15, odng);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: personProfileClipOval(
                          context,
                          option.avater!,
                          '${api}public/uploads/${option.username!}/profile/${option.avater!}',
                          info,
                          30,
                          pPbigMnthWidth,
                          pPbigMnthHeight,
                          prmry),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          setState(() {
            onTapText = 'false';
          });
          return data
              .where((d) =>
                  d.username!.toLowerCase().contains(value.text.toLowerCase()))
              .toList();
        }
        setState(() {
          onTapText = 'true';
        });

        // The logic to find out which ones should appear
        return data
            .where((d) =>
                d.username!.toLowerCase().contains(value.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (User option) => option.username!,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return Container(
          decoration: const BoxDecoration(color: Colors.grey),
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 18),
              border: InputBorder.none,
              hintStyle: TextStyle(color: gry1, fontSize: 14, height: 1.5),
              hintText: from == 'judge' ? l(sw, 41) : l(sw, 42),
            ),
            style: TextStyle(fontWeight: FontWeight.bold, color: gry1),
          ),
        );
      },
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: osec,
      title: const Text('MSHENGA TV SHOW'),
      actions: [
        GestureDetector(
          onTap: () {
            if (widget.show.id != '') {
              editTVShow();
            } else {
              addShow();
            }
          },
          child: Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
            decoration: BoxDecoration(
                color: OColors.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Icon(
              Icons.send,
              size: 16,
              color: OColors.fontColor,
            ),
          ),
        ),
      ],
    );
  }
}
