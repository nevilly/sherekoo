import 'package:flutter/material.dart';

import '../../util/colors.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          tabs: const [
            Tab(
              text: 'OverView',
            ),
            Tab(
              text: 'Description',
            ),
            Tab(
              text: 'Schedule',
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Our Service'),
        ),
        body: Column(
          children: [
            ///
            /// Tabs
            ///

            PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.8))),
                child: ColoredBox(
                  color: OColors.darGrey,
                  child: _tabBar,
                ),
              ),
            ),

            Expanded(
                child: TabBarView(children: [
              Text('Over VIewer'),
              Text('Decription'),
              Text('Schedule'),
            ]))
          ],
        ),
      ),
    );
  }
}
