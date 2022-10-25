import 'package:flutter/material.dart';
import 'package:sherekoo/util/func.dart';

import '../model/ceremony/allCeremony.dart';
import '../model/ceremony/crmViewerModel.dart';
import '../util/Preferences.dart';
import '../util/appWords.dart';
import '../util/colors.dart';
import '../util/textStyle-pallet.dart';
import '../util/util.dart';
import 'imgWigdets/userAvater.dart';

class ListMembers extends StatefulWidget {
  final List<CrmViewersModel> list;
  final CrmViewersModel data;
  final Function removeFunc;

  const ListMembers({
    Key? key,
    required this.data,
    required this.list,
    required this.removeFunc,
  }) : super(key: key);

  @override
  State<ListMembers> createState() => _ListMembersState();
}

class _ListMembersState extends State<ListMembers> {
  bool edit = false;

  final Preferences _preferences = Preferences();
  String token = '';
  String position = '';

  // TextEditingController phoneNo = TextEditingController();

  String viewerPosition = 'Admin';

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        position = widget.data.position;
      });
    });

    super.initState();
  }

  updateViewers(crmViewerId) async {
    if (viewerPositionMsg != 'Admin') {
      AllCeremonysModel(
        status: 0,
        payload: [],
      )
          .updateCrmViewer(
              token, urlUpdateCrmViewerPostion, crmViewerId, viewerPosition)
          .then((value) {
        if (value.status == 200) {
          setState(() {
            edit = false;
            position = viewerPosition;
          });
        }
      });
    } else {
    
      fillTheBlanks(context,viewerPositionMsg,altSty,odng);
    
    }
  }

  deleteViewers(context, crmViewerId, userId) async {
    AllCeremonysModel(
      status: 0,
      payload: [],
    )
        .removeCrmViewer(token, urlRemoveCrmViewrs, crmViewerId, userId)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          edit = false;
          Navigator.of(context).pop();

          // widget.removeFunc(int.parse(widget.data.id));
          crmViewer.removeWhere((element) => element.id == crmViewerId);

          /// Inspiration tutorial
          /// https://stackoverflow.com/questions/70763536/how-to-i-delete-a-listtile-in-its-own-stateful-widget-from-a-list-in-another-sta
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: OColors.primary,
        child: widget.data.viewerInfo.avater!.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: OColors.primary,
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipOval(
                    child: UserAvater(
                      avater: widget.data.viewerInfo.avater!,
                      url: '/profile/',
                      username: widget.data.viewerInfo.username!,
                      width: 85.0,
                      height: 85.0,
                    ),
                  ),
                ),
              )
            : const Icon(Icons.person),
      ),
      title: edit == false
          ? Text(
              widget.data.viewerInfo.username!,
              style: header16,
            )
          : Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: OColors.primary)),
              child: DropdownButton<String>(
                dropdownColor: OColors.darGrey,
                isExpanded: true,
                // icon: const Icon(Icons.arrow_circle_down),
                // iconSize: 20,
                // elevation: 16,
                underline: Container(),
                items: viewerPositionList.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: header10.copyWith(
                            color: OColors.fontColor,
                          )));
                }).toList(),

                hint: Container(
                  alignment: Alignment.center,
                  child: Text(viewerPosition,
                      textAlign: TextAlign.center, style: header11),
                ),
                onChanged: (value) {
                  setState(() {
                    viewerPosition = value!;
                  });
                },
              ),
            ),
      subtitle: edit == false
          ? Text(position, style: header10.copyWith(color: Colors.grey))
          : const SizedBox.shrink(),
      trailing: edit == false
          ? SizedBox(
              width: MediaQuery.of(context).size.width / 4.6,
              child: Column(
                children: [
                  widget.data.isAdmin == 'true'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (edit) {
                                        edit = false;
                                      } else {
                                        edit = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: OColors.primary, width: 1)),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 17,
                                      color: OColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAlertDialog(
                                        context,
                                        'Detele',
                                        'Are SURE you want remove ..??',
                                        widget.data.id,
                                        widget.data.userId);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: OColors.primary, width: 1)),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.delete,
                                      size: 19,
                                      color: OColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: OColors.primary, width: 1)),
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: Text(
                                  'follow+',
                                  style:
                                      header11.copyWith(color: OColors.primary),
                                ),
                              ),
                            )
                          ],
                        )
                      : Text(
                          'follow+',
                          style: header13.copyWith(color: OColors.primary),
                        )
                ],
              ),
            )
          : SizedBox(
              // color: Colors.green,
              width: MediaQuery.of(context).size.width / 7.0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      updateViewers(widget.data.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: OColors.primary),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Update',
                          style: header10.copyWith(color: OColors.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (edit) {
                          edit = false;
                        } else {
                          edit = true;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: OColors.primary),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Cancel',
                            style: header10.copyWith(color: OColors.primary),
                          )),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // Alert Widget
  showAlertDialog(BuildContext context, String title, String msg, String id,
      String userId) async {
    // set up the buttons
    Widget ceremonyButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        // textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: Text("No", style: header13),
      onPressed: () {},
    );
    Widget busnessButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: Text(
        "Yes",
        style: header13,
      ),
      onPressed: () {
        deleteViewers(context, id, userId);
      },
    );

    Widget setting = Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.settings,
          color: OColors.primary,
          size: 20,
        ));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      content: Text(
        msg,
        style: header11,
      ),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ceremonyButton,
                busnessButton,
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(onTap: () {}, child: setting),
              ],
            ),
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
}
