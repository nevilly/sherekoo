import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../../model/services/postServices.dart';
import '../../model/services/svModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../bsnScreen/bsnScrn.dart';

class CrmnAdmin extends StatefulWidget {
  final CeremonyModel crm;

  const CrmnAdmin({Key? key, required this.crm}) : super(key: key);

  @override
  State<CrmnAdmin> createState() => _CrmnAdminState();
}

class _CrmnAdminState extends State<CrmnAdmin> {
  final Preferences _preferences = Preferences();

  String token = '';

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // getUser();
        getInvatation();
      });
    });
  }

  List<SvModel> bsnInfo = [];

  getInvatation() async {
    Services(
            hostId: '',
            busnessId: '',
            contact: '',
            ceremonyId: '',
            createdBy: '',
            status: 0,
            payload: [],
            type: 'ceremony')
        .getInvataions(token, urlGetInvatation, widget.crm.cId)
        .then((v) {
      // print('check the payload brother');

      if (v.status == 200) {
        setState(() {
          bsnInfo = v.payload.map<SvModel>((e) => SvModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: const Text('InvitationNeh'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: bsnInfo.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(top: 5),
            child: ListTile(
              tileColor: OColors.darGrey,
              horizontalTitleGap: 8,
              leading: Image.network(
                '${api}public/uploads/${bsnInfo[i].bsnUsername}/busness/${bsnInfo[i].coProfile}',
                height: 70,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                '${bsnInfo[i].price} Tsh',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: OColors.fontColor),
              ),
              subtitle: Text(
                '${bsnInfo[i].busnessType} : ${bsnInfo[i].knownAs} ',
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: OColors.fontColor),
              ),
              trailing: Text(
                'Pending',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: OColors.primary),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BusnessScreen(
                        bsnType: 'all',
                        ceremony: widget.crm,
                      )));
        },
        // splashColor: Colors.yellow,

        // icon: const Icon(Icons.upload, color: Colors.white),
        label: const Text('invite'),

        backgroundColor: OColors.primary,
      ),
    );
  }
}
