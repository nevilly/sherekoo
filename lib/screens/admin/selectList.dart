import 'package:flutter/material.dart';
import 'package:sherekoo/model/crmPackage/crmPackageModel.dart';

import '../../model/crmPackage/crmPackage.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';

class PackageList extends StatefulWidget {
  final CrmPckModel itm;
  const PackageList({Key? key, required this.itm}) : super(key: key);

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  final Preferences _preferences = Preferences();
  String token = '';
  String isActive = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        isActive = widget.itm.status;
        // getCrmBundle();
      });
    });
    super.initState();
  }

  activatePackage(BuildContext context, CrmPckModel itm) {
    CrmPackage(payload: [], status: 0)
        .activate(token, urlActivateCrmPackage, itm.id, isActive)
        .then((value) {
      if (value.status == 200) {
        print(isActive);
        final v = value.payload;

        // print(v);
        setState(() {
          if (isActive == 'false') {
            isActive = 'true';
          }

          if (isActive == 'true') {
            isActive = 'false';
          }
          print('after Change');
          print(isActive);

          // if (v == 'true') {
          //   isActive = 'false';
          // } else {
          //   isActive = 'true';
          // }
          // pck = v.map<CrmPckModel>((e) => CrmPckModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ListTile(
        leading: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(1.0),
              topRight: Radius.circular(1.0),
            ),
            child: widget.itm.pImage != ''
                ? Image.network(
                    '${api}public/uploads/sherekooAdmin/crmPackage/${widget.itm.pImage}',
                    height: 45,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(height: 1)),
        title: Text(
          widget.itm.title,
          style: header13.copyWith(color: Colors.grey),
        ),
        subtitle: GestureDetector(
          onTap: () {
            activatePackage(context, widget.itm);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isActive == 'true'
                  ? Text('Active Package',
                      style: header12.copyWith(color: Colors.grey))
                  : Text('UnActive',
                      style: header12.copyWith(color: Colors.grey)),
            ],
          ),
        ),
        trailing: SizedBox(
          width: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.update),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );
    });
  }
}
