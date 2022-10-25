import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/allData.dart';
import '../../model/bigMontTvShow/bigMonth-call.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import 'crmPckSelect.dart';

class AddBigMonthTvShow extends StatefulWidget {
  const AddBigMonthTvShow({Key? key}) : super(key: key);

  @override
  State<AddBigMonthTvShow> createState() => _AddBigMonthTvShowState();
}

class _AddBigMonthTvShowState extends State<AddBigMonthTvShow> {
  final Preferences _preferences = Preferences();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _season = TextEditingController();
  final TextEditingController _episode = TextEditingController();
  final TextEditingController _tvShowDateController = TextEditingController();

  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";

  String onTapText = 'false';

  String id = '';
  String username = '';
  String avater = '';

  List judges = [];
  List judgesId = [];

  List superStar = [];
  List superStarId = [];


  List<User> data = [];
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getAll();
      });
    });
    super.initState();
  }

  getAll() async {
    AllUsersModel(payload: [], status: 0).get(token, urlUserList).then((value) {
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

  // Posting
  Future<void> addShow() async {
    if (_title.text.isNotEmpty) {
      if (_generalimage != null) {
        List<int> bytes = _generalimage!.readAsBytesSync();
        String image = base64Encode(bytes);

        BigMonthShowCall(
          status: 0,
          payload: [],
        )
 
            .post(token, urladdCrmPackage, _title.text, _season.text, _episode.text, _body.text,judgesId,superStarId,image
                )
            .then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CrmPckList()));
        });
      } else {
       
        fillTheBlanks(context,imgInsertAlt,altSty,odng);
      }
    } else {
    
      fillTheBlanks(context,titleAlt,altSty,odng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            //Details
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: textFieldContainer(
                        context,
                        'Tv show title',
                        _title,
                        1.5,
                        40,
                        13,
                        10,
                        gry1,
                        null,
                        header15.copyWith(height: 1.0, color: fntClr)),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                   //Season 
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: textFieldContainer(
                        context,
                        'Season No',
                        _season,
                        1.5,
                        40,
                        13,
                        10,
                        gry1,
                        null,
                        header15.copyWith(height: 1.0, color: fntClr)),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                   //Episode 
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: textFieldContainer(
                        context,
                        'Episode No',
                        _episode,
                        1.5,
                        40,
                        13,
                        10,
                        gry1,
                        null,
                        header15.copyWith(height: 1.0, color: fntClr)),
                  ),

                  // Season
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: textFieldContainer(
                        context,
                        'Description...',
                        _body,
                        1.5,
                        70,
                        13,
                        10,
                        gry1,
                        null,
                        header15.copyWith(height: 1.0, color: fntClr)),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  dateDialog(
     context, _tvShowDateController, 1.5,  40,10,  gry1,dateStyl), 

                  judge(context),

                  superStars(context),

                  //ColorName

              
                
                ],
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            // Photo Display
            Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Title(
                      color: Colors.red,
                      child: const Text('BigMonth BackGround Image')),
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
                        : const SizedBox(height: 1),
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

            const SizedBox(
              height: 6,
            ),
           

           
          ],
        ),
      ),
    );
  }

  Column judge(BuildContext context) {
    return Column(
      children: [
        uSearch('judge'),
        onTapText == 'false'
            ? SizedBox(height: judges.isNotEmpty ? 115 : 10)
            : const SizedBox(
                height: 10,
              ),
        judges.isNotEmpty
            ? Container(
                color: OColors.darkGrey,
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: judges.length,
                    itemBuilder: (BuildContext context, i) {
                      final itm = judges[i];
                      Column info = Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            itm['username'],
                            style: header12.copyWith(color: gry1),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Judge',
                            style: header10.copyWith(color: gry1),
                          )
                        ],
                      );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: personalProfile(
                            itm['username'], itm['avater'], info, 5, 60, 60),
                      );
                    }),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Column superStars(BuildContext context) {
    return Column(
      children: [
        uSearch('superStar'),
        onTapText == 'false'
            ? SizedBox(height: judges.isNotEmpty ? 115 : 10)
            : const SizedBox(
                height: 10,
              ),
        superStar.isNotEmpty
            ? Container(
                color: OColors.darkGrey,
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: superStar.length,
                    itemBuilder: (BuildContext context, i) {
                      final itm = superStar[i];
                      Column info = Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            itm['username'],
                            style: header12.copyWith(color: gry1),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'SuperStar',
                            style: header10.copyWith(color: gry1),
                          )
                        ],
                      );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: personalProfile(
                            itm['username'], itm['avater'], info, 5, 60, 60),
                      );
                    }),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Autocomplete<User> uSearch(from) {
    return Autocomplete<User>(
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
              hintText: from == 'judge' ? "Search Judges.." : "Search Stars..",
            ),
            style: TextStyle(fontWeight: FontWeight.bold, color: gry1),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: OColors.secondary,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final User option = options.elementAt(index);

                  var info = Column(
                    children: [
                      Text(
                        option.username!,
                        style: header13,
                      ),
                      const SizedBox(
                        height: 5,
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
                        height: 8,
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

                        if (from == 'judge') {
                          if (judges.length <= 3) {
                            judges.add(v);
                            judgesId.add(id);
                          } else {
                           
                                  fillTheBlanks(context,judgesSltAlt,header15,odng);
                          }
                        } else {
                          if (superStar.length <= 1) {
                            superStar.add(v);
                            superStarId.add(id);
                          } else {
                           

                                fillTheBlanks(context,starsSltAlt,header15,odng);
                          }
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: personalProfile(
                          option.username!, option.avater!, info, 10, 40, 40),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (User selection) {
        // setState(() {
        //   username = selection.username!;
        //   avater = selection.avater!;
        //   id = selection.id!;

        //   Map v = {"id": id, "username": username, "avater": avater};
        //   judges.add(v);
        //   judgesId.add(id);

        //   print('ok chek if it work heree');
        //   print(judges);
        // });
      },
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: osec,
      title: const Text('New TV Show'),
      actions: [
        GestureDetector(
          onTap: () {
            addShow();
          },
          child: Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
            decoration: BoxDecoration(
                color: OColors.primary2,
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
