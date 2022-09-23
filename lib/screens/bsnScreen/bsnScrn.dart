import 'package:flutter/material.dart';
import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../../model/userModel.dart';
import '../../util/colors.dart';
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
    userFid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
                        userSid: User(id: '', username: '', firstname: '', lastname: '', avater: '', phoneNo: '',
                         email: '', gender: '', role: '', address: '', meritalStatus: '', bio: '', totalPost: '', 
                         isCurrentUser: '', isCurrentCrmAdmin: '', isCurrentBsnAdmin: '', totalFollowers: '', 
                         totalFollowing: '', totalLikes: ''),
    youtubeLink: '',
  );
  BusnessModel busness = BusnessModel(
      location: '',
      bId: '',
      knownAs: '',
      coProfile: '',
      busnessType: '',
    
      companyName: '',
      price: '',
      contact: '',
      hotStatus: '',
      aboutCEO: '',
      aboutCompany: '',
      createdDate: '',

      ceoId: '',
      subcrlevel: '', createdBy: '',  user: User(
              id: '',
              username: '',
              firstname: '',
              lastname: '',
              avater: '',
              phoneNo: '',
              email: '',
              gender: '',
              role: '',
              isCurrentUser: '',
              address: '',
              bio: '',
              meritalStatus: '',
              totalPost: '',
              isCurrentBsnAdmin: '',
              isCurrentCrmAdmin: '',
              totalFollowers: '',
              totalFollowing: '',
              totalLikes: '')
   );
  @override
  void initState() {
    ceremony = widget.ceremony;
    // print('cehek on bsn Screeen');
    // print(ceremony.codeNo);
    super.initState();
  }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: [
            Tab(
              text: 'All ${widget.bsnType}',
            ),
            Tab(
              text: 'Best ${widget.bsnType}',
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.appBarColor,
          title: Text(widget.bsnType),
        ),
        body: Column(
          children: [
            const Text(
              'ADS AREA',
              style: TextStyle(color: Colors.white),
            ),
            
              PreferredSize(
                  preferredSize: _tabBar.preferredSize,
                  child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 0.8))),
                      child: ColoredBox(color: OColors.darGrey, child: _tabBar))),
            
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
            ])),
          
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: OColors.primary,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BusnessUpload(
                          getData: busness,
                        )));
          },
          label: const Text('Busness +'),
          // child: const Icon(
          //   Icons.add,
          //   color: Colors.white,

          // ),
        ), // This trailing comm
      ),
    );
  }
}
