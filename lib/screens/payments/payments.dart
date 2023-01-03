import 'package:flutter/material.dart';
import 'package:sherekoo/model/mchango/mchango-call.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/ceremony/crmVwr-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../admin/crmAdmin.dart';

class Payments extends StatefulWidget {
  final CrmViewersModel crmVwr;
  final User user;
  const Payments({Key? key, required this.crmVwr, required this.user})
      : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  int crmPromise = 0;
  int crmContribution = 0;
  int crmVwrDept = 0;

  TextStyle payHdr1 = header14;
  TextStyle payHdr2 = header12;
  @override
  void initState() {
    super.initState();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        crmPromise = int.parse(widget.crmVwr.mchangoInfo.ahadi!);
        crmContribution = int.parse(widget.crmVwr.mchangoInfo.totalPayInfo!);

        if (crmPromise > crmContribution) {
          crmVwrDept = crmPromise - crmContribution;
        }
      });
    });
  }

  pay() {
    if (_contact.text.isNotEmpty) {
      if (_amount.text.isNotEmpty) {
        MchangoCall(payload: [], status: 0)
            .payment(token, urlMchangoPay, widget.crmVwr.mchangoInfo.id,
                _amount.text, widget.crmVwr.crmInfo.cId, _contact.text)
            .then((v) {
          if (v.status == 200) {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CrmnAdmin(
                          crm: widget.crmVwr.crmInfo,
                          user: widget.user,
                        )));
          }
        });
      } else {
        fillTheBlanks(
            context, 'Enter your amount please..?', header13, OColors.danger);
      }
    } else {
      fillTheBlanks(
          context, 'Enter your Contact please.?', header13, OColors.danger);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: osec,
      appBar: AppBar(
        backgroundColor: osec,
        actions: [
          GestureDetector(
            onTap: () {
              pay();
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(top: 12, bottom: 12, right: 10),
              decoration: BoxDecoration(
                  color: prmry, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Center(
                  child: Text(
                    'Pay',
                    style: header14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Little Information
          SizedBox(
            // height: 150,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Promise',
                        style: header16,
                      ),
                      crmPromise == 0
                          ? Text(
                              '0 Tsh',
                              style: payHdr2,
                            )
                          : Text(
                              '${crmPromise.toString()} Tsh',
                              style: payHdr2,
                            )
                    ],
                  ),
                  Column(children: [
                    Text('Contribution ', style: payHdr1),
                    crmContribution == 0
                        ? Text(
                            '0 Tsh',
                            style: payHdr2,
                          )
                        : Text(
                            '${crmContribution.toString()} Tsh',
                            style: payHdr2,
                          )
                  ]),
                  Column(children: [
                    Text(
                      'Remains',
                      style: payHdr1,
                    ),
                    crmVwrDept == 0
                        ? Text(
                            'No Dept',
                            style: payHdr2,
                          )
                        : Text(
                            '${crmVwrDept.toString()} Tsh',
                            style: payHdr2,
                          )
                  ])
                ],
              ),
            ),
          ),
          Container(
              width: size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Payment Method',
                    style: header18.copyWith(color: Colors.black)),
              )),
          Expanded(
            child: Container(
              width: size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vodacom',
                          style: header16.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        textFieldContainer(
                            context,
                            'Contact',
                            _contact,
                            MediaQuery.of(context).size.width / 1,
                            40,
                            10,
                            10,
                            OColors.white,
                            const Icon(Icons.currency_pound),
                            header14.copyWith(color: Colors.grey),
                            TextInputType.phone),
                        const SizedBox(
                          height: 10,
                        ),
                        textFieldContainer(
                            context,
                            'Amount',
                            _amount,
                            MediaQuery.of(context).size.width / 1,
                            40,
                            10,
                            10,
                            OColors.white,
                            const Icon(Icons.currency_pound),
                            header14.copyWith(color: Colors.grey),
                            TextInputType.number)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
