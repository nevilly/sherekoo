import 'package:flutter/material.dart';

import '../../model/crmPackage/crmPackage.dart';
import '../../model/crmPackage/crmPackageModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import 'selectList.dart';

class CrmPckList extends StatefulWidget {
  const CrmPckList({Key? key}) : super(key: key);

  @override
  State<CrmPckList> createState() => _CrmPckListState();
}

class _CrmPckListState extends State<CrmPckList> {
  final Preferences _preferences = Preferences();
  String token = '';

  List<CrmPckModel> pck = [];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getlatestPackage();
        // getCrmBundle();
      });
    });
    super.initState();
  }

  getlatestPackage() {
    CrmPackage(payload: [], status: 0)
        .get(token, urlGetCrmPackage)
        .then((value) {
      if (value.status == 200) {
        final v = value.payload;
        setState(() {
          pck = v.map<CrmPckModel>((e) => CrmPckModel.fromJson(e)).toList();
        });
      }
    });
  }

  activatePackage(BuildContext context, CrmPckModel itm) {
    CrmPackage(payload: [], status: 0)
        .activate(token, urlActivateCrmPackage, itm.id, itm.status)
        .then((value) {
      if (value.status == 200) {
     
        setState(() {
          // pck = v.map<CrmPckModel>((e) => CrmPckModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bundle List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pck.length,
                itemBuilder: (BuildContext context, i) {
                  final itm = pck[i];
                  return PackageList(
                    itm: itm,
                  );
                }),
          )
        ],
      ),
    );
  }
}
