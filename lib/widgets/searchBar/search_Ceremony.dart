import 'package:flutter/material.dart';

import '../../model/ceremony/crm-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../screens/detailScreen/livee.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class SearchCeremony extends StatefulWidget {
  const SearchCeremony({Key? key}) : super(key: key);

  @override
  State<SearchCeremony> createState() => _SearchCeremonyState();
}

class _SearchCeremonyState extends State<SearchCeremony> {
  final Preferences _preferences = Preferences();
  String token = '';

  late String ceremonyType = "";
  late String ceremonyId = "";
  late String ceremonyCodeNo = "";
  late String ceremonyDate = "";
  late String ceremonyContact = "";

  late String ceremonyAdimnId = "";
  late String ceremonyFid = "";
  late String ceremonySid = "";
  List<CeremonyModel> _allCeremony = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getUser();
        // getCeremony();
        getAllCeremony();
      });
    });

    super.initState();
  }

  getAllCeremony() async {
    CrmCall(payload: [], status: 0)
        .get(token, urlGetCeremony)
        .then((value) {
      setState(() {
        _allCeremony = value.payload
            .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CeremonyModel>(
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          return [];
        }

        // The logic to find out which ones should appear
        return _allCeremony
            .where((ceremony) => ceremony.codeNo
                .toLowerCase()
                .contains(value.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (CeremonyModel option) => option.codeNo,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 8),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
            hintText: "Ceremony ..",
          ),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
      },

      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CeremonyModel> onSelected,
          Iterable<CeremonyModel> options) {
        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: OColors.secondary,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final CeremonyModel option = options.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Livee(
                                  ceremony: option,
                                )));
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(right: 10),
                            child: option.cImage != ''
                                ? Image.network(
                                    '${api}public/uploads/${option.userFid.username}/ceremony/${option.cImage}',
                                    fit: BoxFit.cover,
                                    height: 45,
                                  )
                                : const SizedBox(height: 1),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(option.codeNo,
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(option.ceremonyType,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic))
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
                );
              },
            ),
          ),
        );
      },

      // onSelected: (CeremonyModel selection) {
      //   setState(() {
      //     ceremonyType = selection.ceremonyType;
      //     ceremonyId = selection.cId;
      //     ceremonyCodeNo = selection.codeNo;
      //     ceremonyDate = selection.ceremonyDate;
      //     ceremonyContact = selection.contact;

      //     ceremonyAdimnId = selection.admin;
      //     ceremonyFid = selection.fId;
      //     ceremonySid = selection.sId;
      //   });

      //   print('Selected: ${selection.codeNo}');
      //   print('fid: ${selection.fId}');
      //   print('sid: ${selection.sId}');
      //   print('Selected: ${selection.admin}');
      // },
    );
  }
}
