import 'package:flutter/material.dart';

import '../../model/user/user-call.dart';
import '../../model/user/userCrmVwr-model.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';

class Addmember extends StatefulWidget {
  const Addmember({Key? key}) : super(key: key);

  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
  final TextEditingController _ahadi = TextEditingController();
  List<UserCrmVwr> data = [];
  @override
  void initState() {
    super.initState();

    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getservices();
        // getBudget('$urlGetCrmBudget/${widget.crm.cId}');
        // getAllRequests();

        // getViewers();
        getAll();
      });
    });
  }

  getAll() async {
    UsersCall(payload: [], status: 0)
        .get(token, urlUserCrmVwr)
        .then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          data = value.payload
              .map<UserCrmVwr>((e) => UserCrmVwr.fromJson(e))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(title: Text('data')),
        body: Column(
          children: [
            Autocomplete<UserCrmVwr>(
              optionsBuilder: (TextEditingValue value) {
                // When the field is empty
                if (value.text.isEmpty) {
                  return [];
                }

                // The logic to find out which ones should appear
                return data
                    .where((d) => d.phoneNo!
                        .toLowerCase()
                        .contains(value.text.toLowerCase()))
                    .toList();
              },
              displayStringForOption: (UserCrmVwr option) => option.username!,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 18),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: OColors.primary, fontSize: 14, height: 1.5),
                    hintText: "Search phone Numbers..",
                  ),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: OColors.fontColor),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<UserCrmVwr> onSelected,
                  Iterable<UserCrmVwr> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: size.width,
                      color: OColors.secondary,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final UserCrmVwr option = options.elementAt(index);

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    width: 35,
                                    height: 35,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: option.avater != ''
                                        ? fadeImg(
                                            context,
                                            '${api}public/uploads/${option.username}/profile/${option.avater}',
                                            40.0,
                                            40.0)
                                        : const DefaultAvater(
                                            height: 40, radius: 3, width: 40),
                                  ),
                                  title: Text(option.username!,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  subtitle: Text(option.phoneNo!,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  trailing: GestureDetector(
                                    onTap: () {
                                     // addAhadi(context, '', '', option, '');
                                       showAlertDialog(
          context,
          "You already have  ",
          "Would like to Select another .. ?",
          '',
          'requests');
                                      // something(context, option);
                                    },
                                    child: const Text('Add',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  height: 1.0,
                                  color: Colors.black.withOpacity(0.24),
                                  thickness: 1.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              // onSelected: (UserCrmVwr selection) {
              //   CrmViewersModel cvInf = selection.crmVwrInfo;
              //   setState(() {
              //     avater = selection.avater!;
              //     uname = selection.username!;
              //     contact = selection.phoneNo!;
              //     // position = '';
              //     // ahadi = '';

              //     crmViewer.add(CrmViewersModel(
              //       id: cvInf.id,
              //       userId: cvInf.userId,
              //       crmId: cvInf.crmId,
              //       name: cvInf.name,
              //       contact: cvInf.contact,
              //       position: cvInf.position,
              //       crmInfo: emptyCrmModel,
              //       viewerInfo: User(
              //           id: selection.id,
              //           username: selection.username,
              //           firstname: selection.firstname,
              //           lastname: selection.lastname,
              //           avater: selection.avater,
              //           phoneNo: selection.phoneNo,
              //           email: selection.email,
              //           gender: selection.gender,
              //           role: selection.role,
              //           isCurrentUser: selection.isCurrentUser,
              //           address: selection.address,
              //           bio: selection.bio,
              //           meritalStatus: selection.meritalStatus,
              //           totalPost: '',
              //           isCurrentBsnAdmin: '',
              //           isCurrentCrmAdmin: '',
              //           totalFollowers: '',
              //           totalFollowing: '',
              //           totalLikes: ''),
              //       isAdmin: '',
              //     ));
              //   });
              // },
            ),
          ],
        ));
  }

  addAhadi(BuildContext context, String title, String msg, UserCrmVwr opt,
      String from) {
    // set up the buttons

    List<String> crmViwrPstn = ['Viewer', 'Friend', 'Relative'];
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
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
          padding: const EdgeInsets.only(left: 38.0, top: 8, bottom: 8),
          child: Text('Search',
              style:
                  header18.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ]),
      content: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(children: [
                    opt.avater != ''
                        ? fadeImg(
                            context,
                            '${api}public/uploads/${opt.username}/profile/${opt.avater}',
                            60.0,
                            60.0)
                        : const DefaultAvater(height: 60, radius: 3, width: 60),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(opt.username!,
                              style: header14.copyWith(
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(opt.phoneNo!, style: header12),
                        ],
                      ),
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: OColors.sPurple),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Builder(builder: (context) {
                          return DropdownButton<String>(
                            isExpanded: true,
                            // icon: const Icon(Icons.arrow_circle_down),
                            // iconSize: 20,
                            // elevation: 16,
                            underline: Container(),
                            items: crmViwrPstn.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Who is ?',
                                style: header12,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                // print(v);
                                subScrbAs = v!;
                              });
                            },
                          );
                        }),
                      ),
                      textFieldContainer(
                          context,
                          'ahadi',
                          _ahadi,
                          MediaQuery.of(context).size.width / 2.5,
                          30,
                          10,
                          10,
                          OColors.darGrey,
                          const Icon(Icons.currency_pound),
                          header12)
                    ],
                  ),
                ],
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // color: prmry,
                      ),
                      child: Text(
                        'Cancel',
                        style: header13,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // edtBgt(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: prmry,
                      ),
                      child: Text(
                        'Add budget',
                        style: header13,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("yes",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        if (from == 'requests') {
          Navigator.of(context).pop();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => MyService(
          //               req: req,
          //               user: widget.user,
          //             )));
        } else {
          Navigator.of(context).pop();
          // removeSelected(req.svId);
        }
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      child: const Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      content: Text(msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: OColors.fontColor)),
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

}
