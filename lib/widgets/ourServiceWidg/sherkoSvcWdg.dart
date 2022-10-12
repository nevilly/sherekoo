import 'package:flutter/material.dart';

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
                              crm: ceremony,
                              user: user,
                            )));
              },
              child: ourServices(context, 'Order Cards')),

          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SherekoService(
                              from: 'MyBdayShow',
                            )));
              },
              child: ourServices(context, 'MyBday Tv Show')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SherekoService(
                              from: 'Mr&MrsMy',
                            )));
              },
              child: ourServices(context, 'Mr&Mrs Wangu Tv Show')),

          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SherekoService(
                              from: 'crmBundle',
                            )));
              },
              child: ourServices(context, 'Ceremony Bundle')),
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
