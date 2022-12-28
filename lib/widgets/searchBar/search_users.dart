import 'package:flutter/material.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({Key? key}) : super(key: key);

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final Preferences _preferences = Preferences();
  String token = '';

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
    UsersCall(payload: [], status: 0).get(token, urlUserList).then((value) {
      // print(value.payload);
      if (value.status == 200) {
        setState(() {
          data = value.payload.map<User>((e) => User.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          return [];
        }

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
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 18),
            border: InputBorder.none,
            hintStyle:
                TextStyle(color: OColors.primary, fontSize: 14, height: 1.5),
            hintText: "Search User..",
          ),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: OColors.fontColor),
        );
      },

      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,
              color: OColors.secondary,
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final User option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      // onSelected(option);
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HomeNav(
                                    user: option,
                                    getIndex: 3,
                                  )));
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                margin: const EdgeInsets.only(right: 10),
                                child: option.avater != ''
                                    ? Image.network(
                                        '${api}public/uploads/${option.username}/profile/${option.avater}',
                                        fit: BoxFit.cover,
                                        height: 40,
                                      )
                                    : const SizedBox(height: 1),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option.username!,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  // Text(option.busnessType,
                                  //     style: const TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 12,
                                  //         fontStyle: FontStyle.italic))
                                ],
                              )
                            ],
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
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },

      // onSelected: (BusnessModel selection) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (_) =>
      //               DetailPage(data: selection, ceremonyData: ceremony)));
      // setState(() {
      //   ceremonyType = selection.busnessType;
      //   ceremonyId = selection.bId;
      //   ceremonyCodeNo = selection.avater;
      //   ceremonyDate = selection.knownAs;
      // });

      // print('Selected: ${selection.knownAs}');
      // print('fid: ${selection.busnessType}');
      // print('sid: ${selection.sId}');
      // print('Selected: ${selection.admin}');
      // },
    );
  }
}
