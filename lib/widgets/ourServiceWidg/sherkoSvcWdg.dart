import 'package:flutter/material.dart';

import '../../screens/ourServices/bigMonth-TvShow.dart';
import '../../screens/ourServices/mshengaWar-TvShow.dart';
import '../../screens/ourServices/sherekoCards.dart';
import '../../screens/ourServices/sherekoService.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';

class SherekooServices extends StatelessWidget {
  const SherekooServices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SherekoCards(
                              crm: emptyCrmModel,
                              user:emptyUser,
                            )));
              },
             
              child: ourServices(context, 'Order Cards')),

          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>  SherekoService(
                              from: 'crmBundle',
                              crm: emptyCrmModel,
                            )));
              },
              child: ourServices(context, 'Ceremony Bundle')),

          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const BigMonthTvShow(
                              from: '',
                            )));
              },
              child: ourServices(context, 'BigMonth Tv Show')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MshengaWarTvShow(
                              from: '&',
                            )));
              },
              child: ourServices(context, 'Mshenga War Tv Show')),

          // ourServices(context, 'Documentary make'),
          // ourServices(context, 'Tranport Bandle'),
          // ourServices(context, 'Dress Design'),
          // ourServices(context, 'Mc Booking'),
          // ourServices(context, 'Production'),
        ],
      ),
    );
  }
}
