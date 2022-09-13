import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../../model/services/postServices.dart';
import '../../model/services/svModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/animetedClip.dart';
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

  List<SvModel> mcReq = [];
  List<SvModel> productionReq = [];
  List<SvModel> decoratorReq = [];

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
        // print(v.payload);

        setState(() {
          mcReq = v.payload.map<SvModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Mc') {
              return SvModel.fromJson(e);
            }
            return SvModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          mcReq.removeWhere((element) => element.busnessId.isEmpty);

          //Production
          productionReq = v.payload.map<SvModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Production') {
              return SvModel.fromJson(e);
            }
            return SvModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          productionReq.removeWhere((element) => element.busnessId.isEmpty);

          //Decoration
          decoratorReq = v.payload.map<SvModel>((e) {
            // print(e);
            if (e['busnessType'] == 'Decorator') {
              return SvModel.fromJson(e);
            }
            return SvModel.fromJson({
              'hostId': '',
              'busnessId': '',
              'ceremonyId': '',
              'createdBy': '',
              'contact': '',
              'confirm': '',
              'createdDate': '',
              'coProfile': '',
              'knownAs': '',
              'price': '',
              'bsncontact': '',
              'busnessType': '',
              'bsncreatedBy': '',
              'bsnUsername': '',
              'level': '',
              'categoryId': '',
              'activeted': ''
            });
          }).toList();
          decoratorReq.removeWhere((element) => element.busnessId.isEmpty);
        });
      }
    });
  }

  bool _openMc = false;
  bool _openProd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: const Text('Invitation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // All Mc
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mc',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: OColors.fontColor)),
                        Text('Invited (${mcReq.length})',
                            style: TextStyle(color: OColors.fontColor)),
                        IconButton(
                            color: OColors.fontColor,
                            highlightColor: OColors.primary,
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() => _openMc ^= true);
                            },
                            icon: _openMc == false
                                ? Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor,
                                  )
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openMc,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mcReq.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.7),
                      itemBuilder: (context, i) {
                        final req = mcReq[i];
                        return Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 4.0,
                                    spreadRadius: 0.2,
                                    offset: Offset(0.1, 0.5)),
                              ],
                              color: OColors.darGrey),
                          child: Column(
                            children: [
                              Image.network(
                                '${api}public/uploads/${req.bsnUsername}/busness/${req.coProfile}',
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${req.price} Tsh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: OColors.fontColor),
                              ),
                              Text(
                                '${req.knownAs} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: OColors.fontColor),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.primary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            //Production
            Column(
              children: <Widget>[
                Container(
                  color: OColors.darkGrey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Production',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: OColors.fontColor)),
                        IconButton(
                            color: OColors.fontColor,
                            highlightColor: OColors.primary,
                            padding: const EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() => _openProd ^= true);
                            },
                            icon: _openProd == false
                                ? Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: OColors.fontColor,
                                  )
                                : Icon(Icons.keyboard_arrow_down,
                                    color: OColors.fontColor))
                      ],
                    ),
                  ),
                ),
                AnimatedClipRect(
                  open: _openProd,
                  horizontalAnimation: false,
                  verticalAnimation: true,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productionReq.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.7),
                      itemBuilder: (context, i) {
                        final req = productionReq[i];
                        return Container(
                          margin: const EdgeInsets.only(top: 2, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 4.0,
                                    spreadRadius: 0.2,
                                    offset: Offset(0.1, 0.5)),
                              ],
                              color: OColors.darGrey),
                          child: Column(
                            children: [
                              Image.network(
                                '${api}public/uploads/${req.bsnUsername}/busness/${req.coProfile}',
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${req.price} Tsh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: OColors.fontColor),
                              ),
                              Text(
                                '${req.knownAs} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: OColors.fontColor),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.primary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            // ALl Production

            // ALl Decorator

            decoratorReq.isNotEmpty
                ? Container(
                    color: Colors.red,
                    height: 180,
                    child: Column(
                      children: [
                        Container(
                          color: OColors.darkGrey,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Decorator',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: OColors.fontColor)),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: decoratorReq.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 0.7),
                            itemBuilder: (context, i) {
                              final req = decoratorReq[i];
                              return Card(
                                color: OColors.darGrey,
                                shadowColor: Colors.black,
                                margin: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    Image.network(
                                      '${api}public/uploads/${decoratorReq[i].bsnUsername}/busness/${decoratorReq[i].coProfile}',
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '${decoratorReq[i].price} Tsh',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: OColors.fontColor),
                                    ),
                                    Text(
                                      '${decoratorReq[i].knownAs} ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: OColors.fontColor),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Pending',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: OColors.primary),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
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
