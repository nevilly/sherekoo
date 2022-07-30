import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import 'bsnTabs.dart';
import '../uploadScreens/busnessUpload.dart';

class BusnessScreen extends StatefulWidget {
  final String bsnType;
  final CeremonyModel ceremony;
  const BusnessScreen({Key? key, required this.bsnType, required this.ceremony})
      : super(key: key);

  @override
  State<BusnessScreen> createState() => _BusnessScreenState();
}

class _BusnessScreenState extends State<BusnessScreen> {
  CeremonyModel ceremony = CeremonyModel(
    cId: '',
    codeNo: '',
    ceremonyType: '',
    cName: '',
    fId: '',
    sId: '',
    cImage: '',
    ceremonyDate: '',
    admin: '',
    contact: '',
    u1: '',
    u1Avt: '',
    u1Fname: '',
    u1Lname: '',
    u1g: '',
    u2: '',
    u2Avt: '',
    u2Fname: '',
    u2Lname: '',
    u2g: '',
  );

  @override
  void initState() {
    ceremony = widget.ceremony;
    // print('cehek on bsn Screeen');
    // print(ceremony.codeNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.bsnType),
        ),
        body: Column(
          children: [
            const Text('Tia Neno'),
            Text(widget.bsnType),
            TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'All ' + widget.bsnType,
                  ),
                  Tab(
                    text: 'Best ' + widget.bsnType,
                  ),
                ]),
            Expanded(
                child: TabBarView(children: [
              BsnTab(
                bsnType: widget.bsnType,
                ceremony: ceremony,
              ),
              BsnTab(
                bsnType: widget.bsnType,
                ceremony: ceremony,
              ),
            ]))
          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          //objects will be added to the database when this button is clicked.
          onPressed: () {
            //this method is executed when the floating button is clicked
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BusnessUpload()));
          },

          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ), // This trailing comm
      ),
    );
  }
}
