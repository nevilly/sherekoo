import 'package:flutter/material.dart';
import 'package:sherekoo/screens/detailScreen/bsn-details.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/allData.dart';
import '../../model/busness/busnessModel.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../util/modInstance.dart';
import '../../util/util.dart';

class SearchBusness extends StatefulWidget {
  final CeremonyModel ceremony;
  const SearchBusness({Key? key, required this.ceremony}) : super(key: key);

  @override
  State<SearchBusness> createState() => _SearchBusnessState();
}

class _SearchBusnessState extends State<SearchBusness> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<BusnessModel> data = [];

  
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        ceremony = widget.ceremony;
        getAll();
      });
    });

    super.initState();
  }

  getAll() async {
    //
    AllUsersModel(payload: [], status: 0)
        .get(token, urlAllBusnessList)
        .then((value) {
      if (value.status == 200) {
          //  print('value.payloadddddd');
          // print(value.payload);
        setState(() {
       
          data = value.payload.map<BusnessModel>((e) {
            return BusnessModel.fromJson(e);
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<BusnessModel>(
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          return [];
        }

        // The logic to find out which ones should appear
        return data
            .where((d) =>
                d.knownAs.toLowerCase().contains(value.text.toLowerCase()))
            .toList();
      },

      displayStringForOption: (BusnessModel option) => option.knownAs,
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
            hintText: "Search Busness..",
          ),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: OColors.fontColor),
        );
      },

      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<BusnessModel> onSelected,
          Iterable<BusnessModel> options) {
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
                  final BusnessModel option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      // onSelected(option);
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BsnDetails(
                                  data: option, ceremonyData: ceremony)));
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
                                child: option.coProfile != ''
                                    ? Image.network(
                                        '${api}public/uploads/${option.user.username}/busness/${option.coProfile}',
                                        fit: BoxFit.cover,
                                        height: 40,
                                      )
                                    : const SizedBox(height: 1),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option.knownAs,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(option.busnessType,
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
