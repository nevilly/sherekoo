import 'package:flutter/material.dart';

import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userCrmVwr-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';
import 'crmAdmin.dart';

class Addmember extends StatefulWidget {
  final UserCrmVwr option;
  final CeremonyModel crm;
  final User user;
  const Addmember(
      {Key? key, required this.option, required this.user, required this.crm})
      : super(key: key);

  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
  final TextEditingController _ahadi = TextEditingController();
  List<UserCrmVwr> data = [];
  List<String> crmViwrPstn = ['Viewer', 'Friend', 'Relative'];
  String whois = 'Who is ?';
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
      });
    });
  }

  // My all ceremonie post
  Future addViewer() async {
    if (whois != 'Who is ?') {
      await CrmCall(payload: [], status: 0)
          .addCrmnViewr(token, urlCrmAdminAddCrmViewrs, widget.crm.cId, whois,
              '', '', _ahadi.text, widget.option.id!)
          .then((value) {
        if (value.status == 200) {
          // print(value.payload);
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CrmnAdmin(
                        crm: widget.crm,
                        user: widget.user,
                      )));
        }
      });
    } else {
      // fillTheBlanks('Fill Subsribe as ... Please!');
      // print('fill who is');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(title: Text('Members', style: header16)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Member ',
                style: header16.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              children: [
                Row(children: [
                  widget.option.avater != ''
                      ? fadeImg(
                          context,
                          '${api}public/uploads/${widget.option.username}/profile/${widget.option.avater}',
                          80.0,
                          80.0,BoxFit.fitWidth)
                      : const DefaultAvater(height: 80, radius: 3, width: 80),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.option.username!,
                            style:
                                header15.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(widget.option.phoneNo!, style: header13),
                      ],
                    ),
                  )
                ]),
                const SizedBox(
                  height: 28,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Who is Member ?',
                          style:
                              header16.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: 160,
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
                              whois,
                              style: header12,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onChanged: (v) {
                            setState(() {
                              // print(v);
                              whois = v!;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Who is Member ?',
                          style:
                              header16.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    textFieldContainer(
                        context,
                        'ahadi',
                        _ahadi,
                        MediaQuery.of(context).size.width / 1.5,
                        40,
                        10,
                        10,
                        OColors.darGrey,
                        const Icon(Icons.currency_pound),
                        header12,TextInputType.phone)
                  ],
                ),
              ],
            ),
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
                        padding: const EdgeInsets.all(4),
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
                      // edtBgt(context);
                      addViewer();
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
            )
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
                            60.0,BoxFit.fitWidth)
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
                          header12,TextInputType.number)
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
