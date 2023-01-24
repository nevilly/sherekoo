import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/crmBundle/bundle.dart';
import '../../model/crmBundle/crmbundle-call.dart';
import '../../model/user/userModel.dart';
import '../../screens/ourServices/srvDetails.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

class SearchBundle extends StatefulWidget {
  final User currentUser;
  final String inYear;
  const SearchBundle(
      {Key? key, required this.currentUser, required this.inYear})
      : super(key: key);

  @override
  State<SearchBundle> createState() => _SearchBundleState();
}

class _SearchBundleState extends State<SearchBundle> {
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
  List<Bundle> _all = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getUser();
        // getCeremony();
        getCrmBundle();
      });
    });

    super.initState();
  }

  getCrmBundle() async {
    CrmBundleCall(payload: [], status: 0)
        .get(token, urlGetCrmBundle)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          _all = value.payload.map<Bundle>((e) => Bundle.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Bundle>(
      optionsBuilder: (TextEditingValue value) {
        // When the field is empty
        if (value.text.isEmpty) {
          return [];
        }

        // The logic to find out which ones should appear
        return _all
            .where((bundle) =>
                bundle.price.toLowerCase().contains(value.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (Bundle option) => option.price,
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
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
            hintText: "Your Bundle Price ..",
          ),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
      },

      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<Bundle> onSelected, Iterable<Bundle> options) {
        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: OColors.secondary,
            child: StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(10.0),
              itemCount: options.length,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1,
              mainAxisSpacing: 2,
              crossAxisCount: 4,
              shrinkWrap: true,
              staggeredTileBuilder: (index) {
                return const StaggeredTile.fit(2);
              },
              itemBuilder: (BuildContext context, int index) {
                final Bundle option = options.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    // onSelected(option);
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ServiceDetails(
                                crm: emptyCrmModel,
                                bundle: options.elementAt(index),
                                currentUser: widget.currentUser)));
                  },
                  child: Column(
                    children: [
                      Container(
                        child: option.bImage != ''
                            ? Center(
                                child: fadeImg(
                                    context,
                                    '${api}public/uploads/sherekooAdmin/crmBundle/${option.bImage}',
                                    MediaQuery.of(context).size.width,
                                    85,
                                    BoxFit.cover),
                              )
                            : const SizedBox(height: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: OColors.darGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: Text('${option.price} Tsh',
                                    style: header13)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(option.bundleType, style: header12),
                            option.ownerName != ''
                                ? Text(option.ownerName, style: header12)
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.black.withOpacity(0.24),
                        thickness: 1.0,
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
