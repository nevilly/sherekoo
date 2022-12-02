import 'package:flutter/material.dart';
import '../../model/allData.dart';
import '../../model/chats/chatPost.dart';
import '../../model/chats/chatsModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class ChatSettings extends StatefulWidget {
  final ChatsModel chat;
  final String fromScrn;
  const ChatSettings({Key? key, required this.chat, required this.fromScrn})
      : super(key: key);

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  final String title = 'Report';

  final Preferences _preferences = Preferences();
  String token = '';

  late User user = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        widget.chat.userId != ''
            ? getUser('$urlGetUser/${widget.chat.userId}')
            : getUser(urlGetUser);
      });
    });

    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  List gender = [
    "Hate Speech",
    "Harrashment or bullying",
    "Mislaeading information",
    "Ponography & nudity",
    "Violent & graphic contents",
    "Scams & Frauds",
    "Spam",
    "Dangerous organization/individuals",
    "Other"
  ];
  String select = "";
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: OColors.primary,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value!;
            });
          },
        ),
        Text(title, style: TextStyle(color: OColors.fontColor, fontSize: 16))
      ],
    );
  }

  deletePost(BuildContext context) {
    if (widget.fromScrn == 'mshengaChat') {
      PostAllChats(
        payload: [],
        status: 0,
        body: '',
        postId: widget.chat.id,
        userId: '',
      ).deleteChat(token, urlMshengaRemoveChat).then((value) {
        // final v = value.payload;
        if (value.status == 200) {
           Navigator.of(context).pop();
          //    Navigator.of(context).pop();
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (BuildContext context) =>  MshengaWarWall(currentUser: user, show: null,)));
          // print(v);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: OColors.secondary,
        title: user.isCurrentUser == true
            ? const Text('Settings')
            : const Text('Report'),
      ),
      body: user.id!.isNotEmpty
          ?
          
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user.isCurrentUser != true
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 19.0, top: 8.0, bottom: 8.0),
                        child: Text('Select a reason',
                            style: TextStyle(
                                color: OColors.fontColor, fontSize: 16)))
                    : const SizedBox(),
                user.isCurrentUser == true
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Edit chat',
                                  style: TextStyle(color: OColors.fontColor)),
                              onTap: () {
                                // Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) => const LiveEve()));
                              },
                            ),
                            ListTile(
                              title: Text('Delete chat',
                                  style: TextStyle(color: OColors.fontColor)),
                              onTap: () {
                                // Navigator.of(context).pop();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) => const LiveEve()));

                                errorAlertDialog(context, 'Delete',
                                    'Are Sure you want to Delete...?');
                              },
                            ),
                          ],
                        ),
                      )
                    : // Radio Button
                    Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: SizedBox(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                addRadioButton(0, 'Hate Speech'),
                                addRadioButton(1, 'Harrashment or bullying'),
                                addRadioButton(2, 'Mislaeading information'),
                                addRadioButton(3, 'Ponography & nudity'),
                                addRadioButton(4, 'Violent & graphic contents'),
                                addRadioButton(5, 'Scams & Frauds'),
                                addRadioButton(6, 'Spam'),
                                addRadioButton(
                                    7, 'Dangerous organization/individuals'),
                                addRadioButton(8, 'Others'),
                              ],
                            ),
                          ),
                        ),
                      ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            color: OColors.darGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Cancel',
                            style: TextStyle(color: OColors.fontColor),
                          )),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            color: OColors.primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Submit',
                                  style: TextStyle(color: OColors.fontColor))),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                loadingFunc(20, prmry),
              ],
            ),
    
    );
  }

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
        deletePost(context);
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
}
