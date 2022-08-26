import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/pallets.dart';

import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/crmViewerModel.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';

class CrmDoor extends StatefulWidget {
  final CeremonyModel crm;
  const CrmDoor({Key? key, required this.crm}) : super(key: key);

  @override
  State<CrmDoor> createState() => _CrmDoorState();
}

class _CrmDoorState extends State<CrmDoor> {
  String selectedBusness = 'Subscribe as ..?';
  final List<String> _busness = ['As Viewer', 'As: friend', 'As: Relative'];
  final Preferences _preferences = Preferences();
  String token = '';
  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        print(widget.crm.cName);
      });
    });
    super.initState();
  }

  // My all ceremonie post
  Future viewerExist(id) async {
    AllCeremonysModel(payload: [], status: 0)
        .getCrmViewr(token, urlGetCrmViewrs + "/userid/11")
        .then((value) {
      if (value.status == 200) {
        print(value.payload);
        // setState(() {
        //   crmV = value.payload
        //       .map<CrmViewersModel>((e) => CrmViewersModel.fromJson(e))
        //       .toList();
        // });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(backgroundColor: OColors.secondary, actions: const []),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Stack(children: [
              Positioned(
                  top: 25,
                  left: 15,
                  child: Image.asset('assets/logo/heart.png')),
              Positioned(
                  top: 25,
                  right: 15,
                  child: Image.asset('assets/logo/heart.png')),
              Positioned(
                  bottom: 25,
                  right: 20,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 30,
                    height: 30,
                  )),
              Positioned(
                  bottom: 100,
                  right: 30,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 20,
                    height: 20,
                  )),
              Positioned(
                  bottom: 80,
                  left: 30,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 20,
                    height: 20,
                  )),
              Positioned(
                  top: 38,
                  right: 80,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 20,
                    height: 20,
                  )),
              Positioned(
                  top: 10,
                  left: 150,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 20,
                    height: 20,
                  )),
              Positioned(
                  bottom: 6,
                  left: 120,
                  child: Image.asset(
                    'assets/logo/heart.png',
                    width: 40,
                    height: 40,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: OColors.primary,
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: widget.crm.cImage != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    api +
                                        'public/uploads/' +
                                        widget.crm.u1 +
                                        '/ceremony/' +
                                        widget.crm.cImage,
                                  ),
                                ),
                              )
                            : const SizedBox(height: 1)),
                  ),
                ],
              )
            ]),
          ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.crm.cName,
              style: h4.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'On: ' + widget.crm.ceremonyDate,
              style: h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: OColors.primaryy),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              // icon: const Icon(Icons.arrow_circle_down),
              // iconSize: 20,
              // elevation: 16,
              underline: Container(),
              items: _busness.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Container(
                alignment: Alignment.center,
                child: Text(
                  selectedBusness,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onChanged: (v) {
                setState(() {
                  // print(v);
                  selectedBusness = v!;
                });
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.crm.codeNo,
                  style: h4.copyWith(color: OColors.sYelow),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                  bottom: 15,
                ),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: OColors.sPurple,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
