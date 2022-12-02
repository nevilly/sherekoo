import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/model/crmBundle/crmbundle-call.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/InvCards/cards.dart';
import '../../model/InvCards/invCards.dart';
import '../../model/allData.dart';
import '../../model/busness/allBusness.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/crmPackage/crmPackageModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/appWords.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';
import '../../widgets/imgWigdets/userAvater.dart';

class CrmBundleAdmin extends StatefulWidget {
  final CrmPckModel crmPackageInfo;
  const CrmBundleAdmin({Key? key, required this.crmPackageInfo})
      : super(key: key);

  @override
  State<CrmBundleAdmin> createState() => _CrmBundleAdminState();
}

class _CrmBundleAdminState extends State<CrmBundleAdmin> {
  final Preferences _preferences = Preferences();
  final TextEditingController _aboutBundle = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController location = TextEditingController();

  final TextEditingController _titlePlan = TextEditingController();
  final TextEditingController _bodyPlan = TextEditingController();

  final TextEditingController _amountOfPeople = TextEditingController();
  final TextEditingController around = TextEditingController();

  final _picker = ImagePicker();
  File? _generalimage;
  String token = "";
  String selectedBusness = 'all';
  final List<String> _busness = [
    'Mc',
    'Production',
    'Decorator',
    'Hall',
    'Cake Bakery',
    'Singer',
    'Dancer',
    'Cooker',
    'saloon',
    'Car',
  ];

  final List<String> _bundleType = [
    'Wedding',
    'Birthday',
    'SendOff',
    'Kitchen Part',
    'Kigodoro',
    'House Part',
    'Bachelor Part',
    '5 yrs Mrg',
    'Game Part ',
  ];

  String superVisorAvater = '';
  String superVisorUname = '';
  String superVisorId = '';
  String superVisorRole = '';

  String bundleType = 'Bundle Type';
  CrmPckModel crmPackageInfo = CrmPckModel(
      id: '',
      title: '',
      descr: '',
      pImage: '',
      inYear: '',
      status: '',
      colorCode: [],
      createdDate: '');
  List<BusnessModel> data = [];
  List<String> bsnId = [];
  List<BusnessModel> bsnArr = [];
  List<User> users = [];
  List<CardsModel> cardsInfo = [];
  List colorCodeInfo = [];
  List plan = [];
  String crmPackageId = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        crmPackageInfo = widget.crmPackageInfo;
        crmPackageId = widget.crmPackageInfo.id;
        colorCodeInfo = widget.crmPackageInfo.colorCode;

        getAllCards();
        getAllBusness('all');
        getUser(urlUserList);
      });
    });
    super.initState();
  }

  getUser(String dirUrl) {
    AllUsersModel(payload: [], status: 0).get(token, urlUserList).then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          users = value.payload.map<User>((e) => User.fromJson(e)).toList();
        });
      }
    });
  }

  getAllBusness(arg) async {
    if (arg != 'all') {
      AllBusnessModel(payload: [], status: 0)
          .onGoldenBusness(token, urlGoldBusness, selectedBusness, '')
          .then((value) {
        if (value.status == 200) {
          setState(() {
            // print(value.payload);
            data = value.payload.map<BusnessModel>((e) {
              return BusnessModel.fromJson(e);
            }).toList();
          });
        }
      });
    } else {
      AllUsersModel(payload: [], status: 0)
          .get(token, urlAllBusnessList)
          .then((value) {
        if (value.status == 200) {
          setState(() {
            data = value.payload.map<BusnessModel>((e) {
              return BusnessModel.fromJson(e);
            }).toList();
          });
        }
      });
    }
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

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List hallImageSample = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }

    // print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  List cardId = [];
  List<CardsModel> cardsId = [];
  List<CardsModel> cards = [];

  getAllCards() async {
    InvCards(payload: [], status: 0).get(token, urlGetInvCards).then((value) {
      if (value.status == 200) {
        setState(() {
          cards = value.payload
              .map<CardsModel>((e) => CardsModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  hallImageSampleFunc() {
    for (XFile e in imageFileList!) {
      File im = File(e.path);
      List<int> bytes = im.readAsBytesSync();
      String image = base64Encode(bytes);

      setState(() {
        hallImageSample.add(image);
      });
    }
  }

  // Posting
  Future<void> post() async {
   
    hallImageSampleFunc();
    if (crmPackageInfo.id != '') {
      if (superVisorId.isNotEmpty) {
        if (plan.isNotEmpty) {
          if (bundleType != 'Bundle Type') {
            if (_price.text.isNotEmpty) {
              if (_generalimage != null) {
                List<int> bytes = _generalimage!.readAsBytesSync();
                String bundleImage = base64Encode(bytes);
                // print('hallImageSample');
                // print(hallImageSample);

                CrmBundleCall(
                  status: 0,
                  payload: [],
                )
                    .postBundle(
                        token,
                        urladdCrmBundle,
                        _price.text,
                        bundleType,
                        _amountOfPeople.text,
                        _aboutBundle.text,
                        crmPackageInfo.id,
                        location.text,
                        around.text,
                        cardId,
                        bsnId,
                        superVisorId,
                        bundleImage,
                        hallImageSample,
                        plan)
                    .then((value) {
                  // print('observe heree');
                  // print(value.payload);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => const CrmPckList()));
                });
              } else {
                
                
                fillTheBlanks(context,imgInsertAlt,altSty,odng);
                
              }
            } else {
              
              fillTheBlanks(context,priceBundleAlt,altSty,odng);
            }
          } else {
            
            fillTheBlanks(context,bundleTypeAlt,altSty,odng);
            
          }
        } else {
          
          fillTheBlanks(context,bundlePlanAlt,altSty,odng);
        }
      } else {
    
        fillTheBlanks(context,superVisorAlt,altSty,odng);
      }
    } else {
      
      fillTheBlanks(context,crmPackgSltAlt,altSty,odng);
    }
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
              text: 'Bsn',
            ),
            Tab(
              text: 'Plan',
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: const Text('New Bundle'),
          actions: [
            GestureDetector(
              onTap: () {
                post();
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
        ),
        body: Column(
          children: [
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
            Expanded(
              child: TabBarView(children: [
                firstDetails(context, size),

                //Details
                descriptionBundle(size, context),

                bsnSever(context, size),

                plansBundle(context, size)
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Column plansBundle(BuildContext context, size) {
    return Column(
      children: [
        SizedBox(
          width: size.width,
          // color: OColors.darGrey,
          height: size.height / 1.5,
          child: ListView.builder(
              itemCount: plan.length,
              itemBuilder: (BuildContext context, i) {
                final itm = plan[i];
                return Container(
                  color: OColors.darGrey,
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 1.4,
                                child: Text(itm['title'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.clip,
                                    style:
                                        header16.copyWith(color: Colors.grey)),
                              ),
                              SizedBox(
                                width: size.width / 1.3,
                                child: Text(itm['descr'],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.clip,
                                    style: header13.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              )
                            ]),
                      ),
                      Column(children: [
                        GestureDetector(
                          onTap: () {
                            addPlan(context, size, itm);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: OColors.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.edit,
                                    size: 18, color: OColors.fontColor),
                              )),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              plan.remove(itm);
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: OColors.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete,
                                    size: 18, color: OColors.fontColor),
                              )),
                        )
                      ])
                    ],
                  ),
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            GestureDetector(
              onTap: () {
                addPlan(context, size, 'not');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: OColors.primary),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add Plan',
                      style: header13.copyWith(color: OColors.fontColor)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  SingleChildScrollView firstDetails(BuildContext context, size) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),

          /** Bundle Image */
          Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Bundle Image'),
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
              Column(
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
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
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
                          size: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 6,
          ),

          // Hall Images
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Halls Photo from Gallay',
                  style: header13.copyWith(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    selectImages();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: OColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo_album,
                        size: 15,
                        color: OColors.fontColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: imageFileList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(imageFileList![index].path),
                      fit: BoxFit.cover,
                    );
                  }),
            ),
          ),

          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Column bsnSever(BuildContext context, size) {
    return Column(
      children: [
        //Selecte Busness/ Sever
        SizedBox(
          height: size.height / 1.5,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selected Busness'),
                SizedBox(
                    width: size.width,
                    height: size.height,
                    child: bsnArr.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bsnArr.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, i) {
                              final itm = bsnArr[i];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(1.0),
                                              topRight: Radius.circular(1.0),
                                            ),
                                            child: itm.coProfile != ''
                                                ? Image.network(
                                                    '${api}public/uploads/${itm.user.username}/busness/${itm.coProfile}',
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const SizedBox(height: 1)),
                                        Column(
                                          children: [
                                            Text(
                                              itm.busnessType,
                                              style: header11.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              itm.price,
                                              style: header11.copyWith(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          bsnArr.remove(itm);
                                          bsnId.remove(itm.bId);

                                        
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: OColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 16,
                                            color: OColors.fontColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : const Text('Select Cards Sample')),
              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width / 1.9,
              height: 35,
              // margin: selectedBusness != 'Please Choose Busness'
              //     ? const EdgeInsets.only(left: 20, right: 20)
              //     : const EdgeInsets.only(left: 20, right: 20, top: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width: 2, color: OColors.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  // icon: const Icon(Icons.arrow_circle_down),
                  // iconSize: 20,
                  // elevation: 16,
                  dropdownColor: OColors.darGrey,
                  underline: Container(),
                  items: _busness.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(color: OColors.fontColor)),
                    );
                  }).toList(),
                  hint: Container(
                    // color: OColors.darGrey,
                    alignment: Alignment.center,
                    child: Text(
                      selectedBusness,
                      style: header13,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onChanged: (v) {
                    setState(() {
                      // print(v);
                      selectedBusness = v!;
                    });
                  },
                ),
              ),
            ),
            //Busenss/ Sever Search
            if (selectedBusness != 'Please Choose Busness')
              GestureDetector(
                onTap: () {
                  prevBusness(context, selectedBusness);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: OColors.primary,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      size: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  SingleChildScrollView descriptionBundle(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: OColors.darkGrey),
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.8,
              height: 35,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: OColors.darkGrey),
              child: TextField(
                controller: _price,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "Bundle Price.. \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          //about Bundle
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _aboutBundle,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "About Bundle.. \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(
            height: 6,
          ),
          //Bundle Type
          Container(
            width: size.width / 1.6,
            height: 40,
            // margin: selectedBusness != 'Please Choose Busness'
            //     ? const EdgeInsets.only(left: 20, right: 20)
            //     : const EdgeInsets.only(left: 20, right: 20, top: 2),
            decoration: BoxDecoration(
              color: OColors.primary,
              border: Border.all(width: 2, color: OColors.primary),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: DropdownButton<String>(
                isExpanded: true,
                // icon: const Icon(Icons.arrow_circle_down),
                // iconSize: 20,
                // elevation: 16,
                dropdownColor: OColors.darGrey,
                underline: Container(),
                items: _bundleType.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:
                        Text(value, style: TextStyle(color: OColors.fontColor)),
                  );
                }).toList(),
                hint: Container(
                  // color: OColors.darGrey,
                  alignment: Alignment.center,
                  child: Text(
                    bundleType,
                    style: header13,
                    textAlign: TextAlign.center,
                  ),
                ),
                onChanged: (v) {
                  setState(() {
                    // print(v);
                    bundleType = v!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          //Location
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text('Location'),
              )),
          const SizedBox(height: 8),
          //location
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: OColors.darkGrey),
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.8,
              height: 35,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: OColors.darkGrey),
              child: TextField(
                controller: location,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "Location.. \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),

          //location
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: OColors.darkGrey),
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.8,
              height: 35,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: OColors.darkGrey),
              child: TextField(
                controller: around,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "Around Eg posta.. \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),

          //amount of People
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: 35,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _amountOfPeople,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  hintText: "Amount of People.. \n \n \n",
                  hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          //Colors Code
          const Text('Color Code of Year'),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: crmPackageInfo.id.isNotEmpty
                  ? Row(
                      children: [
                        crmPackageInfo.pImage != ''
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipOval(
                                  child: UserAvater(
                                    avater: crmPackageInfo.pImage,
                                    url: '/crmPackage/',
                                    username: 'sherekooAdmin',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ))
                            : const ClipOval(
                                child: DefaultAvater(
                                    height: 50, radius: 35, width: 50)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                crmPackageInfo.title,
                                style: header13.copyWith(color: Colors.grey),
                              ),
                              Text(
                                crmPackageInfo.inYear,
                                style: header12.copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : const Text('Select Ceremony Package')),

          //Color Code Show
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: colorCodeInfo.isNotEmpty
                ? /** ColorCode Start */
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color Code List
                      SizedBox(
                        height: 65,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: colorCodeInfo.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  childAspectRatio: 0.8),
                          itemBuilder: (context, i) {
                            final itm = colorCodeInfo[i];
                            return crmColorCode(
                                context,
                                Color(int.parse(itm['color'])),
                                5,
                                50,
                                40,
                                itm['colorName']);
                          },
                        ),
                      ),
                    ],
                  )
                : Text(' Select ColorCode Now',
                    style: header13.copyWith(color: Colors.grey)),
          ),

          const SizedBox(
            height: 8,
          ),

          //Card Sample
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ceremony Card Sample'),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: cards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, i) {
                      final itm = cards[i];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            cardsId.add(itm);
                            cardId.add(itm.id);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Stack(
                            children: [
                              fadeImg(
                                  itm,
                                  context,
                                  '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}',
                                  MediaQuery.of(context).size.height / 6.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  itm.price,
                                  style: header12.copyWith(color: Colors.black),
                                ),
                              ),
                              Text(
                                itm.cardType,
                                style: header10,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 8),
              const Text('Selected Card Sample'),
              Container(
                  color: Colors.red,
                  height: 80,
                  child: cardsId.isNotEmpty
                      ? ListView.builder(
                          itemCount: cardsId.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, i) {
                            final itm = cardsId[i];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: Stack(
                                children: [
                                  fadeImg(
                                      itm,
                                      context,
                                      '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}',
                                      MediaQuery.of(context).size.height / 6.0),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            cardsId.remove(itm);
                                            cardId.remove(itm.id);
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    child: Column(
                                      children: [
                                        Text(
                                          itm.cardType,
                                          style: header11,
                                        ),
                                        Text(
                                          itm.price,
                                          style: header11.copyWith(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : const Text('Select Cards Sample')),
            ],
          ),

          const SizedBox(
            height: 8,
          ),

          //Selecte SuperVisor
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select SuperVisor'),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: users.isNotEmpty
                        ? ListView.builder(
                            itemCount: users.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, i) {
                              final itm = users[i];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    superVisorAvater = itm.avater!;
                                    superVisorUname = itm.username!;
                                    superVisorId = itm.id!;
                                    superVisorRole = itm.role!;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: Column(
                                    children: [
                                      itm.avater != ''
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: ClipOval(
                                                child: UserAvater(
                                                  avater: itm.avater!,
                                                  url: '/profile/',
                                                  username: itm.username!,
                                                  width: 50.0,
                                                  height: 50.0,
                                                ),
                                              ))
                                          : const ClipOval(
                                              child: DefaultAvater(
                                                  height: 50,
                                                  radius: 35,
                                                  width: 50)),
                                      Positioned(
                                        child: Column(
                                          children: [
                                            Text(
                                              itm.username!,
                                              style: header11.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Text('Select SuperVisor')),
                const Text('Selected SuperVisor'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: superVisorId.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Profile Details
                            Row(
                              children: [
                                Container(
                                  child: superVisorAvater != ''
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: UserAvater(
                                              avater: superVisorAvater,
                                              url: '/profile/',
                                              username: superVisorUname,
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          ))
                                      : const ClipOval(
                                          child: DefaultAvater(
                                              height: 50,
                                              radius: 35,
                                              width: 50)),
                                ),
                                Column(
                                  children: [
                                    Text(superVisorUname,
                                        style: header12.copyWith(
                                            color: Colors.grey)),
                                    Text(superVisorRole,
                                        style: header11.copyWith(
                                            color: Colors.grey)),
                                    Text('SuperVisor',
                                        style: header10.copyWith(
                                            color: Colors.grey)),
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  superVisorAvater = '';
                                  superVisorUname = '';
                                  superVisorId = "";
                                  superVisorRole = '';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: OColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Remove',
                                    style: header13,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Text(' Select SuPerVisor Now',
                          style: header13.copyWith(color: Colors.grey)),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  FadeInImage fadeImg(CardsModel itm, BuildContext context, url, double h) {
    return FadeInImage(
      image: NetworkImage(url),
      fadeInDuration: const Duration(milliseconds: 100),
      placeholder: const AssetImage('assets/logo/noimage.png'),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/logo/noimage.png', fit: BoxFit.fitWidth);
      },
      height: h,
      fit: BoxFit.fitWidth,
    );
  }

  prevBusness(BuildContext context, bsnType) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const SizedBox(),
      onPressed: () {
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                itemCount: data.length,
                // staggeredTileBuilder: (int index) =>
                //     StaggeredTile.fit(index == 0 ? 2 : 1),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 6,
                itemBuilder: (BuildContext context, index) {
                  final itm = data[index];
                  return InkWell(
                      child: Card(
                    child: ColoredBox(
                      color: OColors.darGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //BackgroundImage & Busness Type
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => BsnDetails(
                              //             data: data[index],
                              //             ceremonyData: widget.ceremony)));

                              setState(() {
                                bsnId.add(itm.bId);
                                bsnArr.add(itm);

                              
                              });
                            },
                            child: Stack(children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(1.0),
                                    topRight: Radius.circular(1.0),
                                  ),
                                  child: data[index].coProfile != ''
                                      ? Image.network(
                                          '${api}public/uploads/${data[index].user.username}/busness/${data[index].coProfile}',
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        )
                                      : const SizedBox(height: 1)),
                              Positioned(
                                  top: 1,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          data[index].busnessType,
                                          style: header11,
                                        ),
                                      )))
                            ]),
                          ),

                          //Details
                          const SizedBox(height: 5.0),

                          // Price Display
                          Container(
                            alignment: Alignment.center,
                            // padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '${data[index].price} Tsh',
                              style: header12,
                            ),
                          ),
                          const SizedBox(height: 3.0),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              data[index].knownAs,
                              style: header10,
                            ),
                          ),

                          const SizedBox(height: 3.0),
                          // Rate Stars
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       margin: const EdgeInsets.only(
                          //           left: 8.0, bottom: 4.0),
                          //       child: Row(children: [
                          //         starsIcons(Colors.red),
                          //         starsIcons(Colors.red),
                          //         starsIcons(Colors.red),
                          //         starsIcons(Colors.grey),
                          //         starsIcons(Colors.grey),
                          //       ]),
                          //     ),
                          //     Container(
                          //       margin: const EdgeInsets.only(
                          //           right: 8.0, bottom: 4.0),
                          //       child: Row(children: const [
                          //         Icon(
                          //           Icons.heart_broken,
                          //           size: 16,
                          //           color: Colors.red,
                          //         )
                          //       ]),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ));
                },
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(2);
                }),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addPlan(BuildContext context, size, itm) {
    if (itm != 'not' && itm.isNotEmpty) {
      _titlePlan.text = itm['title'];
      _bodyPlan.text = itm['descr'];
    }

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const SizedBox(),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("cancel"),
      onPressed: () {
        setState(() {
          if (itm != 'not' && itm.isNotEmpty) {
            itm['title'] = _titlePlan.text;
            itm['descr'] = _bodyPlan.text;

            _titlePlan.clear();
            _bodyPlan.clear();
          } else {
            Map map = {"title": _titlePlan.text, "descr": _bodyPlan.text};
            plan.add(map);

            _titlePlan.clear();
            _bodyPlan.clear();
          }
        });
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ),
      ),
      content: SizedBox(
        width: size.width / 1.8,
        height: size.height / 3.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 35,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: OColors.darkGrey),
                child: TextField(
                  controller: _titlePlan,
                  maxLines: null,
                  expands: true,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    border: InputBorder.none,
                    hintText: "Plan Title.. \n \n \n",
                    hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  style: const TextStyle(
                      fontSize: 13, color: Colors.grey, height: 1.5),
                  onChanged: (value) {
                    setState(() {
                      //_email = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 90,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: OColors.darkGrey),
                child: TextField(
                  controller: _bodyPlan,
                  maxLines: null,
                  expands: true,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    border: InputBorder.none,
                    hintText: "Plan Title.. \n \n \n",
                    hintStyle: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey, height: 1.5),
                  onChanged: (value) {
                    setState(() {
                      //_email = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Column crmColorCode(
      BuildContext context, Color color, double r, double w, double h, title) {
    return Column(
      children: [
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(r)),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: header12.copyWith(color: Colors.grey),
        )
      ],
    );
  }

  Icon starsIcons(Color color) {
    return Icon(
      Icons.star,
      size: 16,
      color: color,
    );
  }
}
