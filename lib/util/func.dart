import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:sherekoo/model/user/userModel.dart';

import '../model/ceremony/crm-model.dart';
import '../model/ceremony/crmVwr-model.dart';

import '../screens/payments/payments.dart';
import '../widgets/imgWigdets/defaultAvater.dart';
import '../widgets/imgWigdets/userAvater.dart';
import '../widgets/listTile_widget.dart';
import 'Locale.dart';
import 'colors.dart';
import 'textStyle-pallet.dart';
import 'util.dart';

List<CrmViewersModel> crmViewer = [];

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

///
/// Languege Dictionary
///

l(bool isSwahili, position) {
  return OLocale(isSwahili, position).get();
}

/// Buttons
///
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

Container ourServices(BuildContext context, String prod) {
  return Container(
    margin: const EdgeInsets.only(left: 4, right: 4),
    height: 20,
    padding: const EdgeInsets.only(left: 10.0, right: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 1.3, color: OColors.primary),
        borderRadius: BorderRadius.circular(20)),
    child: Center(
      child: Text(
        prod,
        style: header12.copyWith(color: OColors.primary),
      ),
    ),
  );
}

Container flatButton(
    BuildContext context,
    String text,
    TextStyle style,
    double h,
    double w,
    Color backgroundColor,
    double radCircular,
    double marginTop,
    double marginbtn) {
  return Container(
    width: w,
    height: h,
    margin:
        EdgeInsets.only(left: 10, right: 10, top: marginTop, bottom: marginbtn),
    padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radCircular)),
        border: Border.all(color: OColors.primary)),
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Text(
        text,
        style: style,
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

Padding hashTagFunc(context, String title, String hashTag) {
  return Padding(
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

///
///Griv Viewer
///

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

///
///Loading
///

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

///
///
//Ceremony Profile
Row weddingProfile(BuildContext context, widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      widget.ceremony.userFid.avater.isNotEmpty
          ? Padding(
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
            )
          : Container(
              decoration: BoxDecoration(
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
            )
          : Container(
              decoration: BoxDecoration(
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
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
                // gradient: LinearGradient(
                //   colors: [
                //     OColors.primary2,
                //     OColors.darGrey,
                //     OColors.fontColor,
                //     // OColors.darGrey,
                //     OColors.primary2,
                //     OColors.darGrey,
                //     OColors.primary,
                //   ],
                // ),
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
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

//Ceremony Account Creating
Container accountForBdayKgodoro(BuildContext context, avater, uname,
    String drUrl, double w, double h, double r) {
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
            avater: avater, url: drUrl, username: uname, height: h, width: w),
      ),
    ),
  );
}

///
///PersonalProfile
///

Column personalProfile(BuildContext context, String avater, String url,
    Widget info1, double r, double w, double h) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(r)),
        child: avater != ''
            ? CircleAvatar(
                radius: r, child: fadeImg(context, url, w, h, BoxFit.fitWidth))
            : ClipOval(
                child: DefaultAvater(
                    height: MediaQuery.of(context).size.height / h,
                    radius: r,
                    width: MediaQuery.of(context).size.width / w)),
      ),
      info1,
    ],
  );
}

Column personProfileClipOval(BuildContext context, String avater, String url,
    Widget info1, double r, double w, double h, Color bkColor) {
  return Column(
    children: [
      avater != ''
          ? CircleAvatar(
              backgroundColor: bkColor,
              radius: r,
              child:
                  ClipOval(child: fadeImg(context, url, w, h, BoxFit.fitWidth)))
          : CircleAvatar(
              backgroundColor: bkColor,
              radius: r,
              child: ClipOval(
                  child: DefaultAvater(height: h, radius: r, width: w))),
      info1,
    ],
  );
}

Column infoPersonalProfile(String uname, TextStyle unameStyle1, String talent,
    TextStyle talentStyle, double sbHeight1, double sbHeight2) {
  return Column(
    children: [
      SizedBox(
        height: sbHeight1,
      ),
      Text(
        uname,
        style: unameStyle1,
      ),
      SizedBox(
        height: sbHeight2,
      ),
      Text(talent, style: talentStyle),
    ],
  );
}

///
/// Uploading
/// Image Croping
Future cropImage(File imageFile) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Shereko Cropper',
          toolbarColor: OColors.appBarColor,
          toolbarWidgetColor: OColors.primary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Sherekoo Cropper',
      ),
      // WebUiSettings(
      //   context: context,
      // ),
    ],
  );
  if (croppedFile == null) return null;
  return File(croppedFile.path);
}

// Fade Image
FadeInImage profilefadeImg(
    BuildContext context, img, double w, double h, BoxFit fit) {
  return FadeInImage(
    image: NetworkImage(img),
    fadeInDuration: const Duration(milliseconds: 100),
    placeholder: const AssetImage('assets/logo/noimage.png'),
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset(
        'assets/logo/noimage.png',
        width: w,
        height: h,
        fit: fit,
        color: OColors.darGrey,
      );
    },
    width: w,
    height: h,
    fit: BoxFit.cover,
  );
}

FadeInImage fadeImg(BuildContext context, img, double w, double h, BoxFit fit) {
  return FadeInImage(
    image: NetworkImage(img),
    fadeInDuration: const Duration(milliseconds: 100),
    placeholder: const AssetImage('assets/logo/noimage.png'),
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset('assets/logo/noimage.png',
          width: w, height: h, fit: fit);
    },
    width: w,
    height: h,
    fit: BoxFit.cover,
  );
}

///
/// Alert Widget
///

//Errors Alerts
fillTheBlanks(context, String title, TextStyle style, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: style,
        ),
        backgroundColor: color),
  );
}

// Alert Desing 1
errorAlertDialog(BuildContext context, String title, String msg) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("cancel",
        style: TextStyle(
          color: OColors.primary,
        )),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget continueButton = TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(6),
      primary: OColors.fontColor,
      backgroundColor: OColors.primary,
      textStyle: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
    ),
    child: const Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // insetPadding: const EdgeInsets.only(left: 20, right: 20),
    // contentPadding: EdgeInsets.zero,
    // titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
    backgroundColor: OColors.secondary,
    title: Center(
      child: Text(title, style: header18),
    ),
    content: Text(msg, style: header12),
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

// Alert Desing 2
showAlertDialog(BuildContext context, Widget title, Widget content,
    Widget cancelButton, Widget continueButton) async {
  AlertDialog alert = AlertDialog(
    insetPadding: const EdgeInsets.only(right: 1, left: 1),
    contentPadding: EdgeInsets.zero,
    titlePadding: const EdgeInsets.only(top: 5),
    backgroundColor: OColors.secondary,
    actionsPadding: EdgeInsets.zero,
    title: title,
    content: content,
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Navigator.of(context).pop();
      return alert;
    },
  );
}

Column crmColorCode(BuildContext context, Color color, double r, double w,
    double h, title, TextStyle header) {
  return Column(
    children: [
      Container(
        width: w,
        height: h,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(r)),
      ),
      const SizedBox(
        height: 2,
      ),
      Text(
        title,
        style: header,
      )
    ],
  );
}

//Dialog title
Row titleDIalog(BuildContext context, String title) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.close,
          size: 15,
          color: OColors.fontColor,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
      child: Text(title,
          style: header18.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
    ),
  ]);
}

//Dialog set up the buttons
Widget dialogButton(BuildContext context, text, ButtonStyle bttnStyl, funct) {
  return TextButton(
    style: bttnStyl,
    onPressed: () {
      funct;
    },
    child: Text(
      text,
      style: header13.copyWith(
          fontWeight: FontWeight.normal, color: OColors.fontColor),
    ),
  );
}

ButtonStyle bttnStyl(double padding, Color backgroundColorlor, Color primary) {
  return TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      primary: primary,
      backgroundColor: backgroundColorlor);
}

// Payment Method Alert Widget
paymentMethod(BuildContext context, CrmViewersModel itm, User user) async {
  // set up the buttons

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // insetPadding: const EdgeInsets.only(right: 1, left: 1),
    contentPadding: const EdgeInsets.only(left: 20, right: 20),
    titlePadding: const EdgeInsets.only(top: 5),
    backgroundColor: OColors.secondary,
    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.close,
            size: 35,
            color: OColors.fontColor,
          ),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 10, top: 8, bottom: 8),
        child: Center(
          child: Text('Payment Method',
              style: header18.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    ]),
    content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vodacom
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Payments(
                                    crmVwr: itm,
                                    user: user,
                                  )));
                    },
                    child: Text('Vodacom', style: header14)),
                //Airtel
                Text('Airtel', style: header14),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Tigo
                Text('tigo', style: header14),
                //Halotel
                Text('Halotel', style: header14),
                // Text('TTcl',style:header16),
              ],
            ),
          ],
        )),
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

///
/// TextField Template
///
Container textFieldContainer(
    BuildContext context,
    String subtitle,
    TextEditingController controller,
    double w,
    double h,
    double topPadding,
    double radius,
    Color bkcolor,
    prefixIco,
    TextStyle style,
    TextInputType kyboard) {
  return Container(
    width: w,
    height: h,
    padding: EdgeInsets.only(
      top: topPadding,
    ),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(radius),
        color: bkcolor),
    child: TextField(
      controller: controller,
      maxLines: null,
      expands: true,
      textAlign: TextAlign.left,
      keyboardType: kyboard,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
        border: InputBorder.none,
        prefixIcon: prefixIco,
        hintText: subtitle,
        hintStyle: style,
      ),
      style: style,
      onChanged: (value) {},
    ),
  );
}

emptyField(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

// Date
dateDialog(BuildContext context, dateController, double w, double h, double r,
    Color bckColor, TextStyle style) {
  return Container(
    width: w,
    height: h,
    margin: const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(r),
        color: bckColor),
    child: TextField(
      focusNode: AlwaysDisabledFocusNode(),
      controller: dateController,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.calendar_month,
            size: 23,
            color: OColors.primary,
          ),
        ),
        hintText: 'Date ( DD/MM/YYY )',
        hintStyle: style,
      ),
      style: style,
      onTap: () {
        _selectDate(context, dateController);
      },
    ),
  );
}

// Date Show
DateTime? _selectedDate;
_selectDate(BuildContext context, textEditingController) async {
  DateTime? newSelectedDate = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      fieldHintText: 'yyyy/mm/dd',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: OColors.darkGrey,
              onPrimary: Colors.white,
              surface: OColors.secondary,
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor: OColors.darGrey,
          ),
          child: child as Widget,
        );
      });

  if (newSelectedDate != null) {
    _selectedDate = newSelectedDate;
    textEditingController
      ..text = DateFormat('yyyy/MM/dd').format(_selectedDate!)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: textEditingController.text.length,
          affinity: TextAffinity.upstream));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

/// understanif GLOBAL SETSTATE
// void setState(Null Function() param0) {
//   print('has shown');

// }
