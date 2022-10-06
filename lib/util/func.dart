import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/ceremony/ceremonyModel.dart';
import '../model/ceremony/crmViewerModel.dart';

import '../widgets/imgWigdets/defaultAvater.dart';
import '../widgets/imgWigdets/userAvater.dart';
import '../widgets/listTile_widget.dart';
import 'colors.dart';
import 'util.dart';

List<CrmViewersModel> crmViewer = [];

///
///Mesage
///
/// In Ceremony upoload
///  Upload Message
String choosePhoto = 'Choose Photo Pls....';
String selectBirthday = 'Select Birthday Boy/Girl';
String enterAge = 'Enter Age pls ...';
String insertBirthday = 'Enter Birthday date pls ...';

String insertBrandName = 'Insert your Brand Name on "CO Tab" pls!...';
String insertPrice = 'Insert your Price on "Co Tab" pls!...';
String insertPhoneNumber = 'Insert your Phone Number  on "Co Tab" pls!...';
String insertContact = 'Insert Contact  on "Co Tab" pls!...';
String insertLastMsg = 'No message';

//Livee => DetailsTab (TabB), commetee Viewers
String viewerPositionMsg = 'Select Position Please';

final List<String> viewerPositionList = [
  'Viewer',
  'Relative',
  'Friend',
  'Chairman',
  'Accountant',
  'Secretary',
  'Food Commetee',
  'Gift Commetee',
  'Clothes Commetee',
  'Decoration Commetee',
  'Transport commetee',
  'Drinks commetee',
  'Mc Commetee'
];

/// Buttons
Container outlilneButton(
    Icon icon, Widget child, double width, Color borderColor, double r) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      border: Border.all(
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(r),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 6,
          ),
          child,
        ],
      ),
    ),
  );
}

//hash Tag Button
Container hashTagCircle() {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.red.withOpacity(.2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '#',
          style: header18.copyWith(
              color: OColors.primary, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}

Container hashTagFunc(context, String title, String hashTag) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        Text(
          '#',
          style: header13.copyWith(
              color: title != hashTag ? OColors.primary : OColors.darkGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          title,
          style: header13.copyWith(
              color: title != hashTag ? OColors.primary : OColors.darkGrey,
              fontWeight: FontWeight.w400),
        )
      ]),
    ),
  );
}

void oneButtonPressed(context, List<CrmViewersModel> list, Function funct) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 560,
          child: Container(
              decoration: BoxDecoration(
                  color: OColors.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Commetee ', style: header15),
                  ),
                  // SizedBox(height: 5),

                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, index) {
                          return SingleChildScrollView(
                              child: ListMembers(
                            data: list[index],
                            list: list.reversed.toList(),
                            removeFunc: funct,
                          ));
                        }),
                  ),
                ],
              )),
        );
      });
}

//Griv Viewer

void viewerGrid(
  context,
  List<CrmViewersModel> list,
) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 560,
          child: Container(
              decoration: BoxDecoration(
                  color: OColors.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${list.length} Viewers ', style: header15),
                    ),
                    // SizedBox(height: 5),

                    const SizedBox(height: 10),
                    Expanded(
                      child: StaggeredGridView.countBuilder(
                         
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 2,
                          crossAxisCount: 8,
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final itm = list[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => PostChats(
                                //               postId: post[index].pId,chatsNo:  post[index].commentNumber,
                                //             )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    Stack(
                                        clipBehavior: Clip.hardEdge,
                                        children: [
                                          Center(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            29.0)),
                                                child: itm.viewerInfo.avater !=
                                                        ''
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: FadeInImage(
                                                          image: NetworkImage(
                                                              '${api}public/uploads/${itm.viewerInfo.username}/profile/${itm.viewerInfo.avater}'),
                                                          fadeInDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      100),
                                                          placeholder:
                                                              const AssetImage(
                                                                  'assets/logo/noimage.png'),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'assets/logo/noimage.png',
                                                                fit: BoxFit
                                                                    .fitWidth);
                                                          },
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      )
                                                    : const SizedBox(
                                                        height: 1)),
                                          ),
                                          Positioned(
                                            left: 0,
                                            bottom: 0,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 109),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0,
                                                        vertical: 3.0),
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: const Color.fromRGBO(
                                                            0, 0, 0, 0.451)
                                                        .withOpacity(.8),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.comment,
                                                            color:
                                                                OColors.primary,
                                                            size: 13,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            itm.viewerInfo
                                                                .username!,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return const StaggeredTile.fit(2);
                          }),
                    ),
                  ],
                ),
              )),
        );
      });
}

//Ceremony Uploading
fillTheBlanks(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: header16,
        ),
        backgroundColor: OColors.danger),
  );
}

//Loading
Column loadingFunc(double height, Color color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: height,
        child: CircularProgressIndicator(
          color: color,
        ),
      )
    ],
  );
}

//Livee

//Ceremony Profile
Row weddingProfile(BuildContext context, widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.ceremony.userFid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: UserAvater(
                      avater: widget.ceremony.userFid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userFid.username,
                      height: 80,
                      width: 80),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: DefaultAvater(height: 80, radius: 20, width: 80)),
            ),
      widget.ceremony.userSid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.fontColor,
                      // OColors.darGrey,
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: UserAvater(
                        avater: widget.ceremony.userSid.avater,
                        url: '/profile/',
                        username: widget.ceremony.userSid.username,
                        height: 80,
                        width: 80),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: DefaultAvater(height: 80, radius: 20, width: 80)),
              ),
            ),
    ],
  );
}

ClipRRect birthdayProfile(BuildContext context, widget) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
    child: UserAvater(
        avater: widget.ceremony.cImage,
        url: '/ceremony/',
        username: widget.ceremony.userFid.username,
        height: 100,
        width: 90),
  );
}

ClipRRect kigodoroProfile(BuildContext context, widget) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
    child: UserAvater(
        avater: widget.ceremony.cImage,
        url: '/ceremony/',
        username: widget.ceremony.userFid.username,
        height: 100,
        width: 90),
  );
}

Row kichernPartProfile(BuildContext context, widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.ceremony.userFid.gender == 'male' &&
              widget.ceremony.userFid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: UserAvater(
                      avater: widget.ceremony.userFid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userFid.username,
                      height: 80,
                      width: 80),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.fontColor,
                      // OColors.darGrey,
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const DefaultAvater(
                          height: 80, radius: 15, width: 80)),
                ),
              ),
            ),
      widget.ceremony.userSid.gender == 'female' &&
              widget.ceremony.userSid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  child: UserAvater(
                      avater: widget.ceremony.userSid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userSid.username,
                      height: 85,
                      width: 85),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                        const DefaultAvater(height: 85, radius: 15, width: 85)),
              ))
    ],
  );
}

Row sendProfile(BuildContext context, widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.ceremony.userFid.gender == 'male' &&
              widget.ceremony.userFid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: UserAvater(
                      avater: widget.ceremony.userFid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userFid.username,
                      height: 80,
                      width: 80),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.fontColor,
                      // OColors.darGrey,
                      OColors.primary2,
                      OColors.darGrey,
                      OColors.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const DefaultAvater(
                          height: 80, radius: 15, width: 80)),
                ),
              ),
            ),
      widget.ceremony.userSid.gender == 'female' &&
              widget.ceremony.userSid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  child: UserAvater(
                      avater: widget.ceremony.userSid.avater,
                      url: '/profile/',
                      username: widget.ceremony.userSid.username,
                      height: 85,
                      width: 85),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.fontColor,
                    // OColors.darGrey,
                    OColors.primary2,
                    OColors.darGrey,
                    OColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                        const DefaultAvater(height: 85, radius: 15, width: 85)),
              ))
    ],
  );
}

Row weddingProfileCrm(BuildContext context, itm, double w, double h, double r) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      itm.userFid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: itm.userFid.avater,
                      url: '/profile/',
                      username: itm.userFid.username,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: DefaultAvater(height: h, radius: r, width: w)),
            ),
      itm.userSid.avater.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: itm.userSid.avater,
                      url: '/profile/',
                      username: itm.userSid.username,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(r),
                    ),
                    child: DefaultAvater(height: h, radius: r, width: w)),
              ),
            ),
    ],
  );
}

Row sendProfileCrm(
    BuildContext context, CeremonyModel widget, double w, double h, double r) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.userFid.avater!.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: widget.userFid.avater!,
                      url: '/profile/',
                      username: widget.userFid.username!,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: DefaultAvater(height: h, radius: r, width: w)),
            ),
      widget.userSid.avater!.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: widget.userSid.avater!,
                      url: '/profile/',
                      username: widget.userSid.username!,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(r),
                    ),
                    child: DefaultAvater(height: h, radius: r, width: w)),
              ),
            ),
    ],
  );
}

Row kichernPartProfileCrm(
    BuildContext context, CeremonyModel widget, double w, double h, double r) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.userFid.avater!.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: widget.userFid.avater!,
                      url: '/profile/',
                      username: widget.userFid.username!,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: DefaultAvater(height: h, radius: r, width: w)),
            ),
      widget.userSid.avater!.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(r),
                  ),
                  child: UserAvater(
                      avater: widget.userSid.avater!,
                      url: '/profile/',
                      username: widget.userSid.username!,
                      height: h,
                      width: w),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: OColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(r),
                    ),
                    child: DefaultAvater(height: h, radius: r, width: w)),
              ),
            ),
    ],
  );
}

Container birthdayProfileCrm(
    BuildContext context, CeremonyModel widget, double w, double h, double r) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: OColors.primary, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(r),
        ),
        child: UserAvater(
            avater: widget.cImage,
            url: '/ceremony/',
            username: widget.userFid.username!,
            height: h,
            width: w),
      ),
    ),
  );
}

Container kigodoroProfileCrm(
    BuildContext context, CeremonyModel itm, double w, double h, double r) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: OColors.primary, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(r),
        ),
        child: UserAvater(
            avater: itm.cImage,
            url: '/ceremony/',
            username: itm.userFid.username!,
            height: h,
            width: w),
      ),
    ),
  );
}
