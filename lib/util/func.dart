import 'package:flutter/material.dart';

import '../model/post/post.dart';
import '../widgets/listTile_widget.dart';
import 'colors.dart';

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

void oneButtonPressed(context) {
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Commetee && Participants',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  // SizedBox(height: 5),

                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 150,
                        itemBuilder: (BuildContext context, index) {
                          return const SingleChildScrollView(
                              child: ListMembers());
                        }),
                  ),
                ],
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
